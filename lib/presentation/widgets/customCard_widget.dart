
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel/presentation/provider/statusRoom_provider.dart';
import 'package:provider/provider.dart';

import 'dart:ui';

import 'package:hotel/data/models/room_model.dart';

class CustomCard extends StatelessWidget {
  final Room _room;
  final bool gestionar;
  final Function function;
  CustomCard(this._room, this.gestionar, this.function);

  @override
  Widget build(BuildContext context) {
    // Data server Url
    final size = MediaQuery.of(context).size;
    final roomModel = Provider.of<StatusRoom>(context);
    return GestureDetector(
        onTap: () {
          if (gestionar) {
            function();
            roomModel.room=_room;
            roomModel.status= true;
          }
        },
        child: Container(
          height: size.width * 0.25,
          child: Card(
              elevation: 2,
              child: ListTile(
                title: Text(_room.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                subtitle: Text(_room.type),
                trailing: _room.time == null
                    ? Icon(
                        Icons.chevron_right,
                        color: Color(0xFF0A2140),
                      )
                    : Text( _room.time+
                    
                       '\u{2714}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                      ),
              )),
        ));
  }
}
