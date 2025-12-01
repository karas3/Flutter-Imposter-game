import 'package:flutter/material.dart';

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
    return Center(      // centers elements
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            height: 100,
            width: 350,
            decoration: BoxDecoration(                                // style of entire rectangle
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              color: const Color.fromARGB(255, 197, 197, 197),
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
//==================================    Small Color Stripe   ================================== 
                Container(                     
                  margin: EdgeInsets.only(left: 20.0),
                  height: 100,
                  width: 40,
                  decoration: BoxDecoration(                          
                    color: const Color.fromARGB(255, 0, 110, 255),
                  ),
                ),
//==================================    Container for input field   ==================================
                Container(                        
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 5),
                  width: 210,
                  height: 100,
                  child: TextFormField(                   //input field
                    decoration: const InputDecoration(
                      hintText: "Input player 1",
                      border: UnderlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontSize: 24
                    ),
                  ),
                ),
//==================================    Delete button   ==================================
                OutlinedButton(
                  onPressed: () {

                  }, 
                  style: ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(Size.zero),
                    fixedSize: WidgetStatePropertyAll(const Size(40, 40)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                    side: WidgetStatePropertyAll(BorderSide(                                                                // set border width and color
                      width: 3.5,
                      color: Colors.red,
                    )),
                  ),
                  child: Icon(
                    size: 40,
                    Icons.close,
                    color: Colors.red,
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}




class AddPlayerButton extends StatelessWidget {
  final Function callbackFunction;
  const AddPlayerButton({super.key, required this.callbackFunction});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        callbackFunction();
      },
      style: ButtonStyle(
        fixedSize: WidgetStatePropertyAll(const Size(350, 100)),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
        side: WidgetStatePropertyAll(BorderSide(                                                                // set border width and color
          width: 3.5,
          color: Color.fromARGB(52, 0, 0, 0),
          )),
      ),
      child: Icon(
        Icons.add,
        color: Colors.grey,
        size: 75,
        ),
    );
  }
}