import 'package:flutter/material.dart';
import 'main.dart';
import 'interface.dart';
import 'package:intl/intl.dart';



class SuggestionPage extends StatefulWidget {
  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  navigateTo({var page}) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  DecorationImage backgroundImage;
  final String morningPath = 'images/morning.png';
  final String nightPath = 'images/night.png';

  TextEditingController title = TextEditingController();
  TextEditingController idea = TextEditingController();

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
                                  Form(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.white,
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: 'Title',
                                            hintStyle: TextStyle(fontFamily: 'Poppins'),
                                          ),
                                          controller: title,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.white,
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: 'Your idea',
                                            hintStyle: TextStyle(fontFamily: 'Poppins'),
                                          ),
                                          maxLines: null,
                                          controller: idea,
                                        ),

                                        Container(
                                          width: screenSize.width,
                                          child: OutlineButton(
                                            shape: RoundedRectangleBorder(),
                                            borderSide: BorderSide(width: 1, color: Colors.white),
                                            onPressed: () {
                                              String title_of_idea = title.text;
                                              String idea_of_user = idea.text;
                                              inf.sendSuggestion(title_of_idea, idea_of_user);
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context){
                                                    return AlertDialog(
                                                      title: Text("HEY!!"),
                                                      content: Text("DONE!!"),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          child: Text("OK"),
                                                          onPressed: (){
                                                            Navigator.of(context).pop();
                                                            Navigator.of(context).pop();

                                                          },
                                                        )
                                                      ],
                                                    );
                                                  }
                                              );
                                            },
                                            child: Text(
                                              'Submit',
                                              style: TextStyle(fontSize: 18.0, color: Colors.white),
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
