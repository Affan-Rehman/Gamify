import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gamify/minesweeper/board_square.dart';

import '../MyApp/gamescreen.dart';

// Types of images available
enum ImageType {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  bomb,
  facingDown,
  flagged,
}

class MineSweeperScreen extends StatefulWidget {
  @override
  _GameActivityState createState() => _GameActivityState();
}

class _GameActivityState extends State<MineSweeperScreen> {
  // Row and column count of the board
  int rowCount = 18;
  int columnCount = 10;

  // The grid of squares
  late List<List<BoardSquare>> board;

  // "Opened" refers to being clicked already
  List<bool> openedSquares = [];

  // A flagged square is a square a user has added a flag on by long pressing
  List<bool> flaggedSquares = [];

  // Probability that a square will be a bomb
  int bombProbability = 3;
  int maxProbability = 15;

  int bombCount = 0;
  int squaresLeft = 0;

  @override
  void initState() {
    super.initState();
    _initialiseGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.grey,
            height: 60.0,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.grey[300]!;
                        }
                        return Colors.transparent;
                      },
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.green],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "EXIT",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _initialiseGame();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.yellowAccent,
                    child: Icon(
                      Icons.tag_faces,
                      color: Colors.black,
                      size: 40.0,
                    ),
                  ),
                )
              ],
            ),
          ),
          // The grid of squares
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnCount,
            ),
            itemBuilder: (context, position) {
              // Get row and column number of square
              int rowNumber = (position / columnCount).floor();
              int columnNumber = (position % columnCount);

              Image image;

              if (openedSquares[position] == false) {
                if (flaggedSquares[position] == true) {
                  image = getImage(ImageType.flagged);
                } else {
                  image = getImage(ImageType.facingDown);
                }
              } else {
                if (board[rowNumber][columnNumber].hasBomb) {
                  image = getImage(ImageType.bomb);
                } else {
                  image = getImage(
                    getImageTypeFromNumber(
                        board[rowNumber][columnNumber].bombsAround),
                  );
                }
              }

              return InkWell(
                // Opens square
                onTap: () {
                  if (board[rowNumber][columnNumber].hasBomb) {
                    _handleGameOver();
                  }
                  if (board[rowNumber][columnNumber].bombsAround == 0) {
                    _handleTap(rowNumber, columnNumber);
                  } else {
                    setState(() {
                      openedSquares[position] = true;
                      squaresLeft = squaresLeft - 1;
                    });
                  }

                  if (squaresLeft <= bombCount) {
                    _handleWin();
                  }
                },
                // Flags square
                onLongPress: () {
                  if (openedSquares[position] == false) {
                    setState(() {
                      flaggedSquares[position] = true;
                    });
                  }
                },
                splashColor: Colors.grey,
                child: Container(
                  color: Colors.grey,
                  child: image,
                ),
              );
            },
            itemCount: rowCount * columnCount,
          ),
        ],
      ),
    );
  }

  // Initialises all lists
  void _initialiseGame() {
    // Initialise all squares to having no bombs
    board = List.generate(rowCount, (i) {
      return List.generate(columnCount, (j) {
        return BoardSquare();
      });
    });

    // Initialise list to store which squares have been opened
    openedSquares = List.generate(rowCount * columnCount, (i) {
      return false;
    });

    flaggedSquares = List.generate(rowCount * columnCount, (i) {
      return false;
    });

    // Resets bomb count
    bombCount = 0;
    squaresLeft = rowCount * columnCount;

    // Randomly generate bombs
    Random random = Random();
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        int randomNumber = random.nextInt(maxProbability);
        if (randomNumber < bombProbability) {
          board[i][j].hasBomb = true;
          bombCount++;
        }
      }
    }

    // Check bombs around and assign numbers
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        if (i > 0 && j > 0) {
          if (board[i - 1][j - 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i > 0) {
          if (board[i - 1][j].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i > 0 && j < columnCount - 1) {
          if (board[i - 1][j + 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (j > 0) {
          if (board[i][j - 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (j < columnCount - 1) {
          if (board[i][j + 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i < rowCount - 1 && j > 0) {
          if (board[i + 1][j - 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i < rowCount - 1) {
          if (board[i + 1][j].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i < rowCount - 1 && j < columnCount - 1) {
          if (board[i + 1][j + 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }
      }
    }

    setState(() {});
  }

  // This function opens other squares around the target square which don't have any bombs around them.
  // We use a recursive function which stops at squares which have a non zero number of bombs around them.
  void _handleTap(int i, int j) {
    int position = (i * columnCount) + j;
    openedSquares[position] = true;
    squaresLeft = squaresLeft - 1;

    if (i > 0) {
      if (!board[i - 1][j].hasBomb &&
          openedSquares[((i - 1) * columnCount) + j] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i - 1, j);
        }
      }
    }

    if (j > 0) {
      if (!board[i][j - 1].hasBomb &&
          openedSquares[(i * columnCount) + j - 1] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i, j - 1);
        }
      }
    }

    if (j < columnCount - 1) {
      if (!board[i][j + 1].hasBomb &&
          openedSquares[(i * columnCount) + j + 1] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i, j + 1);
        }
      }
    }

    if (i < rowCount - 1) {
      if (!board[i + 1][j].hasBomb &&
          openedSquares[((i + 1) * columnCount) + j] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i + 1, j);
        }
      }
    }

    setState(() {});
  }

  // Function to handle when a bomb is clicked.
  void _handleGameOver() {
    setState(() {});
    _initialiseGame();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Game Over!"),
          content: const Text("You stepped on a mine!"),
          actions: <Widget>[
            TextButton(
                  onPressed: () {
                    _initialiseGame();
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.grey[300]!;
                        }
                        return Colors.transparent;
                      },
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.green],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Play Again",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                 TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => GameScreen()),
                      (route) => false);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.grey[300]!;
                        }
                        return Colors.transparent;
                      },
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.green],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "EXIT",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                
          ],
        );
      },
    );
  }

  void _handleWin() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Congratulations!"),
          content: const Text("You Win!"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen()),
                    (route) => false);
              },
              child: const Text("Exit"),
            ),
          ],
        );
      },
    );
  }

  Image getImage(ImageType type) {
    switch (type) {
      case ImageType.zero:
        return Image.asset('assets/images/empty.png');
      case ImageType.one:
        return Image.asset('assets/images/mine1.png');
      case ImageType.two:
        return Image.asset('assets/images/mine2.png');
      case ImageType.three:
        return Image.asset('assets/images/3.png');
      case ImageType.four:
        return Image.asset('assets/images/4.png');
      case ImageType.five:
        return Image.asset('assets/images/5.png');
      case ImageType.six:
        return Image.asset('assets/images/6.png');
      case ImageType.seven:
        return Image.asset('assets/images/7.png');
      case ImageType.eight:
        return Image.asset('assets/images/8.png');
      case ImageType.bomb:
        return Image.asset('assets/images/bomb.png');
      case ImageType.facingDown:
        return Image.asset('assets/images/facingDown.png');
      case ImageType.flagged:
        return Image.asset('assets/images/flagged.png');
    }
  }

  ImageType getImageTypeFromNumber(int number) {
    switch (number) {
      case 0:
        return ImageType.zero;
      case 1:
        return ImageType.one;
      case 2:
        return ImageType.two;
      case 3:
        return ImageType.three;
      case 4:
        return ImageType.four;
      case 5:
        return ImageType.five;
      case 6:
        return ImageType.six;
      case 7:
        return ImageType.seven;
      case 8:
        return ImageType.eight;
      default:
        return ImageType.eight;
    }
  }
}
