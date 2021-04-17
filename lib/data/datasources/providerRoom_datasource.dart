import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:hotel/data/models/room_model.dart';

class ServiciosGestionCci {
  final String urlTest = 'http://190.121.138.85/controladores/accAgencias.php';
  List<Room> _rooms = new List();
  Future<List<Room>> listrooms() async {
    var data = {"funcionphp": "listarRegistros", "dispositivo": "movil"};
    var dio = Dio();
    final encodedData = FormData.fromMap(data);
    Response response = await dio.post(urlTest, data: encodedData);

    final decodeData = jsonDecode(response.data);
    var list = decodeData['listarRegistros'] as List;

    _rooms = list.map((i) => Room.fromJson(i)).toList();

    return _rooms;
  }

  Future updatestatus(String status, String time, String oidroom) async {
    var data = {
      "funcionphp": "updateStatus",
      "dispositivo": "movil",
      "status": status,
      "time": time,
      "oidroom":oidroom
    };
    var dio = Dio();
    final encodedData = FormData.fromMap(data);
    Response response = await dio.post(urlTest, data: encodedData);
    print(response.statusCode.toString());
  }
}
