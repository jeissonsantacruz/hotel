// Flutter dependencies
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//MENU DRAWER CLASS
class MenuWidget extends StatelessWidget {
  final TextEditingController feedController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
                margin:  EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Hello!',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300)),
                  ),
                  SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Andrew',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ])),
          ),
          new CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 10.0,
            percent: 0.8,
            header:
                new Text('366', style: TextStyle(fontWeight: FontWeight.bold)),
            center: new IconButton(
              icon: Icon(FontAwesomeIcons.gem),
              iconSize: 30.0,
              color: Colors.blue,
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Soon you will be able to redeem your points.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.redAccent[700],
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
            ),
            backgroundColor: Colors.white,
            progressColor: Colors.blue,
          ),
          // content the perfil data and  go to page info user
          ListTile(
              leading: Icon(
                FontAwesomeIcons.locationArrow,
                color:  Colors.black,
              ),
              title: Text('City:',
                  style: TextStyle(
                      fontSize: size.width * 0.033, color:  Colors.black)),
              trailing: Text('Cali',
                  style: TextStyle(
                      fontSize: size.width * 0.033, color: Colors.black)),
              onTap: () {}),
          ListTile(
              leading: Icon(
                FontAwesomeIcons.city,
                color: Colors.black,
              ),
              title: Text('Office:',
                  style: TextStyle(
                      fontSize: size.width * 0.033, color:  Colors.black)),
              trailing: Text('Intercontinental-656',
                  style: TextStyle(
                      fontSize: size.width * 0.033, color: Colors.black)),
              onTap: () {}),
        

          ListTile(
              leading: Icon(
                FontAwesomeIcons.comment,
                color: Colors.black,
              ),
              title: Text('Sugerencias'),
              onTap: () {
                _sendCommet(context);
              }),
        ],
      ),
    );
  }

  _sendCommet(context) {
    Alert(
        context: context,
        title: "COMENTARIOS",
        content: Column(
          children: <Widget>[
            Container(
              height: 200,
              color: Color(0xffeeeeee),
              padding: EdgeInsets.all(10.0),
              child: new ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 200.0,
                ),
                child: new Scrollbar(
                  child: new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    child: SizedBox(
                      height: 190.0,
                      child: new TextField(
                        controller: feedController,
                        maxLines: 100,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Escribe tu comentario aquí',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {},
            child: Text(
              "Enviar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
