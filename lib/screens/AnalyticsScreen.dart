import 'package:bubble_timeline/bubble_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bubble_timeline/timeline_item.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';


DateTime currentDate;
class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
    List<TimelineItem> StagesOFSeason = [
      TimelineItem(
        title: 'Stage 1',
        subtitle: 'Foundation Pruning',
        child: DateTimePicker(),
        bubbleColor: Color(0xff00A962),
      ),
      TimelineItem(
        title: 'Stage 2',
        subtitle: 'Breaking Bud',
        child: DateTimePicker(),
        bubbleColor: Color(0xff00A962),
      ),
      TimelineItem(
        title: 'Stage 3',
        subtitle: 'Shoot Development',
        child: DateTimePicker(),
        bubbleColor: Color(0xff00A962),
      ),
      TimelineItem(
        title: 'Stage 4',
        subtitle: 'Subcane',
        child: DateTimePicker(),
        bubbleColor: Color(0xff00A962),
      ),
      TimelineItem(
        title: 'Stage 5',
        subtitle: 'Cane Maturity',
        child: DateTimePicker(),
        bubbleColor: Color(0xff00A962),
      ),
      TimelineItem(
        title: 'Stage 6',
        subtitle: 'Fruit Pruning',
        child: DateTimePicker(),
        bubbleColor: Color(0xff00A962),
      ),
      TimelineItem(
        title: 'Stage 7',
        subtitle: 'Breaking Bud',
        child: DateTimePicker(),
        bubbleColor: Color(0xff00A962),
      ),
      TimelineItem(
        title: 'Stage 8',
        subtitle: 'Shoot Development',
        child: DateTimePicker(),
        bubbleColor: Color(0xff00A962),
      ),
      TimelineItem(
        title: 'Stage 9',
        subtitle: 'Begining of Bloom',
        child: DateTimePicker(),
        bubbleColor: Color(0xff00A962),
      ),
      TimelineItem(
        title: 'Stage 10',
        subtitle: 'Fruit Set',
        child: DateTimePicker(),
        bubbleColor: Color(0xff00A962),
      ),
      TimelineItem(
        title: 'Stage 11',
        subtitle: 'Berry Development',
        child: DateTimePicker(),
        bubbleColor: Color(0xff00A962),
      ),
      TimelineItem(
        title: 'Stage 12',
        subtitle: ' Begining Verasion',
        child: DateTimePicker(),
        bubbleColor: Color(0xff00A962),
      ),
      TimelineItem(
        title: 'Stage 13',
        subtitle: 'Harvest',
        child: DateTimePicker(),
        bubbleColor: Color(0xff00A962) ,
      ),


  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
        child: Column(
          children: [
            Center(child: Text('Crop Stages',style: TextStyle(color: Colors.black),),),
            SizedBox(height: 15.0,),
            BubbleTimeline(
                bubbleDiameter: 130,
                items: StagesOFSeason,
                stripColor: Color(0xff94e876),
                scaffoldColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  Widget dateWidget=Icon(CupertinoIcons.calendar,color: Colors.white,);
  // IconData icon=CupertinoIcons.calendar;
  Color colors=Colors.white;
  @override
  Widget build(BuildContext context) {
    DateTime newDateTime;
    return FlatButton(onPressed: ()async {
      newDateTime = await showRoundedDatePicker(
          context: context,
          theme: ThemeData(primarySwatch: Colors.green),
          initialDate: DateTime.now(),

          firstDate: DateTime(DateTime.now().year - 10),
          lastDate: DateTime(DateTime.now().year + 10),
        styleDatePicker: MaterialRoundedDatePickerStyle(
          decorationDateSelected: BoxDecoration(color: Colors.orange[600], shape: BoxShape.circle) ,)
      );
      setState(() {
        currentDate=newDateTime;
        // icon=CupertinoIcons.checkmark_seal_fill;
        String date=currentDate.day.toString()+'-'+currentDate.month.toString()+'-'+currentDate.year.toString();
        dateWidget=Text(date,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),);
      });
    },
      child: dateWidget,
    );
  }
}











