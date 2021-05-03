import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';


final _auth = FirebaseAuth.instance;
String uid = _auth.currentUser.uid;
String baseURL = 'https://infinite-fjord-59639.herokuapp.com/farmData/';


DateTime today = DateTime.parse("2021-03-02T17:30:00.000+00:00");


class Temperature{
  int data;
  DateTime time;
  Temperature({this.data,this.time});
}

Future<List<Temperature>> getTodaysTemperatureData () async{
  print("method called");
  try{
    http.Response response = await http.get(baseURL+uid+"/"+today.toString());
    List<Temperature> arr = [];
    if (response.statusCode == 200) {
      var data = response.body;
      //print(jsonDecode(data));
      var createdAt = jsonDecode(data);
      //print('Length : '+createdAt.length);
      //print(createdAt);
      //print('*********************\n');
      for (var x in createdAt) {
        print(x);
        if (x['temperature'] != null) {

          arr.add(Temperature(data: double.parse(x['temperature']).toInt(),
              time: DateTime.parse(x['time'])));
        }
      }
      return arr;
    }
  }
  catch(e){
    print('Error : '+e);
    return null;
  }
}

Future<List<Temperature>> getTemperatureData () async{
  print("method called");
  try{
    http.Response response = await http.get(baseURL+uid);
    List<Temperature> arr = [];
    if (response.statusCode == 200) {
      var data = response.body;
      //print(jsonDecode(data));
      var createdAt = jsonDecode(data);
      //print('Length : '+createdAt.length);
      //print(createdAt);
      //print('*********************\n');
      for (var x in createdAt) {
        print(x);
        if (x['temperature'] != null) {

          arr.add(Temperature(data: double.parse(x['temperature']).toInt(),
              time: DateTime.parse(x['time'])));
        }
      }
      return arr;
    }
  }
  catch(e){
    print('Error : '+e);
    return null;
  }


}