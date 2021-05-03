import 'dart:convert';
import 'package:farm_monitoring_flutter/models/Task.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
String uid = _auth.currentUser.uid;
String baseURL = 'https://infinite-fjord-59639.herokuapp.com/tasks/';


Future<bool> deleteTask(String id) async{
  http.Response response = await http.delete(baseURL+id);
  print(response.body);
  return true;
}

Future<List<Task>> getTasks() async{
  List<Task> arr = [];
  http.Response response = await http.get(baseURL+uid);
  if (response.statusCode == 200){
    var data = jsonDecode(response.body);
    //print(data);
    for (var x in data){
      String taskName = x['taskName'].toString();
      String taskDescription = x['taskDescription'].toString();
      DateTime date = DateTime.parse(x['date'].toString());
      Task task = new Task(taskName: taskName,taskDescription: taskDescription,date: date);
      task.id=x['_id'];
      print(task.id);
      arr.add(task);
    }
  }
  return arr;
}

