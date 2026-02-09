import 'package:flutter/material.dart';
import '../lobby/lobby.dart';

class PlayPageButton extends StatelessWidget {
  final String title;
  final Widget nextPage;

  const PlayPageButton({super.key,
    required this.title,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: FilledButton.tonal(
        style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll(Size(300, 100))
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextPage)
          );
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
              FilledButton.tonal(
                onPressed: () => setState(() {
                  Lobby.decreaseImposterCount();
                }),
                child: Icon(
                  Icons.remove,
                  size: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
          
              Text(
                Lobby.getImposterCount().toString(),
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
          
              FilledButton.tonal(
                onPressed: () => setState(() {
                  Lobby.increaseImposterCount();
                }),
                child: Icon(
                  Icons.add,
                  size: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}