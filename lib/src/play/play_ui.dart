import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imposter_party_game/src/category_managment/category_object.dart';
import 'package:imposter_party_game/src/lobby/lobby_object.dart';
import 'package:imposter_party_game/src/ui_elements/custom_text.dart';
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
          style: AppTextStyles.standard,
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
            style: AppTextStyles.standard,
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
                style: AppTextStyles.standard
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
            style: AppTextStyles.hint(context),
          )
        ],
      ),
    );
  }
}

class ShufflePlayersCheckBox extends StatefulWidget {
  const ShufflePlayersCheckBox({super.key});

  @override
  State<ShufflePlayersCheckBox> createState() => _ShufflePlayersCheckBoxState();
}

class _ShufflePlayersCheckBoxState extends State<ShufflePlayersCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Shuffle players:",
            style: AppTextStyles.standard,
          ),
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              value: isChecked, 
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
              semanticLabel: "Shuffle players",
            ),
          ),
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
          return Container(
            margin: EdgeInsets.only(top: 20),
            child: FilledButton(
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
                  child: Text(
                    "Start game",
                    style: AppTextStyles.standard,
                  )
                ),
              ),
            ),
          );

          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error while loading selected Categories",
                style: AppTextStyles.standard,
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
                  style: AppTextStyles.standard,
                ),
              ),
            ]
          );
        }
      }
    );
  }
}