import 'package:flutter/material.dart';
class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004840),
      body: Container(

        child: Column(
          children: [
           Padding(
             padding:  EdgeInsets.only(top: 50.0, left: 20.0),
             child: Row(
               children: [
              Container(
                decoration: BoxDecoration(color: Color(0xFFf35b32),borderRadius: BorderRadius.circular(40)),
                child: Center(child: Icon(Icons.arrow_back_ios, color: Colors.white,),

                ),

              ),
                 SizedBox(width: 120.0,),
                 Text(
                   "Cricket",
                   style: TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
                 ),
               ],
             ),
           ),
            SizedBox(height: 20.0,),
            Expanded(
              child: Container(
                
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(30) )),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:20.0,right: 20.0,top: 40.0),
                      child: ClipRect(
                          
                          child: Image.asset("images/quiz.jpg",height: 300, width: MediaQuery.of(context).size.width,fit: BoxFit.cover,)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2.0),borderRadius: BorderRadius.circular(20)),
                        child: Text('1',style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500
                        ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2.0),borderRadius: BorderRadius.circular(20)),
                        child: Text('2',style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500
                        ),
                        ),
                      ),
                    ),

                    SizedBox(width: 20,),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2.0),borderRadius: BorderRadius.circular(20)),
                        child: Text('3',style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500
                        ),
                        ),
                      ),
                    ),

                    SizedBox(width: 20,),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2.0),borderRadius: BorderRadius.circular(20)),
                        child: Text('4',style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500
                        ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
