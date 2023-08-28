   import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterToast{

    errorController(e){
      Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.white,
          textColor: Colors.indigo,
          fontSize: 20,
          timeInSecForIosWeb: 3,
          toastLength: Toast.LENGTH_LONG);
    }

   }