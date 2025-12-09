import 'package:flutter/material.dart';

import 'UIElements/customAppBar.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Imposter Game"),
      body: Center(
        child: Text(
          "Info page",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );
  }
}