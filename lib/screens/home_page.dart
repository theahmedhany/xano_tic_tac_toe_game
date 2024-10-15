import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xano_tic_tac_toe_game/constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];

  List<int> matchedIndexes = [];
  int attempts = 0;

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  String resultDeclaration = '';
  bool winnerFound = false;

  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSeconds;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            SafeArea(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        color: MainColor.fontcolor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Player O',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: MainColor.primaryColor,
                            ),
                          ),
                          Text(
                            oScore.toString(),
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: MainColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        color: MainColor.secondfontcolor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Player X',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: MainColor.primaryColor,
                            ),
                          ),
                          Text(
                            xScore.toString(),
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: MainColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 3,
              child: Center(
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 5,
                            color: MainColor.primaryColor,
                          ),
                          color: matchedIndexes.contains(index)
                              ? MainColor.whiteColor
                              : MainColor.secondaryColor,
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          displayXO[index],
                          style: TextStyle(
                            fontSize: 95,
                            fontFamily: 'POUTTU',
                            fontWeight: FontWeight.bold,
                            color: displayXO[index] == 'X'
                                ? MainColor.secondfontcolor
                                : displayXO[index] == 'O'
                                    ? MainColor.fontcolor
                                    : MainColor.secondaryColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    resultDeclaration,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTimer()
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;

    if (isRunning) {
      setState(() {
        if (oTurn && displayXO[index] == '') {
          displayXO[index] = 'O';
          filledBoxes++;
        } else if (!oTurn && displayXO[index] == '') {
          displayXO[index] = 'X';
          filledBoxes++;
        }

        oTurn = !oTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    // check first row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0, 1, 2]);
        stopTimer();
        _updateScore(displayXO[0]);
        winnerFound = true;
      });
    }

    // check second row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[3] + ' Wins!';
        matchedIndexes.addAll([3, 4, 5]);
        stopTimer();
        _updateScore(displayXO[3]);
        winnerFound = true;
      });
    }

    // check third row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' Wins!';
        matchedIndexes.addAll([6, 7, 8]);
        stopTimer();
        _updateScore(displayXO[6]);
        winnerFound = true;
      });
    }

    // check first column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0, 3, 6]);
        stopTimer();
        _updateScore(displayXO[0]);
        winnerFound = true;
      });
    }

    // check second column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[1] + ' Wins!';
        matchedIndexes.addAll([1, 4, 7]);
        stopTimer();
        _updateScore(displayXO[1]);
        winnerFound = true;
      });
    }

    // check third column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[2] + ' Wins!';
        matchedIndexes.addAll([2, 5, 8]);
        stopTimer();
        _updateScore(displayXO[2]);
        winnerFound = true;
      });
    }

    // check first diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0, 4, 8]);
        stopTimer();
        _updateScore(displayXO[0]);
        winnerFound = true;
      });
    }

    // check second diagonal
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' Wins!';
        matchedIndexes.addAll([6, 4, 2]);
        stopTimer();
        _updateScore(displayXO[6]);
        winnerFound = true;
      });
    }

    // Nobody Wins
    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Nobody Wins!';
        stopTimer();
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      resultDeclaration = '';
      matchedIndexes = [];
      winnerFound = false;
    });
    filledBoxes = 0;
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: MainColor.secondaryColor,
                ),
                Center(
                  child: Text(
                    '$seconds',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
              ],
            ),
          )
        : CupertinoButton(
            onPressed: () {
              startTimer();
              _clearBoard();
              attempts++;
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: MainColor.accentColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                textAlign: TextAlign.center,
                attempts == 0 ? 'Start' : 'Play Again!',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Fredoka',
                  fontWeight: FontWeight.w600,
                  color: MainColor.primaryColor,
                ),
              ),
            ),
          );
  }
}
