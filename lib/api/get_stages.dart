 import 'package:farm_monitoring_flutter/api/get_farm.dart';
import 'package:farm_monitoring_flutter/models/Stage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';



Future<List<Stage>> getStage() async{
  final _auth = FirebaseAuth.instance;
  String uid = _auth.currentUser.uid;
  String baseURL = 'https://infinite-fjord-59639.herokuapp.com/stage/';

  String selectedFarmId = await getSelectedFarmId();
  print("UID : "+uid);
  print("FARM ID : "+selectedFarmId);
  List<Stage> arr = [];
  http.Response response = await http.get(baseURL+uid+"/"+selectedFarmId);
  if (response.statusCode == 200){
    var data = jsonDecode(response.body);
    //print(data);
    for (var x in data){
      String stageNo   = x['stageNo'].toString();
      String stageName = x['stageName'].toString();
      DateTime date = DateTime.parse(x['date'].toString());
      Stage stage = new Stage(stageNo: stageNo,stageName: stageName,date: date);
      stage.id=x['_id'];

      arr.add(stage);
    }
  }
  return arr;
}

Future<bool> updateStageDate(String taskNo,DateTime date) async{
  final _auth = FirebaseAuth.instance;
  String uid = _auth.currentUser.uid;
  String baseURL = 'https://infinite-fjord-59639.herokuapp.com/stage/';
  String selectedFarmId = await getSelectedFarmId();

  String json = '{"date": "'+date.toString()+'"}';
  Map<String, String> headers = {"Content-type": "application/json"};
  http.Response response = await http.patch(
      baseURL+uid+"/"+selectedFarmId+"/"+taskNo,
      headers: headers,
      body: json);
  print(response.body);
  return true;
}
