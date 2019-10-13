import 'package:flutter/material.dart';
import 'main.dart';
import 'package:intl/intl.dart';
import 'register.dart';
import 'home_screen.dart';
import 'interface.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  navigateTo({var page}) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  DecorationImage backgroundImage;
  final String image = 'images/bg.png';
  final String nightPath = 'images/night.png';

  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  Interface inf = Interface();
  @override
  void initState() {
//    DateTime now = DateTime.now();
//    String formattedDate = DateFormat('kk').format(now);
//    int currenttime = int.parse(formattedDate);
//
//    if (currenttime >= 0 && currenttime < 16) {
//      print(currenttime);
//      print('morning');
//      backgroundImage = new DecorationImage(
//          image: AssetImage(morningPath), fit: BoxFit.cover);
//    } else {
//      print(currenttime);
//      print('night');
//      backgroundImage =
//      new DecorationImage(image: AssetImage(nightPath), fit: BoxFit.cover);
//    }

      backgroundImage = new DecorationImage(
          image: AssetImage(image), fit: BoxFit.cover);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

      final Size screenSize = MediaQuery.of(context).size;
      bool _passwordVisible = true;
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              decoration: BoxDecoration(image: backgroundImage),
              child: Container(
                child: ListView(
                  padding: const EdgeInsets.all(0.0),
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'SafeWaste',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 45.0,
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 160.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                              Form(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  TextFormField(
                                    style: TextStyle(color: Colors.green),
                                    keyboardType: TextInputType.phone,
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Phone Number',
                                      hintStyle: TextStyle(fontFamily: 'Poppins'),
                                      icon: Icon(
                                        Icons.mail_outline,
                                        color: Colors.green,
                                      ),
                                    ),
                                    controller: phone,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return TextFormField(
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(color: Colors.green),
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          hintText: 'Password',
                                          hintStyle: TextStyle(fontFamily: 'Poppins'),
                                          icon: Icon(Icons.lock_outline, color: Colors.green),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _passwordVisible = !_passwordVisible;
                                              });
                                            },
                                            child: Icon(
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        obscureText: _passwordVisible,
                                        controller: password,
                                      );
                                    },
                                  ),

                                  Container(
                                    width: screenSize.width,
                                    color: Colors.black,
                                    child: OutlineButton(

                                      shape: RoundedRectangleBorder(),
                                      borderSide: BorderSide(width: 1, color: Colors.white),
                                      onPressed: () async {
                                        String phone_no = phone.text;
                                        String pass = password.text;
                                        print(phone_no + " " + pass);
                                        int res = await inf.login(phone_no,pass);
                                        print(res);
                                        if (res == 2) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (
                                                BuildContext context) {
                                              return HomePage();
                                            }),
                                          );
                                        }
                                        else{
                                          String mssg = "";
                                          if (res == 0){
                                            mssg = "Invalid Credentials";
                                          }
                                          else{
                                            mssg = "User Does Not Exist";
                                          }
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context){
                                              return AlertDialog(
                                                title: Text("Alert"),
                                                content: Text(mssg),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text("OK"),
                                                    onPressed: (){
                                                      Navigator.of(context).pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            }
                                          );

                                        }
                                      },
                                      child: Text(
                                        'Log in',
                                        style: TextStyle(fontSize: 18.0, color: Colors.green,backgroundColor: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height:6),
                                  Container(
                                    color: Colors.black54,
                                    alignment: Alignment.center,
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (BuildContext context) {
                                            return RegisterPage();
                                          }),
                                        );
                                      },
                                      child: Text(
                                        'Don\'t have an account? Sign up',
                                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
