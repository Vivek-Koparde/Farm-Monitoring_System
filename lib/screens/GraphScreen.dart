import 'package:farm_monitoring_flutter/api/get_light_intensity.dart';
import 'package:farm_monitoring_flutter/api/get_temperature.dart';
import 'package:farm_monitoring_flutter/api/get_moisture.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:farm_monitoring_flutter/widgets/CustomeTimeGraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GraphScreen extends StatefulWidget {
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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: Container(
        child: FutureBuilder(
            future: getTodaysData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Loading..."),
                      Lottie.asset('images/tractor_animation.json')
                    ],
                  )),
                );
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column (
                      children: [Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),color: Color(0xff00A961)),
                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                                minimum: 0,
                                maximum: 200,
                                labelOffset: 30,
                                ranges: <GaugeRange>[
                                  GaugeRange(
                                      startValue: 0,
                                      endValue: 200,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      startWidth: 0.03,
                                      endWidth: 0.03,
                                      gradient: SweepGradient(colors: const <Color>[
                                        Colors.green,
                                        Colors.yellow,
                                        Colors.red
                                      ], stops: const <double>[
                                        0.0,
                                        0.5,
                                        1
                                      ]))
                                ],
                                pointers: <GaugePointer>[
                                  NeedlePointer(
                                      value: snapshot.data.avgMoisture,
                                      needleLength: 0.95,
                                      enableAnimation: true,
                                      animationType: AnimationType.ease,
                                      needleStartWidth: 1.5,
                                      needleEndWidth: 6,
                                      needleColor: Colors.red,
                                      knobStyle: KnobStyle(knobRadius: 0.09))
                                ],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                      widget: Container(
                                          child: Column(children: <Widget>[
                                            SizedBox(
                                              height: 80.0,
                                            ),
                                            Text(snapshot.data.avgMoisture.toString(),
                                                style: TextStyle(
                                                    fontSize: 25, color: Colors.white)),
                                            SizedBox(height: 10),
                                            Text('Moisture',
                                                style: TextStyle(
                                                    fontSize: 14, color: Colors.white))
                                          ])),
                                      angle: 90,
                                      positionFactor: 0.75)
                                ],
                                axisLineStyle: AxisLineStyle(
                                    thicknessUnit: GaugeSizeUnit.factor, thickness: 0.03),
                                majorTickStyle: MajorTickStyle(
                                    length: 6, thickness: 4, color: Colors.white),
                                minorTickStyle: MinorTickStyle(
                                    length: 3, thickness: 3, color: Colors.white),
                                axisLabelStyle: GaugeTextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14))
                          ],
                        ),
                      ),
                        SizedBox(height:20.0),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),color: Color(0xff00A961)),
                          child: SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(
                                  minimum: 0,
                                  maximum: 200,
                                  labelOffset: 30,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                        startValue: 0,
                                        endValue: 200,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        startWidth: 0.03,
                                        endWidth: 0.03,
                                        gradient: SweepGradient(colors: const <Color>[
                                          Colors.green,
                                          Colors.yellow,
                                          Colors.red
                                        ], stops: const <double>[
                                          0.0,
                                          0.5,
                                          1
                                        ]))
                                  ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                        value: snapshot.data.avgTemperature,
                                        needleLength: 0.95,
                                        enableAnimation: true,
                                        animationType: AnimationType.ease,
                                        needleStartWidth: 1.5,
                                        needleEndWidth: 6,
                                        needleColor: Colors.red,
                                        knobStyle: KnobStyle(knobRadius: 0.09))
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        widget: Container(
                                            child: Column(children: <Widget>[
                                              SizedBox(
                                                height: 80.0,
                                              ),
                                              Text(snapshot.data.avgTemperature.toString().substring(0,5),
                                                  style: TextStyle(
                                                      fontSize: 25, color: Colors.white)),
                                              SizedBox(height: 10),
                                              Text('Temperature',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.white))
                                            ])),
                                        angle: 90,
                                        positionFactor: 0.75)
                                  ],
                                  axisLineStyle: AxisLineStyle(
                                      thicknessUnit: GaugeSizeUnit.factor, thickness: 0.03),
                                  majorTickStyle: MajorTickStyle(
                                      length: 6, thickness: 4, color: Colors.white),
                                  minorTickStyle: MinorTickStyle(
                                      length: 3, thickness: 3, color: Colors.white),
                                  axisLabelStyle: GaugeTextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14))
                            ],
                          ),
                        ),
                        SizedBox(height:20.0),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),color: Color(0xff00A961)),
                          child: SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(
                                  minimum: 0,
                                  maximum: 200,
                                  labelOffset: 30,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                        startValue: 0,
                                        endValue: 200,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        startWidth: 0.03,
                                        endWidth: 0.03,
                                        gradient: SweepGradient(colors: const <Color>[
                                          Colors.green,
                                          Colors.yellow,
                                          Colors.red
                                        ], stops: const <double>[
                                          0.0,
                                          0.5,
                                          1
                                        ]))
                                  ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                        value: snapshot.data.avgLightIntensity,
                                        needleLength: 0.95,
                                        enableAnimation: true,
                                        animationType: AnimationType.ease,
                                        needleStartWidth: 1.5,
                                        needleEndWidth: 6,
                                        needleColor: Colors.red,
                                        knobStyle: KnobStyle(knobRadius: 0.09))
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        widget: Container(
                                            child: Column(children: <Widget>[
                                              SizedBox(
                                                height: 80.0,
                                              ),
                                              Text(snapshot.data.avgLightIntensity.toString().substring(0,5),
                                                  style: TextStyle(
                                                      fontSize: 25, color: Colors.white)),
                                              SizedBox(height: 10),
                                              Text('Light Intensity',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.white))
                                            ])),
                                        angle: 90,
                                        positionFactor: 0.75)
                                  ],
                                  axisLineStyle: AxisLineStyle(
                                      thicknessUnit: GaugeSizeUnit.factor, thickness: 0.03),
                                  majorTickStyle: MajorTickStyle(
                                      length: 6, thickness: 4, color: Colors.white),
                                  minorTickStyle: MinorTickStyle(
                                      length: 3, thickness: 3, color: Colors.white),
                                  axisLabelStyle: GaugeTextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14))
                            ],
                          ),
                        )],
                    ),
                  ),
                );
              }
            }),
      )),
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
            child: Image.asset('images/graph.png',
              color: Colors.white,
            ),
            backgroundColor: Color(0xff00A961),
            label: 'Show Graph',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => _showGraph(context),
          ),
          SpeedDialChild(
            child: Image.asset('images/current_value.png',
              color: Colors.white,
            ),
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
                    future: getAllData(),
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
                        List<charts.Series<Moisture, DateTime>>
                            _createMoistureData() {
                          int i = 0;
                          List<Moisture> data = [];
                          for (var x in snapshot.data.moistureArr) {
                            if (i % timeMoisture == 0)
                              data.add(Moisture(time: x.time, data: x.data));
                            i++;
                          }
                          return [
                            new charts.Series<Moisture, DateTime>(
                              id: 'Moisture',
                              colorFn: (_, __) =>
                                  charts.MaterialPalette.green.shadeDefault,
                              domainFn: (Moisture sales, _) => sales.time,
                              measureFn: (Moisture sales, _) => sales.data,
                              data: data,
                            )
                          ];
                        }

                        changeMoisture(newMoisture) {
                          setState(() {
                            timeMoisture = newMoisture;
                          }); // print(timeTemperatureIntensity);
                          (context as Element).reassemble();
                        }
                        // return ListView.builder(
                        //     itemCount: snapshot.data.length,
                        //     itemBuilder: (BuildContext context,int index){
                        //       return ListTile(
                        //         title: Text(snapshot.data[index].data.toString()),
                        //       );
                        //     }
                        // );

                        List<charts.Series<Temperature, DateTime>>
                            _createTemperatureData() {
                          int i = 0;
                          List<Temperature> data = [];
                          for (var x in snapshot.data.temperatureArr) {
                            if (i % timeTemperature == 0)
                              data.add(Temperature(time: x.time, data: x.data));
                            i++;
                          }

                          return [
                            new charts.Series<Temperature, DateTime>(
                              id: 'Temperature',
                              colorFn: (_, __) =>
                                  charts.MaterialPalette.green.shadeDefault,
                              domainFn: (Temperature sales, _) => sales.time,
                              measureFn: (Temperature sales, _) => sales.data,
                              data: data,
                            )
                          ];
                        }

                        changeTemperature(newTemperature) {
                          setState(() {
                            timeTemperature = newTemperature;
                          });
                          (context as Element).reassemble();
                          //   print(timeTemperatureIntensity);
                        }

                        List<charts.Series<LightIntensity, DateTime>>
                            _createLightIntensityData() {
                          int i = 0;
                          List<LightIntensity> data = [];
                          for (var x in snapshot.data.lightIntensityArr) {
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
                              measureFn: (LightIntensity sales, _) =>
                                  sales.data,
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

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              CustomTimeGraph(
                                title: "Moisture",
                                changeTime: changeMoisture,
                                time: timeMoisture,
                                createSampleData: _createMoistureData,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              CustomTimeGraph(
                                title: "Temperature",
                                changeTime: changeTemperature,
                                time: timeTemperature,
                                createSampleData: _createTemperatureData,
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
  List<LightIntensity> lightIntensityArr;
  AllData({this.moistureArr, this.temperatureArr, this.lightIntensityArr});
}

Future<AllData> getAllData() async {
  List<Moisture> moistureArr = await getMoistureData();
  List<Temperature> temperatureArr = await getTemperatureData();
  List<LightIntensity> lightIntensityArr = await getLightIntensityData();
  return AllData(
      moistureArr: moistureArr,
      temperatureArr: temperatureArr,
      lightIntensityArr: lightIntensityArr);
}

class TodaysData{
  double avgMoisture;
  double avgTemperature;
  double avgLightIntensity;
  TodaysData({this.avgMoisture,this.avgTemperature,this.avgLightIntensity});
}

Future<TodaysData> getTodaysData() async {
  List<Moisture> moistureArr = await getTodaysMoistureData();
  List<Temperature> temperatureArr = await getTodaysTemperatureData();
  List<LightIntensity> lightIntensityArr = await getTodaysLightIntensityData();

  double sumMoisture = 0.0;
  for (Moisture m in moistureArr){
    sumMoisture += m.data;
  }
  double avgMoisture = sumMoisture/moistureArr.length;
  double sumTemperature = 0.0;
  for (Temperature m in temperatureArr){
    sumTemperature += m.data;
  }
  double avgTemperature = sumTemperature/temperatureArr.length;

  double sumLightIntensity = 0.0;
  for (LightIntensity m in lightIntensityArr){
    sumLightIntensity += m.data;
  }
  double avgLightIntensity = sumLightIntensity/lightIntensityArr.length;
  return TodaysData(
    avgMoisture: avgMoisture,
    avgTemperature: avgTemperature,
    avgLightIntensity: avgLightIntensity
  );
}