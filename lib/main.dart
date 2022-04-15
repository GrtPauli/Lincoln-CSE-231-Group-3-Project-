import 'dart:io';

import 'package:flutter/material.dart';
import '/ui/theme/color.dart';
import '/utils/game_logic.dart';
import './playerscreen.dart';
import './restart.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PlayerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Restart extends StatelessWidget {
  const Restart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RestartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

 Widget PlayerList(String image, String name)
  {
     return Padding
     (
       
        padding:  const EdgeInsets.only(top:5, bottom: 0, left: 10),
        child: ListTile
        (
          leading: CircleAvatar
          (
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            backgroundImage: AssetImage(image),
            radius: 20.0,
          ),
          title: Text(name, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0, color: Colors.white, fontFamily: 'Poppins'),),
          // subtitle: Text(someText, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),) ,
           
        ),
        
     );
 
  }

  //adding the necessary variables
  String lastValue = "X";
  bool gameOver = false;
  String name = playerX;
  int turn = 0; // to check the draw
  String result = "";
  List<int> scoreboard = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ]; //the score are for the different combination of the game [Row1,2,3, Col1,2,3, Diagonal1,2];
  //let's declare a new Game components

  Game game = Game();

  //let's initi the GameBoard
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;

    return Scaffold(
       appBar: AppBar
      (
        leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const MyApp()),
                );
                },
              );
            }),

        title: Image(
                image: AssetImage("assets/back2.png"),
                ), 
        backgroundColor: Color.fromARGB(255, 1, 15, 65),
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18.0),
        

          actions: <Widget>[
        
          IconButton(
            icon: Icon(Icons.exit_to_app),
            color: Colors.white,
            onPressed: () {
              exit(0);
            },
          )
        ],
      ),
        backgroundColor: MainColor.primaryColor,
        body: ListView(
          children: [
              Container(color: Color.fromARGB(255, 1, 15, 65),
              height: 190,
              child: ListView(
                children: [
             PlayerList("assets/x.png", "$playerX"),
             PlayerList("assets/o.png", "$playerO"),
             Center(
               child: Padding(padding: EdgeInsets.only(top: 20),
               child:
               Text(
              "It's ${name} turn",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Poppins'
              ),
            ),
               ),
             )
             
                ]
              )
              ),

            Column(
               mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
            // Padding(
            //   padding: EdgeInsets.only(top: 30, left: 70),
            //   child: Text("Number Of Wins",style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11.0, color: Colors.white),),
            //    ),
           
            
           
            //now we will make the game board
            //but first we will create a Game class that will contains all the data and method that we will need
            Container(
              width: boardWidth,
              height: boardWidth,
              child: GridView.count(
                crossAxisCount: Game.boardlenth ~/
                    3, // the ~/ operator allows you to evide to integer and return an Int as a result
                padding: EdgeInsets.only(left:30.0, right:30.0, top: 30, bottom: 0),
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                children: List.generate(Game.boardlenth, (index) {
                  return InkWell(
                    onTap: gameOver
                        ? null
                        : () {

                            if (game.board![index] == "") {
                              setState(() {
                                game.board![index] = lastValue;
                                turn++;
                                gameOver = game.winnerCheck(
                                    lastValue, index, scoreboard, 3);

                                if (gameOver) {
                                  result = "$name won this round";
                                } else if (!gameOver && turn == 9) {
                                  result = "It's a Draw!";
                                  gameOver = true;
                                }
                                if (lastValue == "X")
                                  lastValue = "O";
                                else
                                  lastValue = "X";

                                if(lastValue == "X")
                                name = playerX;
                                else
                                name = playerO;

                              });
                            }
                          },
                    child: Container(
                      width: Game.blocSize,
                      height: Game.blocSize,
                      decoration: BoxDecoration(
                        color: MainColor.secondaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                            color: game.board![index] == "X"
                                ? Colors.blue
                                : Colors.pink,
                            fontSize: 50.0,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 5),
            child: 
            Text(
              result,
              style: TextStyle(color: Color.fromARGB(255, 1, 15, 65), fontSize: 20.0, fontFamily: 'Poppins'),
            ),
            ),
          
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  //erase the board
                  game.board = Game.initGameBoard();
                  lastValue = "X";
                  gameOver = false;
                  turn = 0;
                  result = "";
                  name = playerX;
                  scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
                });
              },
               style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 1, 15, 65),
                 padding: EdgeInsets.all(10),
               ),
              icon: Icon(Icons.replay),
              label: Text("Repeat the Game"),
            ),
          ],
          
            ),
            ]
        ));
    //the first step is organise our project folder structure
  }
}


