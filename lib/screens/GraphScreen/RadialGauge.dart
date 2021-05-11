import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
class RadialGauge extends StatefulWidget {
  final double snapshot;
  final String name;
  RadialGauge({this.snapshot,this.name});
  @override
  _RadialGaugeState createState() => _RadialGaugeState(snapshot: snapshot,name: name);
}

class _RadialGaugeState extends State<RadialGauge> {
  final double snapshot;
  final String name;
  _RadialGaugeState({this.snapshot,this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color(0xff00A961)),
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
              minimum: 0,
              maximum: 100,
              labelOffset: 30,
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: 200,
                    sizeUnit: GaugeSizeUnit.factor,
                    startWidth: 0.03,
                    endWidth: 0.03,
                    gradient: SweepGradient(
                        colors: const <Color>[
                          Colors.green,
                          Colors.yellow,
                          Colors.red
                        ],
                        stops: const <double>[
                          0.0,
                          0.5,
                          1
                        ]))
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                    value: snapshot,
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

                          (
                          snapshot.toString()!='NaN'?
                          Text(
                              snapshot.toString().substring(0,4),
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white)):
                          Text(
                              '0.0',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white))
                          ),

                          // Text(
                          //     snapshot.toString(),
                          //     style: TextStyle(
                          //         fontSize: 25,
                          //         color: Colors.white)),
                          SizedBox(height: 10),
                          Text(name,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white))
                        ])),
                    angle: 90,
                    positionFactor: 0.75)
              ],
              axisLineStyle: AxisLineStyle(
                  thicknessUnit: GaugeSizeUnit.factor,
                  thickness: 0.03),
              majorTickStyle: MajorTickStyle(
                  length: 6,
                  thickness: 4,
                  color: Colors.white),
              minorTickStyle: MinorTickStyle(
                  length: 3,
                  thickness: 3,
                  color: Colors.white),
              axisLabelStyle: GaugeTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14))
        ],
      ),
    );
  }
}
