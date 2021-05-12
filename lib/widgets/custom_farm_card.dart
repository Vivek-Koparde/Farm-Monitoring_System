import 'package:farm_monitoring_flutter/api/get_farm.dart';
import 'package:farm_monitoring_flutter/models/Farm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FarmCard extends StatelessWidget {
  final Farm farm;
  Function fun;
  FarmCard({this.farm, this.fun});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          selectFarm(farm.id, context);
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: farm.isSelected ? Colors.green : Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0,top: 10.0,bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Farm Name : ' + farm.farmName,
                  style: farm.isSelected
                      ? TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)
                      : TextStyle(color: Colors.green),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text('Longitude : ' + farm.longitude.toString(),
                            style: farm.isSelected
                                ? TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold)
                                : TextStyle(color: Colors.green)),
                        Text('Latitude : ' + farm.latitude.toString(),
                            style: farm.isSelected
                                ? TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold)
                                : TextStyle(color: Colors.green)),
                        Text('Area : ' + farm.area.toString(),
                            style: farm.isSelected
                                ? TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold)
                                : TextStyle(color: Colors.green)),
                        Text('Is Selected : ' + farm.isSelected.toString(),
                            style: farm.isSelected
                                ? TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold)
                                : TextStyle(color: Colors.green)),
                      ],
                    ),
                    SizedBox(width: 30.0,),
                    Image.asset('images/Plot.png',height:90.0,width: 100.0,)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  selectFarm(String farmId, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: SpinKitDoubleBounce(
                itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index.isEven ? Colors.white : Color(0xff00A961),
                ),
              );
            }),
          );
        });
    String selectedFarmId = await getSelectedFarmId();
    await changeFarmSelectedStatus(selectedFarmId, "false");
    await changeFarmSelectedStatus(farmId, "true");
    fun(() {
      print("SET STAET");
    });
    Navigator.pop(context);
  }
}
