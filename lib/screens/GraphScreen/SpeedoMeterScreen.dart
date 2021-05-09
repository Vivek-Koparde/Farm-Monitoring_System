import 'package:farm_monitoring_flutter/api/get_farm_data.dart';
import 'package:farm_monitoring_flutter/models/FarmData.dart';
import 'package:farm_monitoring_flutter/screens/GraphScreen/RadialGauge.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'GraphScreen.dart';

class SpeedoMeter extends StatefulWidget {
  @override
  _SpeedoMeterState createState() => _SpeedoMeterState();
}

class _SpeedoMeterState extends State<SpeedoMeter> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: Column(
                    children: [
                      RadialGauge(
                          snapshot: snapshot.data.avgSoilTemperature,
                          name: 'Soil Temperature'),
                      SizedBox(height: 20.0),
                      RadialGauge(
                          snapshot: snapshot.data.avgSoilMoisture1,
                          name: 'Soil Moisture 1'),
                      SizedBox(height: 20.0),
                      RadialGauge(
                          snapshot: snapshot.data.avgSoilMoisture2,
                          name: 'Soil Moisture 2'),
                      SizedBox(height: 20.0),
                      RadialGauge(
                          snapshot: snapshot.data.avgAirHumidity,
                          name: 'Air Humidity'),
                      SizedBox(height: 20.0),
                      RadialGauge(
                          snapshot: snapshot.data.avgAirTemperature,
                          name: 'Air Temperature'),
                      SizedBox(height: 20.0),
                      RadialGauge(
                          snapshot: snapshot.data.avgAirLeafWetness,
                          name: 'Air Leaf Wetness'),
                      SizedBox(height: 20.0),
                      RadialGauge(
                          snapshot: snapshot.data.avgLightIntensity,
                          name: 'Light Intensity'),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  Future<TodaysData> getTodaysData() async {
    FarmData todaysFarmData = await getTodaysFarmData();

    double sumSoilTemperature = 0.0;
    for (SoilTemperature m in todaysFarmData.arrSoilTemperature) {
      sumSoilTemperature += m.data;
    }
    double avgSoilTemperature =
        sumSoilTemperature / todaysFarmData.arrSoilTemperature.length;

    double sumSoilMoisture1 = 0.0;
    for (SoilMoisture1 m in todaysFarmData.arrSoilMoisture1) {
      sumSoilMoisture1 += m.data;
    }
    double avgSoilMoisture1 =
        sumSoilMoisture1 / todaysFarmData.arrSoilMoisture1.length;

    double sumSoilMoisture2 = 0.0;
    for (SoilMoisture2 m in todaysFarmData.arrSoilMoisture2) {
      sumSoilMoisture2 += m.data;
    }
    double avgSoilMoisture2 =
        sumSoilMoisture2 / todaysFarmData.arrSoilMoisture2.length;

    double sumAirTemperature = 0.0;
    for (AirTemperature m in todaysFarmData.arrAirTemperature) {
      sumAirTemperature += m.data;
    }
    double avgAirTemperature =
        sumAirTemperature / todaysFarmData.arrAirTemperature.length;

    double sumAirHumidity = 0.0;
    for (AirHumidity m in todaysFarmData.arrAirHumidity) {
      sumAirHumidity += m.data;
    }
    double avgAirHumidity =
        sumAirHumidity / todaysFarmData.arrAirHumidity.length;

    double sumLeafWetness = 0.0;
    for (LeafWetness m in todaysFarmData.arrLeafWetness) {
      sumLeafWetness += m.data;
    }
    double avgLeafWetness =
        sumLeafWetness / todaysFarmData.arrLeafWetness.length;

    double sumLightIntensity = 0.0;
    for (LightIntensity m in todaysFarmData.arrLightIntensity) {
      sumLightIntensity += m.data;
    }
    double avgLightIntensity =
        sumLightIntensity / todaysFarmData.arrLightIntensity.length;

    return TodaysData(
        avgSoilTemperature: avgSoilTemperature,
        avgSoilMoisture1: avgSoilMoisture1,
        avgSoilMoisture2: avgSoilMoisture2,
        avgAirHumidity: avgAirHumidity,
        avgAirTemperature: avgAirTemperature,
        avgAirLeafWetness: avgLeafWetness,
        avgLightIntensity: avgLightIntensity);
  }
}
