import 'package:flutter/material.dart';

String animal = "Click + to generate random animal";

class LobbyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,    // text aligment
      margin: EdgeInsets.all(10),
      child: const Text(
            "Create Lobby",
            style: TextStyle(height: 1, fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class LobbyPlayerInputTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          height: 100,
          width: 350,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 167, 167, 167),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0),
                offset: Offset(3, 3),
                blurRadius: 5,
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            children: [
              Container(    // small color stripe
                margin: EdgeInsets.only(left: 20.0),
                height: 100,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 110, 255),
                ),
              ),
              Container(    // Container for input field
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20),
                width: 240,
                height: 100,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Input player 1",
                    border: UnderlineInputBorder(),
                  ),
                  style: TextStyle(
                    fontSize: 24
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LobbyTestBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.red,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0),
            offset: Offset(3, 3),
            blurRadius: 5,
            spreadRadius: 0,
          )
        ],
      ),
      child: Text(
        animal,
        style: TextStyle(height: 1, fontSize: 48),
      ),
    );
  }
}