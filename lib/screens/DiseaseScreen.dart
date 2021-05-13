import 'package:farm_monitoring_flutter/api/get_prediction.dart';
import 'package:farm_monitoring_flutter/models/Prediction.dart';
import 'package:flutter/material.dart';

class DiseaseScreen extends StatelessWidget {

  final List<String> img = <String>[
    'https://static.vikaspedia.in/media/images_en/agriculture/crop-production/integrated-pest-managment/ipm-for-fruit-crops/ipm-strategies-for-grapes/Downymildew.jpg',
    'https://www.goodfruit.com/wp-content/uploads/Black-rot-lesions-on-leaves-indicate-potential-for-fruit-infection-1-feat2.jpg',
    'https://www.plantsbycreekside.com/wp-content/uploads/2016/06/Powdery-Mildew-on-Cucumber-Leaf.jpg',
    'https://s3-us-west-2.amazonaws.com/agfuse-web/production/article_feature_images/3c09f8c03e9a45a4f763468994ec673e.jpg',
  ];
  final List<String> name = <String>[
    "Downy mildew",
    "Karpa",
    "Bhuri",
    "Xanthomonas",
  ];
  final List<String> info = <String>[
    "The fungus is an obligate pathogen which can attack all green parts of the vine.Symptoms of this disease are frequently confused with those of powdery mildew. Infected leaves develop pale yellow-green lesions which gradually turn brown. Severely infected leaves often drop prematurely.Infected petioles, tendrils, and shoots often curl, develop a shepherd's crook, and eventually turn brown and die.Young berries are highly susceptible to infection and are often covered with white fruiting structures of the fungus. Infected older berries of white cultivars may turn dull gray-green, whereas those of black cultivars turn pinkish red.",
    "The disease manifests itself on vine, stems and young shoots. The young blossom when affected show blighting effects but if the attack is in advanced gap on berries, peculiar symptom called bird eye spot is observed. The disease occurs from June to November. It can be controlled by spraying bordeaux mixture 5:5:50 or any other copper compound containing 50 per cent metallic copper in the third week of the months of May, July, August, October, November and December at a minimum interval of at least 15 to 21 days.",
    "Whitish patches appear on both sides of the leaves. The patches also appear on sheets near base, which turn black. In severe case withering and shedding of leaves takes place. The affected blossoms fail to set in fruits. Young berries may drop when affected in early stages and in advanced stage berries crack. The disease usually prevails during the period from November to January and causes damage to about 20 to 25 per cent. It can be controlled by dusting sulphur (200-300 mesh) in the third week of the months of November, December and January.",
    "The disease is more prevalent during June-August and again in February-March. Temperature range of 25-30 C and relative humidity of 80-90% is favourable for the development of the disease. The young growing shoots are affected first. Disease infects leaves, shoots and berries. The symptoms appear as minute water soaked spots on the lower surface of the leaves along the main and lateralveins. Later on these spots coalesce and form larger patches. Brownish black lesions are formed on the berries, which later become small and shriveled."
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: getPrediction(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if (snapshot.data==null){
                return Center(child: Text("Loading..."));
              }
              else{
                List<String> predictions=[];

                predictions.add(snapshot.data.downy);
                predictions.add(snapshot.data.karpa);
                predictions.add(snapshot.data.bhuri);
                predictions.add(snapshot.data.xanthomonas);
                return Center(
                  child: ListView.builder(
                      itemCount: name.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                          width: double.infinity,
                          child: Card(
                            color: Color(0xff00A961),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    img[index],
                                    height: 200,
                                    width: 300,
                                    fit: BoxFit.cover,
                                  ),
                                  //SizedBox(height: 10.0,child: Container(color: Colors.white,),),
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Text(
                                          name[index],
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(info[index],style: TextStyle(color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 20.0,top: 10.0,bottom: 10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Probability',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                        Row(
                                          children: [
                                            Image.asset('images/temperature-high.png',color: Colors.white,width: 20.0,height: 20.0,),
                                            Text(predictions[index].toUpperCase(),style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),

                                          ],),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
            },
          )

        ),
      ),
    );
  }
}
