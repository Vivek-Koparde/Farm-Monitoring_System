import 'package:farm_monitoring_flutter/api/get_farm_data.dart';
import 'package:farm_monitoring_flutter/api/get_light_intensity.dart';
import 'package:farm_monitoring_flutter/api/get_temperature.dart';
import 'package:farm_monitoring_flutter/api/get_moisture.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:farm_monitoring_flutter/models/FarmData.dart';
import 'file:///C:/Users/Vivek/AndroidStudioProjects/farm-monitoring-flutter/lib/screens/GraphScreen/SpeedoMeterScreen.dart';
import 'package:farm_monitoring_flutter/widgets/CustomeTimeGraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GraphScreen extends StatefulWidget {
  static String id="graphScreen";
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  double moistureSpeedoMeterValue = 150.0;
  double temperatureSpeedoMeterValue;
  double lighIntensitySpeedoMeterValue;
  var timeMoisture = 1;
  var timeTemperature = 1;
  var timeLightIntensity = 1;
  var timeSoilTemperature = 1;
  var timeSoilMoisture1 = 1;
  var timeSoilMoisture2 = 1;
  var timeAirTemperature = 1;
  var timeAirHumidity = 1;
  var timeLeafWetness =1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SpeedoMeter()),
      floatingActionButton: SpeedDial(
        marginEnd: 18,
        marginBottom: 20,
        icon: Icons.menu,
        activeIcon: CupertinoIcons.clear,
        buttonSize: 50.0,
        visible: true,
        closeManually: false,
        renderOverlay: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Color(0xff00A961),
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(CupertinoIcons.arrow_down_circle_fill),
            backgroundColor: Color(0xff00A961),
            label: 'Show Graph',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => _showGraph(context),
          ),
          SpeedDialChild(
            child: Icon(CupertinoIcons.graph_square),
            backgroundColor: Colors.blue,
            label: 'Get Current Values',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => _showCurrentValues(context),
          ),
        ],
      ),
    );
  }

  _showGraph(BuildContext context) async {
    int flag = 0;
    await showDialog(
        context: context,
        builder: (context) => Scaffold(
              body: SafeArea(
                child: Container(
                  color: Colors.white,
                  child: FutureBuilder(
                    //future: getMoistureData(),
                    future: getFarmData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      int j = 0;
                      //print(snapshot.data);
                      if (snapshot.data == null) {
                        return Container(
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Loading...",
                                style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Lottie.asset('images/tractor_animation.json')
                            ],
                          )),
                        );
                      } else {
                        //TODO:Change starts

                        //SoilTemperature
                        List<charts.Series<SoilTemperature, DateTime>>
                            _createSoilTemperatureData() {
                          int i = 0;
                          List<SoilTemperature> data = [];
                          for (var x in snapshot.data.arrSoilTemperature) {
                            if (i % timeSoilTemperature == 0)
                              data.add(
                                  SoilTemperature(time: x.time, data: x.data));
                            i++;
                          }
                          return [
                            new charts.Series<SoilTemperature, DateTime>(
                              id: 'SoilTemperature',
                              colorFn: (_, __) =>
                                  charts.MaterialPalette.green.shadeDefault,
                              domainFn: (SoilTemperature d, _) => d.time,
                              measureFn: (SoilTemperature d, _) => d.data,
                              data: data,
                            )
                          ];
                        }

                        changeSoilTemperature(newSoilTemperature) {
                          setState(() {
                            timeSoilTemperature = newSoilTemperature;
                          }); // print(timeTemperatureIntensity);
                          (context as Element).reassemble();
                        }

                        //SoilMoisture1
                        List<charts.Series<SoilMoisture1, DateTime>>
                            _createSoilMoisture1Data() {
                          int i = 0;
                          List<SoilMoisture1> data = [];
                          for (var x in snapshot.data.arrSoilMoisture1) {
                            if (i % timeSoilMoisture1 == 0)
                              data.add(
                                  SoilMoisture1(time: x.time, data: x.data));
                            i++;
                          }

                          return [
                            new charts.Series<SoilMoisture1, DateTime>(
                              id: 'SoilMoisture1',
                              colorFn: (_, __) =>
                                  charts.MaterialPalette.green.shadeDefault,
                              domainFn: (SoilMoisture1 sales, _) => sales.time,
                              measureFn: (SoilMoisture1 sales, _) => sales.data,
                              data: data,
                            )
                          ];
                        }

                        changeSoilMoisture1(newSoilMoisture1) {
                          setState(() {
                            timeSoilMoisture1 = newSoilMoisture1;
                          });
                          (context as Element).reassemble();
                        }

                        //SoilMoisture2
                        List<charts.Series<SoilMoisture2, DateTime>>
                            _createSoilMoisture2Data() {
                          int i = 0;
                          List<SoilMoisture2> data = [];
                          for (var x in snapshot.data.arrSoilMoisture2) {
                            if (i % timeSoilMoisture2 == 0)
                              //data.add(SoilMoisture2(time:x.time,x.data));
                              data.add(
                                  SoilMoisture2(time: x.time, data: x.data));
                            i++;
                          }

                          return [
                            new charts.Series<SoilMoisture2, DateTime>(
                              id: 'SoilMoisture2',
                              colorFn: (_, __) =>
                                  charts.MaterialPalette.green.shadeDefault,
                              domainFn: (SoilMoisture2 sales, _) => sales.time,
                              measureFn: (SoilMoisture2 sales, _) => sales.data,
                              data: data,
                            )
                          ];
                        }

                        changeSoilMoisture2(newSoilMoisture2) {
                          setState(() {
                            timeSoilMoisture2 = newSoilMoisture2;
                          });
                          (context as Element).reassemble();
                          //   print(timeTemperatureIntensity);
                        }


                        //Air Temperature
                        List<charts.Series<AirTemperature, DateTime>>
                        _createAirTemperatureData() {
                          int i = 0;
                          List<AirTemperature> data = [];
                          for (var x in snapshot.data.arrAirTemperature) {
                            if (i % timeAirTemperature == 0)
                              //data.add(AirTemperature(time:x.time,x.data));
                              data.add(
                                  AirTemperature(time: x.time, data: x.data));
                            i++;
                          }

                          return [
                            new charts.Series<AirTemperature, DateTime>(
                              id: 'AirTemperature',
                              colorFn: (_, __) =>
                              charts.MaterialPalette.green.shadeDefault,
                              domainFn: (AirTemperature sales, _) => sales.time,
                              measureFn: (AirTemperature sales, _) => sales.data,
                              data: data,
                            )
                          ];
                        }

                        changeAirTemperature(newAirTemperature) {
                          setState(() {
                            timeAirTemperature = newAirTemperature;
                          });
                          (context as Element).reassemble();
                          //   print(timeTemperatureIntensity);
                        }

                        //Air Humidity
                        List<charts.Series<AirHumidity, DateTime>>
                        _createAirHumidityData() {
                          int i = 0;
                          List<AirHumidity> data = [];
                          for (var x in snapshot.data.arrAirHumidity) {
                            if (i % timeAirHumidity == 0)
                              //data.add(AirHumidity(time:x.time,x.data));
                              data.add(
                                  AirHumidity(time: x.time, data: x.data));
                            i++;
                          }

                          return [
                            new charts.Series<AirHumidity, DateTime>(
                              id: 'AirHumidity',
                              colorFn: (_, __) =>
                              charts.MaterialPalette.green.shadeDefault,
                              domainFn: (AirHumidity sales, _) => sales.time,
                              measureFn: (AirHumidity sales, _) => sales.data,
                              data: data,
                            )
                          ];
                        }

                        changeAirHumidity(newAirHumidity) {
                          setState(() {
                            timeAirHumidity = newAirHumidity;
                          });
                          (context as Element).reassemble();
                          //   print(timeTemperatureIntensity);
                        }

                        //Leaf Wetness
                        List<charts.Series<LeafWetness, DateTime>>
                        _createLeafWetnessData() {
                          int i = 0;
                          List<LeafWetness> data = [];
                          for (var x in snapshot.data.arrLeafWetness) {
                            if (i % timeLeafWetness == 0)
                              //data.add(LeafWetness(time:x.time,x.data));
                              data.add(
                                  LeafWetness(time: x.time, data: x.data));
                            i++;
                          }

                          return [
                            new charts.Series<LeafWetness, DateTime>(
                              id: 'LeafWetness',
                              colorFn: (_, __) =>
                              charts.MaterialPalette.green.shadeDefault,
                              domainFn: (LeafWetness sales, _) => sales.time,
                              measureFn: (LeafWetness sales, _) => sales.data,
                              data: data,
                            )
                          ];
                        }

                        changeLeafWetness(newLeafWetness) {
                          setState(() {
                            timeLeafWetness = newLeafWetness;
                          });
                          (context as Element).reassemble();
                          //   print(timeTemperatureIntensity);
                        }


                        //Light Intensity
                        List<charts.Series<LightIntensity, DateTime>>
                        _createLightIntensityData() {
                          int i = 0;
                          List<LightIntensity> data = [];
                          for (var x in snapshot.data.arrLightIntensity) {
                            if (i % timeLightIntensity == 0)
                              //data.add(LightIntensity(time:x.time,x.data));
                              data.add(
                                  LightIntensity(time: x.time, data: x.data));
                            i++;
                          }

                          return [
                            new charts.Series<LightIntensity, DateTime>(
                              id: 'LightIntensity',
                              colorFn: (_, __) =>
                              charts.MaterialPalette.green.shadeDefault,
                              domainFn: (LightIntensity sales, _) => sales.time,
                              measureFn: (LightIntensity sales, _) => sales.data,
                              data: data,
                            )
                          ];
                        }

                        changeLightIntensity(newLightIntensity) {
                          setState(() {
                            timeLightIntensity = newLightIntensity;
                          });
                          (context as Element).reassemble();
                          //   print(timeTemperatureIntensity);
                        }

                        //TODO: Change ends

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              CustomTimeGraph(
                                title: "Soil Temperature",
                                changeTime: changeSoilTemperature,
                                time: timeSoilTemperature,
                                createSampleData: _createSoilTemperatureData,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              CustomTimeGraph(
                                title: "Soil Moisture 1",
                                changeTime: changeSoilMoisture1,
                                time: timeSoilMoisture1,
                                createSampleData: _createSoilMoisture1Data,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              CustomTimeGraph(
                                title: "Soil Moisture 2",
                                changeTime: changeSoilMoisture1,
                                time: timeSoilMoisture2,
                                createSampleData: _createSoilMoisture2Data,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              CustomTimeGraph(
                                title: "Air Temperature",
                                changeTime: changeAirTemperature,
                                time: timeAirTemperature,
                                createSampleData: _createAirTemperatureData,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              CustomTimeGraph(
                                title: "Air Humidity",
                                changeTime: changeAirHumidity,
                                time: timeAirHumidity,
                                createSampleData: _createAirHumidityData,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              CustomTimeGraph(
                                title: "Leaf Wetness",
                                changeTime: changeLeafWetness,
                                time: timeLeafWetness,
                                createSampleData: _createLeafWetnessData,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              CustomTimeGraph(
                                title: "Light Intensity",
                                changeTime: changeLightIntensity,
                                time: timeLightIntensity,
                                createSampleData: _createLightIntensityData,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ));
  }

  _showCurrentValues(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => Scaffold(
              body: SafeArea(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    height: 150.0,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xff00A961),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset('images/moisture.png',
                                color: Colors.white, height: 20.0, width: 20.0),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'Moisture :',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Image.asset('images/light.png',
                                color: Colors.white, height: 20.0, width: 20.0),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'Light Intensity :',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Image.asset('images/temperature-high.png',
                                color: Colors.white, height: 20.0, width: 20.0),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'temperature :',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

class AllData {
  List<Moisture> moistureArr;
  List<Temperature> temperatureArr;
  List<LightIntensity1> lightIntensityArr;
  AllData({this.moistureArr, this.temperatureArr, this.lightIntensityArr});
}

Future<AllData> getAllData() async {
  List<Moisture> moistureArr = await getMoistureData();
  List<Temperature> temperatureArr = await getTemperatureData();
  List<LightIntensity1> lightIntensityArr = await getLightIntensityData();
  return AllData(
      moistureArr: moistureArr,
      temperatureArr: temperatureArr,
      lightIntensityArr: lightIntensityArr);
}

class TodaysData {
  List<SoilTemperature> arrSoilTemperature;
  List<SoilMoisture1> arrSoilMoisture1;
  List<SoilMoisture2> arrSoilMoisture2;
  List<AirTemperature> arrAirTemperature;
  List<AirHumidity> arrAirHumidity;
  List<LeafWetness> arrLeafWetness;
  List<LightIntensity> arrLightIntensity;


  double avgSoilTemperature;
  double avgSoilMoisture1;
  double avgSoilMoisture2;
  double avgAirTemperature;
  double avgAirHumidity;
  double avgAirLeafWetness;
  double avgLightIntensity;

  TodaysData({
    this.avgSoilTemperature,
    this.avgSoilMoisture1,
    this.avgSoilMoisture2,
    this.avgAirTemperature,
    this.avgAirHumidity,
    this.avgAirLeafWetness,
    this.avgLightIntensity
});
}



