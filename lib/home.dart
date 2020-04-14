import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';


class GameButton {
  final id;
  String text;
  Color bg;
  bool enabled;

  GameButton(
      {this.id, this.text = "", this.bg = Colors.grey, this.enabled = true});
}

enum Choice{ONE,TWO,THREE}

class Home extends StatefulWidget {

// Define variables and methods that will change here


  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {

  List<GameButton> buttonsList;
  var player1;
  var player2;
  var activePlayer;
  String infoLabel;
  var playing;
  static AudioCache playerA = new AudioCache();
  static AudioCache playerB = new AudioCache();
  int tieScore = 0;
  int humanScore = 0;
  int computerScore = 0;
  int _gameChoice=1;

  playLocalA() {
    playerA.play('sword.mp3');
  }

  playLocalB() {
    playerB.play('swish.mp3');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    player1 = new List();
    player2 = new List();
    activePlayer = 1;
    infoLabel = "       X's turn           ";
    playing = 1;

    var gameButtons = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
    ];
    return gameButtons;
  }


  void playGame(GameButton gb) {
    if (playing == 1) {
      setState(() {
        if (activePlayer == 1) {
          gb.text = "X";
          infoLabel = "X moved, O's turn";
          playLocalA();
          activePlayer = 2;
          player1.add(gb.id);
          for (int i = 0; i < player1.length; i++) {
            if (i == player1.length - 1)
              print("onPressed called. Card # " + player1[i].toString() +
                  " was pressed.");
          }
          displayBoard();
        } else {
          gb.text = "O";
          infoLabel = "O moved, X's turn";
          playLocalB();
          print("O moved, X's turn");
          activePlayer = 1;
          player2.add(gb.id);

          for (int i = 0; i < player2.length; i++) {
            if (i == player2.length - 1) {
              print("Computer's random move is " + player2[i].toString());
              print("Computer is making a random move to " +
                  player2[i].toString());
            }
          }

          displayBoard();
        }
        gb.enabled = false;

        int winner = checkWinner();
        if (winner == -1) {
          if (buttonsList.every((p) => p.text != "")) {
            //showDialog(
            //context: context,
            //builder: (_) => new CustomDialog("It's a tie.",
            //    "Press the reset button to start again.", resetGame));
            infoLabel = "       It's a tie.         ";
            print("It's a tie.");
            tieScore++;
          }
          else {
            activePlayer == 2 ? getComputerMove() : null;
          }
        }
      });
    }
  }

  void getComputerMove() {
    print(_gameChoice);
   if(_gameChoice==1)
    getRandomMove();

   if(_gameChoice==2){
     getBlockingMove();
   //  getRandomMove();
     }

    if(_gameChoice==3) {
      getWinningMove();
    //  getBlockingMove();
     // getRandomMove();
     }

  }

  void getRandomMove(){
    var emptyCells = new List();
    var list = new List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }

    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length - 1);
    var cellID = emptyCells[randIndex];
    int i = buttonsList.indexWhere((p) => p.id == cellID);
    playGame(buttonsList[i]);

    /*
    	// Generate random move
		do
		{
			move = mRand.nextInt(BOARD_SIZE);
		} while (mBoard[move] == HUMAN_PLAYER || mBoard[move] == COMPUTER_PLAYER);

		System.out.println("Computer is moving to " + (move + 1));

		mBoard[move] = COMPUTER_PLAYER;
	}
     */
  }

  void getBlockingMove(){
    //could not figure out blocking move code for my implentation, still filled out for completion's sake
    var emptyCells = new List();
    var list = new List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }

    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length - 1);
    var cellID = emptyCells[randIndex];
    int i = buttonsList.indexWhere((p) => p.id == cellID);
    playGame(buttonsList[i]);

//    for(int i=0; i<list.length; i++){
//      if (!(player1.contains(emptyCells) || player2.contains(emptyCells))) {
//        var curr = list[i];
//       emptyCells[i] = player1;
//      if(checkWinner()==1){
//        buttonsList[i] = player2;
//       print("Computer is moving to " + ((i+1).toString()));}
//       else
//         buttonsList[i]=curr;
//      }
//      }

    }
    /*
   // See if there's a move O can make to block X from winning
		for (int i = 0; i < BOARD_SIZE; i++) {
			if (mBoard[i] != HUMAN_PLAYER && mBoard[i] != COMPUTER_PLAYER) {
				char curr = mBoard[i];   // Save the current number
				mBoard[i] = HUMAN_PLAYER;
				if (checkForWinner() == 2) {
					mBoard[i] = COMPUTER_PLAYER;
					System.out.println("Computer is moving to " + (i + 1));
					return;
				}
				else
					mBoard[i] = curr;
			}
		}
    */


  void getWinningMove(){
    var emptyCells = new List();
    var list = new List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }

    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length - 1);
    var cellID = emptyCells[randIndex];
    int i = buttonsList.indexWhere((p) => p.id == cellID);
    playGame(buttonsList[i]);

    /*
		// First see if there's a move O can make to win
		for (int i = 0; i < BOARD_SIZE; i++) {
			if (mBoard[i] != HUMAN_PLAYER && mBoard[i] != COMPUTER_PLAYER) {
				char curr = mBoard[i];
				mBoard[i] = COMPUTER_PLAYER;
				if (checkForWinner() == 3) {
					System.out.println("Computer is moving to " + (i + 1));
					return;
				}
				else
					mBoard[i] = curr;
			}
		}
     */
  }


  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
    });
  }

  void resetScores() {
    tieScore = 0;
    humanScore = 0;
    computerScore = 0;
  }

  void displayBoard() {
    print("\n");
    print(buttonsList[0].text + " | " + buttonsList[1].text + " | " +
        buttonsList[2].text);
    print("-----------");
    print(buttonsList[3].text + " | " + buttonsList[4].text + " | " +
        buttonsList[5].text);
    print("-----------");
    print(buttonsList[6].text + " | " + buttonsList[7].text + " | " +
        buttonsList[8].text);
    print("\n");
  }

  int checkWinner() {
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }

    // row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    // row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    // col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    // col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    // col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        playing = -1;
        //showDialog(
        // context: context,
        // builder: (_) => new CustomDialog("X wins!",
        //      "Press the reset button to start again.", resetGame));
        setState(() {
          for (int i = 0; i < buttonsList.length; i++) {
            buttonsList[i].enabled ? () => playGame(buttonsList[i]) : null;
            onPressed:
            null;
          }
          //buttonsList[i].enabled ? () => playGame(buttonsList[i]) : null;
        });

        infoLabel = "       X wins!           ";
        print("X wins!");
        humanScore++;
      } else {
        playing = -1;

        infoLabel = "       O wins!           ";
        print("O wins!");
        computerScore++;
      }
    }

    return winner;
  }

  Future _aboutDialog(BuildContext context, String message) async {
    return showDialog( context: context,
        child: new AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.pop(context), child: new Text('Ok')) ], ) ); }

  Future _showSimpleDialog(BuildContext context, String message) async {
 //idk if this belongs
    switch (await showDialog( context: context, /*it shows a popup with few options which you can select, for option we created enums which we can use with switch statement, in this first switch will wait for the user to select the option which it can use with switch cases*/
        child: new SimpleDialog(
          title: new Text('Make a Choice'),
          children: <Widget>[ new SimpleDialogOption(
            child: new Text('One'), onPressed: () {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                content: Text('Difficulty Level = 1'),
                ));
              Navigator.pop(context, Choice.ONE); }, ), new SimpleDialogOption( child: new Text('Two'),
            onPressed: () {
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text('Difficulty Level = 2'),
                  ));
                Navigator.pop(context, Choice.TWO); }, ), new SimpleDialogOption( child: new Text('Three'),
            onPressed: () {
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text('Difficulty Level = 3'),
                  ));
                  Navigator.pop(context, Choice.THREE); }, ), ],))) {
      case Choice.ONE: _gameChoice = 1; break; case Choice.TWO: _gameChoice = 2; break; case Choice.THREE: _gameChoice = 3; break;} print('The selection was Choice = ' + '$_gameChoice'); }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildVerticalLayout()
              : _buildHorizontalLayout();
        },

      ),

    );

  }

  void showSnackBar(BuildContext context) {
    final scaffold = Scaffold.of(context);
    final snackBarContent = SnackBar(
      content: Text("sagar"),
      action: SnackBarAction(
          label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    );
    scaffold.showSnackBar(snackBarContent);
  }


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _buildVerticalLayout() {
    return new Scaffold(
    key: _scaffoldKey,
        appBar: new AppBar(

            leading: IconButton(
              icon: const Icon(Icons.grid_on),
              tooltip: 'Search',
              onPressed: () {},
            ),
            title: new Text("Tic Tac Toe"),

            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.play_arrow),
                tooltip: 'New Game',
                onPressed: () {
                  resetGame();
                },
              ),


              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'Reset Game Scores',
                onPressed: () {
                  setState(() {
                    resetScores();
                  });
                },
              ),

              IconButton(
                  icon: const Icon(Icons.power_settings_new),
                  tooltip: 'Quit Game',
                  onPressed: () {
                    setState(() {
                      exit(0);
                    });
                  }
              ),


               PopupMenuButton<int>(
              onSelected: (int result)
                    { setState((){
                      print(result);
                     if(result==1)
                      _aboutDialog(context, 'This is a simple tic-tac-toe game for Android and iOS. The buttons represent the game board and a text widget displays the game status. Moves are represented by an X for the human player and an O for the computer.');

                     if(result==2)
                        _showSimpleDialog(context, '');
                    }
                    );
                    },
                  // onSelected: (F)uture result)=> _aboutDialog(context, 'd'),



                   // if (result == 1) {onPressed: () => _aboutDialog(context, 'This is a simple tic-tac-toe game for Android and iOS. The buttons represent the game board and a text widget displays the game status. Moves are represented by an X for the human player and an O for the computer.');
                   //   child: new Text('Click me');
                 //   }
               //     if (result == 2) { }


                  itemBuilder: (context) =>
                  [

                    PopupMenuItem<int>(
                        value:1,
                        child: Text(
                          "About",

                          style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold,

                          ),
                        )
                    ),

                    PopupMenuItem(
                        value: 2,

                        child: Text(
                          "Settings",
                          style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold,
                          ),
                        )
                    ),


                  ]
              ),

            ]

        ),



        body: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              new Flexible(
                child: new GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 9.0,
                      mainAxisSpacing: 9.0),
                  itemCount: buttonsList.length,
                  itemBuilder: (context, i) =>
                  new SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: new RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      onPressed:

                      buttonsList[i].enabled
                          ? () => playGame(buttonsList[i])
                          : null,

                      child: new Text(
                        buttonsList[i].text,


                        style: new TextStyle(
                          color: Colors.black, fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),

                      ),
                      disabledColor: buttonsList[i].bg,


                    ),
                  ),
                ),
              ),
              //Turn Text

              Column(
                  mainAxisAlignment: MainAxisAlignment.center,


                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom:30),
                      child: new Text(infoLabel,

                          textAlign: TextAlign.center,

                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                            fontFamily: 'Roboto',

                          )),

                    )
                  ]),

              //Text scores
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Center(
                        child: new Text("Human:             ",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              fontFamily: 'Roboto',

                            ))),

                    Center(
                        child: new Text(humanScore.toString(),
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              fontFamily: 'Roboto',
                            ))),
                  ]),

              Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Padding(
                        padding: const EdgeInsets.symmetric(vertical:8),
                        child: new Text("Computer:        ",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              fontFamily: 'Roboto',

                            ))),

                    Padding(
                        padding: const EdgeInsets.symmetric(vertical:8),
                        child: new Text(computerScore.toString(),
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              fontFamily: 'Roboto',
                            ))),
                  ]),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[


                      Padding(
                          padding: const EdgeInsets.only(bottom:90),
                        child: new Text("Ties:                  ",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              fontFamily: 'Roboto',

),
                            )),

                    Padding(
                        padding: const EdgeInsets.only(bottom:90),
                        child: new Text(tieScore.toString(),
                            textAlign: TextAlign.right,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              fontFamily: 'Roboto',
                            ))),
                  ]),


            ]));
  }

  _buildHorizontalLayout() {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(

            leading: IconButton(
              icon: const Icon(Icons.grid_on),
              tooltip: 'Search',
              onPressed: () {},
            ),
            title: new Text("Tic Tac Toe"),

            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.play_arrow),
                tooltip: 'New Game',
                onPressed: () {
                  resetGame();
                },
              ),


              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'Reset Game Scores',
                onPressed: () {
                  setState(() {
                    resetScores();
                  });
                },
              ),

              IconButton(
                  icon: const Icon(Icons.power_settings_new),
                  tooltip: 'Quit Game',
                  onPressed: () {
                    setState(() {
                      exit(0);
                    });
                  }
              ),


              PopupMenuButton<int>(
                  onSelected: (int result)
                  { setState((){
                    if(result==1)
                      _aboutDialog(context, 'This is a simple tic-tac-toe game for Android and iOS. The buttons represent the game board and a text widget displays the game status. Moves are represented by an X for the human player and an O for the computer.');

                    if(result==2)
                      _showSimpleDialog(context, '');
                  }
                  );
                  },
                  itemBuilder: (context) =>
                  [

                    PopupMenuItem(
                        value: 1,
                        child: Text(
                          "About",

                          style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold,
                          ),
                        )
                    ),

                    PopupMenuItem(
                        value: 2,
                        child: Text(
                          "Settings",
                          style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold,
                          ),
                        )
                    ),


                  ]
              ),

            ]

        ),



        body: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Flexible(
                child: new GridView.builder(
                  padding: const EdgeInsets.all(20.0),
                  shrinkWrap: true,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.8,
                      crossAxisSpacing: 9.0,
                      mainAxisSpacing: 9.0),
                  itemCount: buttonsList.length,
                  itemBuilder: (context, i) =>
                  new SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: new RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      onPressed:

                      buttonsList[i].enabled
                          ? () => playGame(buttonsList[i])
                          : null,

                      child: new Text(
                        buttonsList[i].text,


                        style: new TextStyle(
                          color: Colors.black, fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),

                      ),
                      disabledColor: buttonsList[i].bg,


                     ),
                  ),
                ),


              ),



          new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
              Row(


                  children: <Widget>[


                    Padding(
                      padding: const EdgeInsets.only(bottom:70),
                      child: new Text(infoLabel,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                            fontFamily: 'Roboto',

                          )),

                    )
                  ]),

              //Text scores
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Padding(
                        padding: const EdgeInsets.symmetric(vertical:8),
                        child: new Text("Human:         ",
                            textAlign: TextAlign.center,

                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              fontFamily: 'Roboto',


                            ))),

                    Padding(
                        padding: const EdgeInsets.symmetric(vertical:8),
                        child: new Text(humanScore.toString(),
                            textAlign: TextAlign.right,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              fontFamily: 'Roboto',
                            ))),
                  ]),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Padding(
                        padding: const EdgeInsets.symmetric(vertical:8),
                        child: new Text("Computer:    ",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              fontFamily: 'Roboto',

                            ))),

                    Padding(
                        padding: const EdgeInsets.symmetric(vertical:8),
                        child: new Text(computerScore.toString(),
                            textAlign: TextAlign.right,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              fontFamily: 'Roboto',
                            ))),
                  ]),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Padding(
                        padding: const EdgeInsets.symmetric(vertical:10),
                        child: new Text("Ties:              ",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              fontFamily: 'Roboto',

                            ))),

                    Padding(
                        padding: const EdgeInsets.symmetric(vertical:10),

                        child: new Text(tieScore.toString(),
                            textAlign: TextAlign.right,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              fontFamily: 'Roboto',
                            ))),
                  ]),
         ])

            ]));
  }

}






