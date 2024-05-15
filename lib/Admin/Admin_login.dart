import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFededeb),
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding: EdgeInsets.only(top:45.0, left: 20.0, right: 20.0),
              height: MediaQuery.of(context).size.height , // adjusted height
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 53, 51, 51),
                    Colors.black
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.elliptical(MediaQuery.of(context).size.width, 110.0)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
              child: Form(child:Column(
                children: [
                  Text('Lets go!!!',
                 style: TextStyle(color:Colors.black,fontSize: 25.0, fontWeight:FontWeight.bold ),

                  ),
                  SizedBox(height: 30.0,),
                  Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                    height: MediaQuery.of (context).size.height/2.2,
                    decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                      SizedBox(height: 50.0, ),
                        Container (
                            padding: EdgeInsets.only(left: 20.0, top: 5.0),
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:Color.fromARGB(255, 23, 43, 12)
                              ),
                                borderRadius: BorderRadius.circular(20),
                            ),
                          child: TextFormField(
                            controller: usernamecontroller,
                          validator: (value){
                              if(value==null|| value.isEmpty){
                                return 'Enter Username';
                              }
                          },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",
                              hintStyle: TextStyle(color: Color.fromARGB(255,160, 160, 140))
                            ),
                          ),
                        ),
                      SizedBox(height: 20.0,),
                        Container (
                          padding: EdgeInsets.only(left: 20.0, top: 5.0),
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:Color.fromARGB(255, 23, 43, 12)
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: passwordcontroller,
                            validator: (value){
                              if(value==null|| value.isEmpty){
                                return 'Enter Password';
                              }
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Color.fromARGB(255,160, 160, 140))
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)

                          ),
                          child: Center(
                            child: Text('LogIn',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                  ),],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
