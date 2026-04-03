import 'package:flutter/material.dart';
import '../lobby/lobby.dart';
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
            MaterialPageRoute(builder: (context) => nextPage)
          ).then((_) => rebuildPage?.call()); // rebuild page to update imposter counter
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
            mainAxisAlignment: MainAxisAlignment.center,  //centers row chil
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

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GamePage())
        );
      },
      child: Text(
        "Start game",
      )
    );
  }

}