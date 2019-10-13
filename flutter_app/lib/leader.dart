
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:intl/intl.dart';
import 'interface.dart';



class LeaderBoardPage extends StatefulWidget {
  @override
  _LeaderBoardPageState createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  navigateTo({var page}) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  DecorationImage backgroundImage;
  final String morningPath = 'images/morning.png';
  final String nightPath = 'images/night.png';

  TextEditingController addr = TextEditingController();
  TextEditingController name = TextEditingController();

  var first;
  var  second;
  var third;
  var res;

  Interface inf = Interface();

  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk').format(now);
    int currenttime = int.parse(formattedDate);

    if (currenttime >= 0 && currenttime < 16) {
      print(currenttime);
      print('morning');
      backgroundImage = new DecorationImage(
          image: AssetImage(morningPath), fit: BoxFit.cover);
    } else {
      print(currenttime);
      print('night');
      backgroundImage =
      new DecorationImage(image: AssetImage(nightPath), fit: BoxFit.cover);
    }
    if (backgroundImage == null) {
      backgroundImage = new DecorationImage(
          image: AssetImage(morningPath), fit: BoxFit.cover);
    }

    res = inf.getLeaderBoard();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
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
                                    color: Colors.white,
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
