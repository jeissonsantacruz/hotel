// Flutter dependencies
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

//MENU DRAWER CLASS
class PercentIndicator extends StatelessWidget {
  final TextEditingController feedController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left:18.0),
      child: new LinearPercentIndicator(
        width: 300.0,
        animation: true,
        animationDuration: 1000,
        lineHeight: 23.0,
        leading: new Text("0/20"),
        trailing: new Text("80%"),
        percent: 0.2,
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Colors.blue,
      
        backgroundColor:  Colors.white,
      ),
    );
  }
}
