// Flutter dependencies
import 'package:flutter/material.dart';
import 'package:hotel/presentation/widgets/percentIndicator_widget.dart';

class PendingTab extends StatelessWidget {
  final TextEditingController feedController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Card(
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
                      children: [Text('Total Rooms'), Text('8')],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
