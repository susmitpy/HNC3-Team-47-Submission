import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'interface.dart';



class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  DecorationImage backgroundImage;
  final String morningPath = 'images/morning.png';

  final String nightPath = 'images/night.png';

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController uidai = TextEditingController();
  TextEditingController password = TextEditingController();
  Interface inf = Interface();


  @override
  void initState() {
    DateTime now = DateTime.now();
    String formatteddate = DateFormat('kk').format(now);
    int currenttime = int.parse(formatteddate);
    if (currenttime >= 0 && currenttime < 16) {
      backgroundImage =
          DecorationImage(image: AssetImage(morningPath), fit: BoxFit.cover);
    } else {
      backgroundImage =
          DecorationImage(image: AssetImage(nightPath), fit: BoxFit.cover);
    }
    if (backgroundImage == null) {
      backgroundImage = new DecorationImage(
          image: AssetImage(morningPath), fit: BoxFit.cover);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    bool _passwordVisible = true;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(image: backgroundImage),
          child: Container(
            child: ListView(
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
                                color: Colors.white,
                                fontSize: 45.0,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 160.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                          Form(
                          child: Column(
                        children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Name',
                            hintStyle: TextStyle(fontFamily: 'Poppins'),
                            icon: Icon(
                              Icons.mail_outline,
                              color: Colors.white,
                            ),
                          ),
                          controller: name,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(fontFamily: 'Poppins'),
                            icon: Icon(
                              Icons.mail_outline,
                              color: Colors.white,
                            ),
                          ),
                          controller: phone,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'AADHAR Number',
                            hintStyle: TextStyle(fontFamily: 'Poppins'),
                            icon: Icon(
                              Icons.mail_outline,
                              color: Colors.white,
                            ),
                          ),
                          controller: uidai,
                        ),
                        StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
                            return TextFormField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                                  icon: Icon(Icons.lock, color: Colors.white),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      })),
                              obscureText: _passwordVisible,
                              controller: password,
                            );
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: screenSize.width,
                          child: OutlineButton(
                            shape: RoundedRectangleBorder(),
                            borderSide: BorderSide(width: 1, color: Colors.white),
                            onPressed: () {
                              register(name.text, phone.text, uidai.text, password.text);

//                              Navigator.push(
//                                context,
//                                MaterialPageRoute(builder: (BuildContext context) {
//                                  return HomePage();
//                                }),
//                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
            ),
          )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void register(String name, String phone, String uidai, String pass) async {
    Map<String,dynamic> res_map = await inf.register(name, phone, uidai, pass);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("PHONE", phone);
    prefs.setInt("POINTS", 0);
    print("Resgitering 1");
    if (res_map != null){
      print(res_map);
      if (res_map['res'] == "Succ"){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return HomePage();
          }),
        );
      }
    }
  }
}