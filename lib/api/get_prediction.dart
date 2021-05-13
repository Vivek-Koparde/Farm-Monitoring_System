import 'package:farm_monitoring_flutter/api/get_farm.dart';
import 'package:farm_monitoring_flutter/models/Prediction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';



Future<Prediction> getPrediction() async{
  final _auth = FirebaseAuth.instance;
  String uid = _auth.currentUser.uid;
  String baseURL = 'https://infinite-fjord-59639.herokuapp.com/prediction/';

  String selectedFarmId = await getSelectedFarmId();
  print("UID : "+uid);
  print("FARM ID : "+selectedFarmId);
  List<Prediction> arr = [];
  http.Response response = await http.get(baseURL+uid+"/"+selectedFarmId);
  var data;
  print("PREDICTION ");

  if (response.statusCode == 200){
    var data = jsonDecode(response.body);
    //print(data);

      String downy   = data['downy'].toString();
      String karpa = data['karpa'].toString();
      String bhuri = data['bhuri'].toString();
      String xanthomonas = data['xanthomonas'].toString();

     data = Prediction(downy: downy,karpa: karpa,bhuri: bhuri,xanthomonas: xanthomonas);
    return data;
  }
  return null;

}
