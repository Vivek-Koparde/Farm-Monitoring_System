import 'package:farm_monitoring_flutter/models/Farm.dart';
import 'package:farm_monitoring_flutter/models/FarmName.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> getSelectedFarmId() async{
  final _auth = FirebaseAuth.instance;
  String uid = _auth.currentUser.uid;
  String baseURL = 'https://infinite-fjord-59639.herokuapp.com/farm/';

  List<Farm> arr = [];
  http.Response response = await http.get(baseURL+uid+'/true');
  if (response.statusCode==200){
    String id = response.body.toString();
    return id.substring(1,id.length-1);
  }
  return null;
}


Future<List<Farm>> getFarm() async{
  final _auth = FirebaseAuth.instance;
  String uid = _auth.currentUser.uid;
  String baseURL = 'https://infinite-fjord-59639.herokuapp.com/farm/';

  List<Farm> arr = [];
  http.Response response = await http.get(baseURL+uid);
  print("RESPOnSE : ");
  print(response);
  if (response.statusCode == 200){
    var data = jsonDecode(response.body);
    //print(data);
    for (var x in data){
      String id = x['_id'].toString();
      bool isSelected = x['isSelected'];
      String farmName = x['farmName'].toString();
      double longitude = double.parse(x['longitude'].toString());
      double latitude = double.parse(x['latitude'].toString());
      double area = double.parse(x['area'].toString());
      DateTime date = DateTime.parse(x['date'].toString());
      Farm farm = new Farm(id: id,isSelected: isSelected,farmName: farmName,longitude: longitude,latitude: latitude,area: area,date: date);
      arr.add(farm);
    }
  }
  return arr;
}

Future<Farm> getFirstFarm() async{
  final _auth = FirebaseAuth.instance;
  String uid = _auth.currentUser.uid;
  String selectedFarmId = await getSelectedFarmId();
  String baseURL = 'https://infinite-fjord-59639.herokuapp.com/farm/';

  List<Farm> arr = [];
  String finalURL = baseURL+uid+'/'+selectedFarmId;
  print("FINAL URL : "+finalURL);
  http.Response response = await http.get(finalURL);
  if (response.statusCode == 200){
    var data = jsonDecode(response.body);

    print("FETCHED DATA : ");
    print(response.body);
    return null;
  }
  return null;
}

Future<bool> changeFarmSelectedStatus(String farmId,String isSelected) async{
  final _auth = FirebaseAuth.instance;
  String uid = _auth.currentUser.uid;
  print(uid);
  print(farmId);
  String baseURL = 'https://infinite-fjord-59639.herokuapp.com/farm/'+uid+'/'+farmId+'/'+isSelected;
//String baseURL = 'https://infinite-fjord-59639.herokuapp.com/farm/4fwUKAVKEPhRJl64VRyHvniX0oh1/6097f5380761600f38ba92df/false';
  //String json = '{"isSelected": "'+isSelected+'"}';
  Map<String, String> headers = {"Content-type": "application/json"};
  http.Response response = await http.put(
      baseURL,
    headers: headers
     );

  print(response.body);
  return true;
}


