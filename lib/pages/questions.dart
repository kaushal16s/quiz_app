import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/service/database.dart';
import 'dart:async';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:emoji_alert/arrays.dart';

class Question extends StatefulWidget {
  final String category;

  Question({required this.category});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  bool show = false;
  bool isCorrect = false;
  bool timerEnded = false;
  int timer = 15; // 30 seconds timer for each question
  Timer? _timer;
  Stream? quizStream;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    getQuizData();
    startTimer();
  }

  getQuizData() async {
    quizStream = await DatabaseMethods().getCategoryQuiz(widget.category);
    setState(() {});
  }

  startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (this.timer > 0) {
          this.timer--;
        } else {
          show = true;
          timerEnded = true;
          _timer?.cancel();
        }
      });
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      timer = 15;
      timerEnded = false;
      startTimer();
    });
  }

  void handleAnswer(bool correct) {
    if (!timerEnded) {
      setState(() {
        show = true;
        isCorrect = correct;
      });
      showEmoji(correct); // Pass the correct flag to showEmoji
    }
  }

  void showEmoji(bool isCorrect) {
    showDialog(
      context: context,
      barrierDismissible: false,  // Ensure the dialog cannot be dismissed by tapping outside
      builder: (BuildContext context) {
        // Automatically close after 3 seconds
        Future.delayed(Duration(seconds: 3), () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(true);  // Safely close the dialog
          }
        });
        return Dialog(

            child: EmojiAlert(
              alertTitle: Text(isCorrect ? 'Correct!' : 'Wrong!'),
              description: Text(isCorrect ? 'Great job, you got it right!' : 'That’s not quite right. Try again!'),
              enableMainButton: true,
              mainButtonText: Text(isCorrect ? 'Next' : 'Retry'),
              onMainButtonPressed: () {
                Navigator.of(context).pop(true);  // Close the dialog manually
                if (isCorrect) {
                  setState(() {
                    show = false;
                    resetTimer();
                  });
                  controller.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  // You may want to handle retry logic here
                  // For now, simply resetting the view and restarting the timer
                  setState(() {
                    show = false;
                    resetTimer();
                  });
                }
              },
              cancelable: false,  // Prevent the dialog from being closed by back button
              emojiType: isCorrect ? EMOJI_TYPE.HAPPY : EMOJI_TYPE.SAD,
              height: 260,  // You may need to adjust or remove this height constraint
            ),

        );
      },
    );
  }

  Widget allQuiz() {
    return StreamBuilder(
      stream: quizStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? PageView.builder(
            controller: controller,
            itemCount: snapshot.data.docs.length,
           itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                    child: ClipRect(
                      child: Image.network(
                        ds["Image"],
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print("Error loading image: $error");
                          return Text("Failed to load Image");
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () => handleAnswer(ds["correct"] == ds["option1"]),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: show
                                ? ds["correct"] == ds["option1"]
                                ? Colors.green
                                : Colors.red
                                : Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          ds['option1'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () => handleAnswer(ds["correct"] == ds["option2"]),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: show
                                ? ds["correct"] == ds["option2"]
                                ? Colors.green
                                : Colors.red
                                : Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          ds['option2'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () => handleAnswer(ds["correct"] == ds["option3"]),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: show
                                ? ds["correct"] == ds["option3"]
                                ? Colors.green
                                : Colors.red
                                : Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          ds['option3'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () => handleAnswer(ds["correct"] == ds["option4"]),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: show
                                ? ds["correct"] == ds["option4"]
                                ? Colors.green
                                : Colors.red
                                : Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          ds['option4'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      if(timerEnded) {
                        setState(() {
                          show = false;
                          resetTimer();
                        });
                        controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.bounceInOut,
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: CupertinoColors.systemTeal),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.lightGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Time remaining: $timer",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        )
            : Container();
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004840),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.0, left: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFf35b32),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 120.0),
                  Text(
                    widget.category,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(child: allQuiz()),
          ],
        ),
      ),
    );
  }
}
