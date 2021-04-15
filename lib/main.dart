import 'package:flutter/material.dart';
import 'package:hotel/presentation/pages/homeUserRooms.dart';
import 'package:provider/provider.dart';

import 'presentation/provider/statusRoom_provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final prefs = new PreferenciasUsuario();
  // await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
           ChangeNotifierProvider(create: (context) => StatusRoom()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute:  '/homerooms',
          navigatorKey: navigatorKey,
          routes: {
            '/homerooms': (context) => HomeRoomsUser()
          },
        ));
  }




  
}