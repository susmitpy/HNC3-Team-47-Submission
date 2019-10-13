import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Interface{
//  void sendToServer (String mssg) async {
//    print("Message to send: " + mssg);
//    var url = "http://d21a44de.ngrok.io/message";
//    Map myMap = new Map();
//    myMap["mssg"] = mssg;
//    myMap["mode"] = "App";
//    http.post(url, body: myMap).then((http.Response response) {
//      String recdMssg = convert.jsonDecode(response.body);
//      print("Respone decoded: " + recdMssg);
//      mssgs.add(recdMssg);
//      setState(() {
//        numMssg += 1;
//      });
//    });
//  }

String phone;

  setPoints(int points) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("POINTS", points);
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

    Future<Map> sendToServer(rel_path, map) async{

      var url = "http://acec8b62.ngrok.io";  // URL OF Server
      var dest = url + "/" + rel_path;
      var res;
      print(dest);
      await http.post(dest, body: map).then((http.Response response){
        res = json.decode(response.body);

      });
      return res;

    }

    Future<Map> register(name, phone,uidai, pass) async{
        String hashed_pass = generateMd5(pass);
        var map = {
          "name":name,
          "phone":phone,
          "uidai": uidai,
          "passw": hashed_pass
        };
        return await sendToServer("register", map);

    }

  Future<int> login(phone, pass) async{
    String hashed_pass = generateMd5(pass);
    var map = {
      "phone":phone,
      "pass": hashed_pass
    };
    var res = await sendToServer("login", map);
    if (res["res"] == "fail"){
      return 0;
    }
    else if (res["res"] == "ne"){
      return 1;
    }
    else{
      return 2;
    }
  }

  void sendSuggestion(title,idea) async{
    var map = {
      "phone":phone,
      "title": title,
      "idea":idea
    };
     var res = await sendToServer("suggestion", map);
     print(res);
     int np = res['res'];
     setPoints(np);
  }

void sendSinglePlasticUsedReport(store_name,addr) async{
  var map = {
    "phone":phone,
    "store_name": store_name,
    "addr":addr
  };
  var res = await sendToServer("supu", map);
  int np = res['res'];
  setPoints(np);
}

void sendInppropriateDumpReport(addr) async{
  var map = {
    "phone":phone,
    "addr":addr
  };
  var res = await sendToServer("iadr", map);
  int np = res['res'];
  setPoints(np);
}


  Interface(){
    getPhoneNumber();
  }

  void getPhoneNumber() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phone = prefs.getString("PHONE");
  }

  Future<Map> getLeaderBoard() async{
        var res = await sendToServer("leader", {});
        return res;
  }


}
