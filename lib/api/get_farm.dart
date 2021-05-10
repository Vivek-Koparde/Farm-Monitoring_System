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

    // String id = data['_id'].toString();
    // bool isSelected = data['isSelected'];
    // String farmName = data['farmName'].toString();
    // double longitude = double.parse(data['longitude'].toString());
    // double latitude = double.parse(data['latitude'].toString());
    // double area = double.parse(data['area'].toString());
    // DateTime date = DateTime.parse(data['date'].toString());
    // Farm farm = new Farm(id: id,isSelected: isSelected,farmName: farmName,longitude: longitude,latitude: latitude,area: area,date: date);
    print("FETCHED DATA : ");
    print(response.body);
    return null;
  }
  return null;
}

