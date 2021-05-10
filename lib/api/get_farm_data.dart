import 'package:farm_monitoring_flutter/api/get_farm.dart';
import 'package:farm_monitoring_flutter/models/FarmData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';


final _auth = FirebaseAuth.instance;
String baseURL = 'https://infinite-fjord-59639.herokuapp.com/farmDataNew/';

DateTime today = DateTime.parse("2021-03-02T17:30:00.000+00:00");


Future<FarmData> getFarmData () async{

  List<SoilTemperature> arrSoilTemperature=[];
  List<SoilMoisture1> arrSoilMoisture1=[];
  List<SoilMoisture2> arrSoilMoisture2=[];
  List<AirTemperature> arrAirTemperature=[];
  List<AirHumidity> arrAirHumidity=[];
  List<LeafWetness> arrLeafWetness=[];
  List<LightIntensity> arrLightIntensity=[];

  try{
    String uid =  _auth.currentUser.uid;
    String baseURL = 'https://infinite-fjord-59639.herokuapp.com/farmDataNew/';

    //http.Response response = await http.get('https://api.thingspeak.com/channels/1288997/fields/3.json?api_key=GG8YZU6QEOKRPEHM&results');
    String selectedFarmId = await getSelectedFarmId();
    http.Response response = await http.get(baseURL+uid+"/"+selectedFarmId);

    if (response.statusCode == 200) {
      var data = response.body;

      //print(jsonDecode(data));
      var createdAt=[];
      try{
        createdAt  = jsonDecode(data);
      }catch(e){
        print("Error occured while parsing data");
      }

      for (var x in createdAt){
        print(x);
        if (x['soilTemperature'] != null) {
          arrSoilTemperature.add(SoilTemperature(data: double.parse(x['soilTemperature']).toInt(),
              time: DateTime.parse(x['time'])));
        }
        if (x['soilMoisture1'] != null) {
          arrSoilMoisture1.add(SoilMoisture1(data: double.parse(x['soilMoisture1']).toInt(),
              time: DateTime.parse(x['time'])));
        }
        if (x['soilMoisture2'] != null) {
          arrSoilMoisture2.add(SoilMoisture2(data: double.parse(x['soilMoisture2']).toInt(),
              time: DateTime.parse(x['time'])));
        }
        if (x['airTemperature'] != null) {
          arrAirTemperature.add(AirTemperature(data: double.parse(x['airTemperature']).toInt(),
              time: DateTime.parse(x['time'])));
        }
        if (x['airHumidity'] != null) {
          arrAirHumidity.add(AirHumidity(data: double.parse(x['airHumidity']).toInt(),
              time: DateTime.parse(x['time'])));
        }
        if (x['leafWetness'] != null) {
          arrLeafWetness.add(LeafWetness(data: double.parse(x['leafWetness']).toInt(),
              time: DateTime.parse(x['time'])));
        }
        if (x['lightIntensity'] != null) {
          arrLightIntensity.add(LightIntensity(data: double.parse(x['lightIntensity']).toInt(),
              time: DateTime.parse(x['time'])));
        }
      }
      //print('Length : '+createdAt.length);
      //print(createdAt);
      //print('*********************\n');
      return FarmData(
        arrSoilTemperature: arrSoilTemperature,
        arrSoilMoisture1: arrSoilMoisture1,
        arrSoilMoisture2: arrSoilMoisture2,
        arrAirTemperature: arrAirTemperature,
        arrAirHumidity: arrAirHumidity,
        arrLeafWetness: arrLeafWetness,
        arrLightIntensity: arrLightIntensity
      );
    }
  }
  catch(e){
    print('Error : '+e);
  }


}


Future<FarmData> getTodaysFarmData () async{
  List<SoilTemperature> arrSoilTemperature=[];
  List<SoilMoisture1> arrSoilMoisture1=[];
  List<SoilMoisture2> arrSoilMoisture2=[];
  List<AirTemperature> arrAirTemperature=[];
  List<AirHumidity> arrAirHumidity=[];
  List<LeafWetness> arrLeafWetness=[];
  List<LightIntensity> arrLightIntensity=[];
  try{
    String uid =  _auth.currentUser.uid;
    String baseURL = 'https://infinite-fjord-59639.herokuapp.com/farmDataNew/';
    DateTime today = DateTime.parse("2021-03-02T17:30:00.000+00:00");

    http.Response response = await http.get(baseURL+uid+"/6097f5380761600f38ba92df/"+today.toString());

    if (response.statusCode == 200) {
      var data = response.body;
      var createdAt = jsonDecode(data);

      for (var x in createdAt){
        print(x);
        if (x['soilTemperature'] != null) {
          arrSoilTemperature.add(SoilTemperature(data: double.parse(x['soilTemperature']).toInt(),
              time: DateTime.parse(x['time'])));
        }
        if (x['soilMoisture1'] != null) {
          arrSoilMoisture1.add(SoilMoisture1(data: double.parse(x['soilMoisture1']).toInt(),
              time: DateTime.parse(x['time'])));
        }
        if (x['soilMoisture2'] != null) {
          arrSoilMoisture2.add(SoilMoisture2(data: double.parse(x['soilMoisture2']).toInt(),
              time: DateTime.parse(x['time'])));
        }
        if (x['airTemperature'] != null) {
          arrAirTemperature.add(AirTemperature(data: double.parse(x['airTemperature']).toInt(),
              time: DateTime.parse(x['time'])));
        }
        if (x['airHumidity'] != null) {
          arrAirHumidity.add(AirHumidity(data: double.parse(x['airHumidity']).toInt(),
              time: DateTime.parse(x['time'])));
        }
        if (x['leafWetness'] != null) {
          arrLeafWetness.add(LeafWetness(data: double.parse(x['leafWetness']).toInt(),
              time: DateTime.parse(x['time'])));
        }
        if (x['lightIntensity'] != null) {
          arrLightIntensity.add(LightIntensity(data: double.parse(x['lightIntensity']).toInt(),
              time: DateTime.parse(x['time'])));
        }
      }
    }
    return FarmData(
        arrSoilTemperature: arrSoilTemperature,
        arrSoilMoisture1: arrSoilMoisture1,
        arrSoilMoisture2: arrSoilMoisture2,
        arrAirTemperature: arrAirTemperature,
        arrAirHumidity: arrAirHumidity,
        arrLeafWetness: arrLeafWetness,
        arrLightIntensity: arrLightIntensity
    );
  }
  catch(e){
    print('Error : '+e);
    return null;
  }
}
