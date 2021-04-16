import 'package:flutter/material.dart';
import 'package:hotel/data/models/room_model.dart';

class StatusRoom with ChangeNotifier {
  
  // Properties
 
  bool _status = false;
  Room _room;
  
  
  //Getters & SETTERS
 
  
  get status{

    return _status;
  }
  set status(bool valor){
    this._status= valor;
    notifyListeners();


  }
   get room{

    return _room;
  }
  set room(Room valor){
    this._room= valor;
    notifyListeners();


  }


}
