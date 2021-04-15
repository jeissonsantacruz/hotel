// Flutter dependencies
import 'package:flutter/material.dart';
import 'package:hotel/presentation/provider/statusRoom_provider.dart';
import 'package:hotel/presentation/widgets/customButtom_widget.dart';
import 'package:hotel/presentation/widgets/percentIndicator_widget.dart';
import 'package:hotel/presentation/widgets/stopWatch_widget.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrentTab extends StatefulWidget {
  @override
  _CurrentTabState createState() => _CurrentTabState();
}

class _CurrentTabState extends State<CurrentTab> {
  final TextEditingController feedController = new TextEditingController();

  bool status = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final roomStatus = Provider.of<StatusRoom>(context);
    return Column(
      children: [
        status?Card(child:  Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text('cronometro'),
                     )):Card(
          color: Colors.white70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: Text('MY PROGRESS'),
              ),
              PercentIndicator(),
              SizedBox(height: 30),
              Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    width: 340,
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Text('Next Assigment'),
                        Text('Room 10054'),
                        Text('Individual')
                      ],
                    ),
                  )),
            ],
          ),
        ),
        status?MyCustomButtoms(
          icon: FontAwesomeIcons.pause,
          hintText: 'PAUSE',
          colors: [Colors.orangeAccent[400], Colors.orangeAccent[700]],
          onPressed: () {
           setState(() {
                  status = false;
            });
        
          },
        ):MyCustomButtoms(
          icon: FontAwesomeIcons.play,
          hintText: 'START CLEANING',
          colors: [Colors.greenAccent[400], Colors.greenAccent[700]],
          onPressed: () {
            setState(() {
                  status = true;
            });
        
          },
        ),
     

      ],
    );
  }
}
