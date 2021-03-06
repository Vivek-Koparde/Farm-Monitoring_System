import 'package:farm_monitoring_flutter/api/get_farm.dart';
import 'package:farm_monitoring_flutter/api/get_farm_data.dart';
import 'package:farm_monitoring_flutter/models/Farm.dart';
import 'package:farm_monitoring_flutter/screens/login.dart';
import 'package:farm_monitoring_flutter/widgets/custom_farm_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
@override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    print('set state called');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/farmer_profile.png'),
                        radius: 50,
                      ),
                      Column(
                        children: [
                          Text(
                            _auth.currentUser.email,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 10,),
                          FlatButton(
                            color: Colors.green,
                            onPressed: () async{
                              _auth.signOut();
                                Navigator.popAndPushNamed(context, Login.id);
                              // TODO: change to normal
                              // await getFirstFarm();
                            },
                            child:Text('Logout'),
                          )
                        ],
                      )
                    ],
                ),
                FutureBuilder(
                    future: getFarm(),
                    builder: (BuildContext context,AsyncSnapshot snapshot) {
                      if (snapshot.data==null){
                        return Center(
                          child: Text("Data Loading"),
                        );
                      }
                      else{
                        if (snapshot.data.length==0){
                          return Center(
                            child: Text("No data found"),
                          );
                        }
                        String s='';
                        List<Farm> farmList=[];
                        for (Farm x in snapshot.data){
                          s+=x.farmName+"\n";
                          farmList.add(x);
                        }
                        print("LENGTH OF FARM" +farmList.length.toString());
                        return ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: farmList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return  FarmCard(farm:farmList[index],fun: setState,);
                            }
                        );
                      }
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

