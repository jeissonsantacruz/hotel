// Flutter dependencies
import 'package:flutter/material.dart';
import 'package:hotel/data/datasources/providerRoom_datasource.dart';
import 'package:hotel/data/models/room_model.dart';
import 'package:hotel/presentation/widgets/customCard_widget.dart';
import 'package:hotel/presentation/widgets/percentIndicator_widget.dart';

class AllTab extends StatefulWidget {
  @override
  _AllTabState createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  final TextEditingController feedController = new TextEditingController();

  final servicios = ServiciosGestionCci();

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
                      children: [Text('Total Rooms',style: TextStyle(fontSize: 16)), Text('10',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28))],
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
                  final diligenciauctos = snapshot.data;

                  return Container(
                    child: ListView.builder(
                        itemCount: diligenciauctos.length,
                        itemBuilder: (context, i) =>
                            CustomCard(diligenciauctos[i], true, null)),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ],
    );
  }
}
