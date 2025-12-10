import 'package:flutter/material.dart';

class LobbyPlayerInputTile extends StatefulWidget {
  final Function removeCallbackFunction;
  final TextEditingController controller;
  final Color color;
  final int id;

  const LobbyPlayerInputTile({
    required this.removeCallbackFunction,   
    required this.controller,       // Makes input persistent for shifting  
    required this.color,
    required this.id,  // to remove object later
  });

  @override
  State<LobbyPlayerInputTile> createState() => LobbyPlayerInputTileState();
}

class LobbyPlayerInputTileState extends State<LobbyPlayerInputTile> {
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
                  offset: Offset(4, 4),
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
                    color: widget.color,
                  ),
                ),
//==================================    Container for input field   ==================================
                Container(                        
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 5),
                  width: 210,
                  height: 100,
                  child: TextFormField(                   //input field
                    controller: widget.controller,
                    decoration: InputDecoration(
                      hintText: "Input player " + (widget.id + 1).toString(),
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
                    widget.removeCallbackFunction();
                  }, 
                  style: ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(Size.zero),
                    fixedSize: WidgetStatePropertyAll(const Size(40, 40)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                    side: WidgetStatePropertyAll(BorderSide(  // set border width and color
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



//==================================    Add player button (grey transparent one)   ==================================
class AddPlayerButton extends StatelessWidget {
  final Function addPlayercallback;
  const AddPlayerButton({required this.addPlayercallback});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        addPlayercallback();
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

//==================================    Start button (Green at bottom of page)   ==================================
class StartButton extends StatefulWidget {
  final Widget nextPage;

  StartButton({
    required this.nextPage,
  });

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  final borderRadius = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, top: 15),  // move button a little bit from bottom of page
      decoration: BoxDecoration( 
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(  
            color: const Color.fromARGB(255, 0, 0, 0),
            offset: Offset(4, 4),
            blurRadius: 5,
            spreadRadius: 0,
          )
        ],
      ),

      child: FilledButton(
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => widget.nextPage,
            ),
          );
        },
        style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll(const Size(250, 75)),
          backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 66, 175, 33)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius))),
          side: WidgetStatePropertyAll(BorderSide(                                                                // set border width and color
            width: 5,
            color: Color.fromARGB(255, 33, 136, 1),
          )),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 4), // Centers text
          child: Text(
            "START",
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Color.fromARGB(179, 1, 49, 8)),
            textAlign: TextAlign.center,
          ),
        )
      ),
    );
  }
}