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
  var selectedIndex = 1;

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
                    Container(
                      alignment: Alignment.center,    // text aligment
                      margin: EdgeInsets.all(10),
                      child: const Text(
                            "Create Lobby",
                            style: TextStyle(height: 1, fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),



                    Stack(
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
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              label: "play",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: "informations"
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