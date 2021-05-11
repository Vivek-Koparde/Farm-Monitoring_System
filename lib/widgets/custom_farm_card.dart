import 'package:farm_monitoring_flutter/api/get_farm.dart';
import 'package:farm_monitoring_flutter/models/Farm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FarmCard extends StatelessWidget {
  final Farm farm;
  Function fun;
  FarmCard({this.farm,this.fun});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: (){selectFarm(farm.id,context);},
        child: Card(
          color: farm.isSelected?Colors.green:Colors.white,
          child: Column(
            children: [
              Text('Farm Name : ' + farm.farmName),
              Text('Longitude : ' + farm.longitude.toString()),
              Text('Latitude : ' + farm.latitude.toString()),
              Text('Area : ' + farm.area.toString()),
              Text('Is Selected : '+farm.isSelected.toString()),
            ],
          ),
        ),
      ),
    );
  }

  selectFarm(String farmId,BuildContext context) async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: SpinKitDoubleBounce(
                itemBuilder:
                    (BuildContext context,
                    int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index.isEven
                          ? Colors.white
                          : Color(0xff00A961),
                    ),
                  );
                }),
          );
        });
    String selectedFarmId = await getSelectedFarmId();
    await changeFarmSelectedStatus(selectedFarmId,"false");
    await changeFarmSelectedStatus(farmId,"true");
    fun((){
      print("SET STAET");
    });
    Navigator.pop(context);
  }
}
