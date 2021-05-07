class FarmData{
  List<SoilTemperature> arrSoilTemperature;
  List<SoilMoisture1> arrSoilMoisture1;
  List<SoilMoisture2> arrSoilMoisture2;
  List<AirTemperature> arrAirTemperature;
  List<AirHumidity> arrAirHumidity;
  List<LeafWetness> arrLeafWetness;
  List<LightIntensity> arrLightIntensity;

  DateTime date;

  FarmData({
    this.arrSoilTemperature,
    this.arrSoilMoisture1,
    this.arrSoilMoisture2,
    this.arrAirTemperature,
    this.arrAirHumidity,
    this.arrLeafWetness,
    this.arrLightIntensity,
    this.date
  });
}

class SoilTemperature{
  int data;
  DateTime time;
  SoilTemperature({this.data,this.time});
}

class SoilMoisture1{
  int data;
  DateTime time;
  SoilMoisture1({this.data,this.time});
}

class SoilMoisture2{
  int data;
  DateTime time;
  SoilMoisture2({this.data,this.time});
}

class AirTemperature{
  int data;
  DateTime time;
  AirTemperature({this.data,this.time});
}

class AirHumidity{
  int data;
  DateTime time;
  AirHumidity({this.data,this.time});
}

class LeafWetness{
  int data;
  DateTime time;
  LeafWetness({this.data,this.time});
}

class LightIntensity{
  int data;
  DateTime time;
  LightIntensity({this.data,this.time});
}
