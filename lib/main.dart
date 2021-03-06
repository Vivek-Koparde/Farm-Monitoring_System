import 'package:farm_monitoring_flutter/api/get_data.dart';
import 'package:farm_monitoring_flutter/home_screen.dart';
import 'package:farm_monitoring_flutter/screens/GraphScreen/GraphScreen.dart';
import 'package:farm_monitoring_flutter/screens/bottom_nav_screen.dart';
import 'package:farm_monitoring_flutter/screens/login.dart';
import 'package:farm_monitoring_flutter/screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/': (context) => _auth.currentUser!=null?BottomNavigationScreen():Login(),
          HomeScreen.id: (context) => HomeScreen(),
          SignUp.id: (context) => SignUp(),
          Login.id: (context) => Login(),
          BottomNavigationScreen.id:(context)=>BottomNavigationScreen(),
          GraphScreen.id: (context)=> GraphScreen(),
        },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //getData(context);
    getData(context);
    return Scaffold(
      body: Center(
        // child: SpinKitDoubleBounce(
        //   color: Colors.black54,
        // ),
        child: Lottie.network('https://assets3.lottiefiles.com/private_files/lf30_7yNCzX.json'),
      ),
    );
  }
}


class CustomCard extends StatelessWidget {

  final String name;
  final String image;
  final String subtitle;
  CustomCard({this.name,this.image,this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            name,
          ),
          Image.asset(
              'images/$image',
              height: 80,
              width: 80,
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}

