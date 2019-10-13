import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'suggestion.dart';
import 'package:SafeWaste/InapproDump.dart';
import 'supu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'leader.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  navigateTo({var page}) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }


  @override
    void initState() {
    getPoints();

      super.initState();
    }

  int points = 0;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
        ),

        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(title: Text("SafeWaste"),centerTitle: true,),
            resizeToAvoidBottomInset: true,
            body: Container(
              decoration: BoxDecoration(color: Colors.cyanAccent),
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
                            SizedBox(height: 6),
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 10,),
                                  Text("Points", style: TextStyle(fontSize: 30),),
                                  Text(points.toString(),style: TextStyle(fontSize: 70, color: Colors.lightBlue),),
                                ],
                              ),
                              radius: 90,
                            ),
                            Divider(color: Colors.orange,),
                            SizedBox(height: 9,),
                            RaisedButton(
                              child: Text("Give Suggestion"),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return SuggestionPage();
                                }));
                              },
                            ),
                            SizedBox(height: 9,),
                            Divider(color: Colors.orange,),
                            Text("Report"),
                            SizedBox(height: 3,),
                            RaisedButton(
                              child: Text("Inappropriate Dump"),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return InapproDumpPage();
                                }));
                              },
                            ),
                            SizedBox(height: 9,),
                            RaisedButton(
                              child: Text("Single Use Plastic Used "),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return SingleUsePlasticUsedPage();
                                }));
                              },
                            ),
                            Divider(color: Colors.orange,),
                            SizedBox(height: 9,),
                            RaisedButton(
                              child: Text("Leaderboard"),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return LeaderBoardPage();
                                }));
                              },
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

  void getPoints() async{
    print("get points");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      points = prefs.getInt("POINTS");
      print("new points: " + points.toString());
    });


  }
}
