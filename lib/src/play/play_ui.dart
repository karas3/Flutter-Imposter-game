import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imposter_party_game/src/category_managment/category_object.dart';
import 'package:imposter_party_game/src/lobby/lobby_object.dart';
import 'package:imposter_party_game/src/ui_elements/dialogs.dart';
import 'package:provider/provider.dart';
import '../game/game_page.dart';


class PlayPageButton extends StatelessWidget {
  final String title;
  final Widget nextPage;
  final VoidCallback? rebuildPage;

  const PlayPageButton({super.key,
    required this.title,
    required this.nextPage,
    this.rebuildPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: OutlinedButton(
        style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll(Size(300, 100))
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ChangeNotifierProvider.value(
            value: context.read<CategoriesList>(),
            child: nextPage,
            ))
          ).then((_) => rebuildPage?.call()); // rebuild page to update imposter counter, player count and if any category selected for later to check before game starts
        },
        child: Text(
          title,
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}

class ImposterCounter extends StatefulWidget {
  const ImposterCounter({super.key});

  @override
  State<ImposterCounter> createState() => _ImposterCounterState();
}

class _ImposterCounterState extends State<ImposterCounter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Text(
            "Imposter count",
            style: TextStyle(
              fontSize: 30
            ),
          ),
          Row(
            spacing: 30,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => setState(() {
                  Lobby.decreaseImposterCount();
                }),
                icon: Icon(
                  Icons.remove,
                  size: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
          
              Text(
                Lobby.imposterCount.toString(),
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
          
              IconButton(
                onPressed: () => setState(() {
                  Lobby.increaseImposterCount();
                }),
                icon: Icon(
                  Icons.add,
                  size: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            "(Imposter count depends on player count)",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
          )
        ],
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  Future<void> dialogBuilder(BuildContext context, String title, String description) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return WarningDialog(title: title,description: description);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: context.read<CategoriesList>().isAnySelected,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FilledButton(
            onPressed: () {
              if(Lobby.numberOfPlayers < 3) {
                dialogBuilder(context, "Not enough players!", "Can't start game with only ${Lobby.numberOfPlayers} players. Atleast 3 players are requiered.");
              } else if(!snapshot.data!) { // If no category selected
                dialogBuilder(context, "No categories selected!", "Can't start game without any category. Select atleast one category to start game.");
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ChangeNotifierProvider.value(
                    value: context.read<CategoriesList>(),
                    child: GamePage(),
                  ))
                );
              }
            },
            style: ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.zero),
            ),
            child: Ink(
               decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color.fromARGB(255, 80, 30, 206), Color.fromARGB(255, 255, 85, 136)], transform: GradientRotation(pi/4)),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Container(
                margin: EdgeInsets.zero,
                constraints: const BoxConstraints(maxWidth: 250, maxHeight: 60), // min sizes for Material buttons
                alignment: Alignment.center,
                child: const Text(
                  "Start game",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )
              ),
            ),
          );

          } else if (snapshot.hasError) {
            return Center(
              child: const Text(
                "Error while loading selected Categories",
                style: TextStyle(fontSize: 24),
              ),
            );
          } else {
            return Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Awaiting result...',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ]
          );
        }
      }
    );
  }
}