import 'dart:ui';

import 'package:flutter/material.dart';
import 'main.dart';

 String playerO = "";
String playerX = "";

class PlayerScreen extends StatefulWidget {
  const PlayerScreen ({ Key? key }) : super(key: key);

  @override
  PlayerScreenState createState() => PlayerScreenState();
 
}

class PlayerScreenState extends State<PlayerScreen> {
    TextEditingController playernameO = TextEditingController();
    TextEditingController playernameX = TextEditingController();
   
    
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView( 
        children: [
          Container(color: Color.fromARGB(255, 1, 15, 65),
          height: 200,
          child: Image(
            image: AssetImage("assets/back.png"),
            height: 10,
            width: 10,
            )
          ),
          Center(
            child:
            Padding(
              padding: EdgeInsets.only(top: 70),
              child:  Text("PLAYERS", style: TextStyle(color: Color.fromARGB(255, 1, 15, 65),
              fontWeight: FontWeight.w700,
              fontSize: 25,
              fontFamily: 'Poppins',
              ),),
              ) 
          ),
         Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
         alignment: Alignment.bottomCenter,
          child: ListView(
            padding: EdgeInsets.only(top: 50),
             children: [
           TextFormField(
             cursorColor: Color.fromARGB(255, 1, 15, 65),
             controller: playernameX,
             decoration: InputDecoration(
               hintText: "Enter your username",
               hintStyle: TextStyle(color: Color.fromARGB(255, 0, 20, 86),  fontFamily: 'Poppins'),
               labelText: "Player X",
               labelStyle: TextStyle(color: Color.fromARGB(255, 0, 20, 86), fontFamily: 'Poppins'),
              //  floatingLabelBehavior: FloatingLabelBehavior.always
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color.fromARGB(255, 0, 20, 86),)
              ),
              prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 1, 15, 65),)
             ),
           ),
           Container(height: 50,),
             TextFormField(
               cursorColor: Color.fromARGB(255, 1, 15, 65),
               controller: playernameO,
             decoration: InputDecoration(
               hintText: "Enter your username",
                hintStyle: TextStyle(color: Color.fromARGB(255, 0, 20, 86), fontFamily: 'Poppins'),
               labelText: "Player O",
             labelStyle: TextStyle(color: Color.fromARGB(255, 0, 20, 86), fontFamily: 'Poppins'),
              //  floatingLabelBehavior: FloatingLabelBehavior.always
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color.fromARGB(255, 0, 20, 86),)                
              ),
              prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 1, 15, 65),)
             ),
           ),

          //  ElevatedButton.icon(
          //     onPressed: () {
          //       setState(() {
          //         playerO = playernameO.text.toString();
          //         playerX = playernameX.text.toString();
          //         playernameO.text = "";
          //         playernameX.text = "";
          //       });
          //       Navigator.push(context, MaterialPageRoute(builder: (context) => const GameScreen()));
          //     },
          //     icon: Icon(Icons.replay),
          //     label: Text("Repeat the Game"),
          //   ),
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: ElevatedButton(
                 onPressed: () {
               playerO = playernameO.text.toString();
               playerX = playernameX.text.toString();
               playernameO.text = "";
               playernameX.text = "";
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const MainApp()),
                );
            },
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 1, 15, 65),
               ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: const Text("Procced", style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w700)),
          ),
            )
          )
             ]
           ),
         ), 
        ],
      )       
      );
  }
}