// Flutter dependencies

import 'package:flutter/material.dart';
import 'package:hotel/data/datasources/providerRoom_datasource.dart';
import 'package:hotel/data/models/room_model.dart';
import 'package:hotel/presentation/widgets/customCard_widget.dart';
import 'package:hotel/presentation/widgets/percentIndicator_widget.dart';

class PendingTab extends StatefulWidget {
  final Function function;
  PendingTab(this.function);
  @override
  _PendingTabState createState() => _PendingTabState();
}

class _PendingTabState extends State<PendingTab> {
  final TextEditingController feedController = new TextEditingController();

  final servicios = ServiciosGestionCci();
  List<Room> roomList = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 1), () {
          setState(() async {
            roomList = await servicios.listrooms();
          });
        }
            // showing snackbar

            );
      },
      child: Column(
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
          Expanded(
            child: FutureBuilder(
                future: servicios.listrooms(), // llamado al servicio
                builder:
                    (BuildContext context, AsyncSnapshot<List<Room>> snapshot) {
                  if (snapshot.hasData && snapshot.data.isNotEmpty) {
                    roomList = snapshot.data;

                    return Container(
                      child: ListView.builder(
                          itemCount: roomList.length,
                          itemBuilder: (context, i) => roomList[i].status !=
                                  'CLEANED'
                              ? CustomCard(roomList[i], true, widget.function)
                              : Container()),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }

  onRefresh() {
    return Future.delayed(Duration(seconds: 1), () {
      setState(() async {
        roomList = await servicios.listrooms();
      });
    });
  }
}
