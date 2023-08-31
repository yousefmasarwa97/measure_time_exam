import 'package:excel_example/user_sheets_api.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  static Future<int> getLastRaw() async {
    final res = await UserSheetsApi.getRowCount() + 1;
    return res;
  }

  @override
  State<GamePage> createState() => _GamePageState();
}

bool isRed = false;
bool isRightArrow = false;
bool isRanbow = false;
int correctAnswers = 0;
int wrongAnswers = 0;
Color containerColor = Colors.grey;
int currentTimeInNanoseconds = getCurrentTimeInNanoseconds();
int previousTimeInNanoseconds = getCurrentTimeInNanoseconds();

// return the time in nanoseconds
int getCurrentTimeInNanoseconds() {
  int currentTimeMicroseconds = DateTime.now().microsecondsSinceEpoch;
  int currentTimeNanoseconds = currentTimeMicroseconds * 1000;
  return currentTimeNanoseconds;
}

int getTime(int time) {
  final currentTimeMicroseconds = DateTime.now().microsecondsSinceEpoch;
  final currentTimeNanoseconds = currentTimeMicroseconds * 1000;
  return currentTimeNanoseconds - time;
}

// return random arrow (left or right)
Icon getRandomArrow() {
  Random random = Random();
  int choice = random.nextInt(2);

  // Set the arrow icon based on the chosen choice
  IconData iconData = choice == 0 ? Icons.arrow_back : Icons.arrow_forward;
  choice == 0 ? isRightArrow = false : isRightArrow = true;
  Icon res = Icon(
    iconData,
    size: 50,
    color: getRandomRedOrGreenColor(),
  );
  return res;
}

// return random color (red or green)
Color getRandomRedOrGreenColor() {
  Random random = Random();

  // Generate a random number (0 or 1) to choose between red and green
  int choice = random.nextInt(2);

  // Set the color component values based on the chosen color
  int red = choice == 0 ? 255 : 0;
  int green = choice == 1 ? 255 : 0;
  int blue = 0; // Set blue to 0 for a pure red or green color

  choice == 0 ? isRed = true : isRed = false;

  // Create a Color object using the chosen color components
  Color color = Color.fromARGB(255, red, green, blue);
  return color;
}

// return random picture (rainbow or arrow)
String getRandomPhoto() {
  final List<String> photoAssets = [
    'asserts/images/arrows2.png',
    'asserts/images/rainbow2.jpeg'
  ];

  Random random = Random();
  int randomIndex = random.nextInt(photoAssets.length);
  randomIndex == 0 ? isRanbow = false : isRanbow = true;
  return photoAssets[randomIndex];
}

class _GamePageState extends State<GamePage> {
  bool isButtonPressed = false;
  // Icon randomArrow = getRandomArrow();
  // String randomPhoto = getRandomPhoto();
  Icon randomArrow = const Icon(
    Icons.arrow_back,
    color: Colors.black,
  );
  String randomPhoto = 'asserts/images/black.png';
  int startTime = 0;
  int endTime = 0;

  void _handleCenterButtonPressDown() {
    startTime = DateTime.now().microsecondsSinceEpoch * 1000;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        randomArrow = getRandomArrow();
        randomPhoto = getRandomPhoto();
        isButtonPressed = true;
        print("the time when the user pressed the center button: $startTime");
      });
    });
  }

  void _handleCenterButtonPressUp() {
    setState(() {
      endTime = DateTime.now().microsecondsSinceEpoch * 1000;
      isButtonPressed = false;
      print("the time when the user released the center button: $endTime");
      int time_of_holding_the_button = endTime - startTime;
      print("time_of_holding_the_button:$time_of_holding_the_button");
    });
  }

  void _handleOneOfTheCircelsIsPressed() {
    if (endTime > startTime) {
      int elapsedNanoseconds =
          DateTime.now().microsecondsSinceEpoch * 1000 - endTime;
      print("response time: $elapsedNanoseconds nanoseconds");
    }
    setState(() {
      randomArrow = const Icon(
        Icons.arrow_back,
        color: Colors.black,
      );
      randomPhoto = 'asserts/images/black.png';
    });
  }

  // void _handleButtonPress() {
  //   Future.delayed(Duration(seconds: 2), () {
  //     setState(() {
  //       containerColor = Colors.purple;
  //     });
  //   });
  // }

  // void _handleReturnToFirstPage() {
  //   setState(() {
  //     containerColor = Colors.grey;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                // red button
                onPressed: () async {
                  final last = await UserSheetsApi.getRowCount();
                  setState(() {
                    if ((isRanbow && !isRed) || (!isRanbow && isRightArrow)) {
                      UserSheetsApi.updateCell(
                        id: last,
                        key: 'wrongAnswers',
                        value: ++wrongAnswers,
                      );
                      print("wrong");
                    } else {
                      UserSheetsApi.updateCell(
                        id: last,
                        key: 'correctAnswers',
                        value: ++correctAnswers,
                      );
                    }
                    _handleOneOfTheCircelsIsPressed();
                    // _handleReturnToFirstPage();
                    startTime = 0;
                    endTime = 0;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text(""),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(randomPhoto),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: randomArrow,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          _handleCenterButtonPressDown();
                          containerColor = Colors.purple;
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          _handleCenterButtonPressUp();
                          // isButtonPressed = false;
                          containerColor = Colors.grey;
                        });
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        color: containerColor,
                        child: const Center(
                          child: Text(
                            "Keep Holding!",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                // green button
                onPressed: () async {
                  final lastRow = await UserSheetsApi.getRowCount();
                  setState(() {
                    if ((isRanbow && isRed) || (!isRanbow && !isRightArrow)) {
                      UserSheetsApi.updateCell(
                        id: lastRow,
                        key: 'wrongAnswers',
                        value: ++wrongAnswers,
                      );
                      print("wrong");
                    } else {
                      UserSheetsApi.updateCell(
                        id: lastRow,
                        key: 'correctAnswers',
                        value: ++correctAnswers,
                      );
                    }
                    _handleOneOfTheCircelsIsPressed();
                    // _handleReturnToFirstPage();
                    startTime = 0;
                    endTime = 0;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text(""),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
