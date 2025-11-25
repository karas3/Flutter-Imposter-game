import 'package:flutter/material.dart';

import 'src/pre_sets.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String animal = "Click + to generate random animal";

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      theme: ThemeData(useMaterial3: false, scaffoldBackgroundColor: const Color.fromARGB(255, 228, 228, 228)),   //page backgroundcolor
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 50, 125, 175),   //top bar color
          centerTitle: true,
          title: const Text("Imposter Game"),   // text on top bar
          elevation: 20,  //Set shadow on top bar
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              animal = PreSets().getRandomAnimal();
            });
          },
        ),

        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                offset: Offset(3, 3),
                                blurRadius: 5,
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: const Text(
                            "Hello World!",
                            style: TextStyle(height: 1, fontSize: 48),
                          ),
                        ),
                        Positioned(top: 20,  left: 280, child: Icon(Icons.verified)),
                      ],
                    ),
            
                    Container(
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
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),


        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: "menu"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "settings"
            ),
          ]
        ),


        drawer: Drawer(
          child: Text("Cos"),
        ),
      ),
    );
  }
}