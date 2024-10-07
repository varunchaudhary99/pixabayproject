import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showTost( message){
Fluttertoast.showToast(
msg: '${message}',backgroundColor: Colors.red,
toastLength: Toast.LENGTH_SHORT,
gravity: ToastGravity.CENTER,
textColor: Colors.white,
    fontSize: 16.0);
}