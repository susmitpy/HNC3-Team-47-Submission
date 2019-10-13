import 'package:flutter/material.dart';
import 'main.dart';
import 'interface.dart';
import 'package:intl/intl.dart';




class InapproDumpPage extends StatefulWidget {
  @override
  _InapproDumpPageState createState() => _InapproDumpPageState();
}

class _InapproDumpPageState extends State<InapproDumpPage> {
  navigateTo({var page}) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  DecorationImage backgroundImage;
  final String morningPath = 'images/morning.png';
  final String nightPath = 'images/night.png';

  TextEditingController addr = TextEditingController();

  Interface inf = Interface();

  String lat = "";
  String lon = "";

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

                                  Text("Report Inappropriate Dumping of Waste",
                                  style: TextStyle(color: Colors.green, fontSize: 18),),

                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.text,
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Address',
                                      hintStyle: TextStyle(fontFamily: 'Poppins',color: Colors.white),
                                    ),
                                    maxLines: null,
                                    controller: addr,
                                  ),
                                  Container(
                                    width: screenSize.width,
                                    child: OutlineButton(
                                      shape: RoundedRectangleBorder(),
                                      borderSide: BorderSide(width: 1, color: Colors.white),
                                      onPressed: () {
                                        String addr_of_dump = addr.text;
                                        inf.sendInppropriateDumpReport(addr_of_dump);

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
