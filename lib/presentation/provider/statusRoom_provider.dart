import 'package:flutter/material.dart';

class StatusRoom with ChangeNotifier {
  
  // Properties
 
  bool _status ;
  
  
  //Getters & SETTERS
 
  
  get status{

    return _status;
  }
  set status(bool valor){
    this._status= valor;
    notifyListeners();


  }


}
