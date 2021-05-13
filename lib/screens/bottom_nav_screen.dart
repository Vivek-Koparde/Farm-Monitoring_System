import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:farm_monitoring_flutter/api/get_data.dart';

import 'package:farm_monitoring_flutter/screens/AnalyticsScreen.dart';
import 'package:farm_monitoring_flutter/screens/CalenderScreen.dart';
import 'package:farm_monitoring_flutter/screens/DiseaseScreen.dart';

import 'package:farm_monitoring_flutter/screens/GraphScreen/GraphScreen.dart';
import 'package:farm_monitoring_flutter/screens/ProfileScreen.dart';

import 'package:flutter/material.dart';

class BottomNavigationScreen extends StatefulWidget {

  static String id = 'bottom_nav_screen';
  // var dataLightIntensity;
  // var dataTemperature;
  // var dataMoisture;

  //BottomNavigationScreen({this.dataLightIntensity,this.dataTemperature,this.dataMoisture});

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState(

  );
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int currentIndex = 0;
  var temperature;
  var moisture;
  var lightIntensity;
  List listOfScreens=[];
  
  _BottomNavigationScreenState();

  getAllData() async{
    DataFormat data = await getData(context);
    temperature = data.dataTemperature;
    moisture = data.dataMoisture;
    lightIntensity = data.dataLightIntensity;

  }

  @override
  Widget build(BuildContext context) {
     listOfScreens = [
      GraphScreen(),
      Calender(),
      DiseaseScreen(),
       AnalyticsScreen(),
      ProfileScreen(),
    ];
    return Scaffold(

      body: listOfScreens[currentIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        onItemSelected: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Image.asset(
                'images/bottomnavigation/farm.png',
                color: currentIndex==0?Colors.green:Colors.black,
                width: 30,
                height: 30,
              ),
              title: Text("Farm"),
              activeColor: Colors.green,
              inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Image.asset(
              'images/bottomnavigation/calendar.png',
              color: currentIndex==1?Colors.green:Colors.black,
              width: 25,
              height: 25,
            ),
            title: Text("Calendar"),
            activeColor: Colors.green,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Image.asset(
              'images/bottomnavigation/disease.png',
              color: currentIndex==2?Colors.green:Colors.black,
              width: 30,
              height: 30,
            ),
            title: Text("Disease"),
            activeColor: Colors.green,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Image.asset(
              'images/bottomnavigation/analytics.png',
              color: currentIndex==3?Colors.green:Colors.black,
              width: 25,
              height: 25,
            ),
            title: Text("Analytics"),
            activeColor: Colors.green,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Image.asset(
              'images/bottomnavigation/plot.png',
              color: currentIndex==4?Colors.green:Colors.black,
              width: 25,
              height: 25,
            ),
            title: Text("Plot"),
            activeColor: Colors.green,
            inactiveColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
