import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffedf3f6),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    padding: EdgeInsets.only(left: 20, top: 50),
                    decoration: BoxDecoration(
                      color: Color(0xFF2a2b31),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 5.0),
                          child: Text(
                            "Quiz app",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 10), // Add some space between text and border
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Add your other widgets here
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50), // Increase this size to push the text further down
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      "Top Categories",
                      style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // We will modify here to use Column and Row to layout the items as required
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          categoryContainer('images/place.png', 'Places'),
                          categoryContainer('images/film.png', 'Film'),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          categoryContainer('images/cricket.png', 'Cricket'),
                          categoryContainer('images/music.png', 'Music'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          categoryContainer('images/career.png', 'Career'),
                          categoryContainer('images/food.jpg', 'Food'),
                        ],
                      ),
                    ],

                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 195,
            left: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(10)),
                    child: Image.asset(
                      "images/quiz.jpg",
                      height: 150, // Adjust the height of the image
                      fit: BoxFit.cover, // Ensure the image covers the entire space
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Play \n& Win",
                        style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Play by guessing\n the images",
                        style: TextStyle(color: Color(0xFFa4a4a4), fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryContainer(String imagePath, String title) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5,
      child: Container(
        width: 130,
        padding: EdgeInsets.all(19),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, height: 80, width: 80, fit: BoxFit.cover),
            Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
