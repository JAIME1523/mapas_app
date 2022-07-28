import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void ShowLoadingMessage(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
          title: const Text('Espere por favor'),
          content: Container(
            margin: const EdgeInsets.only(top:30),
            height: 100,
            width: 100,
            child: Column(
              
              children: const [
                Text('Calculando ruta...'),
                SizedBox(height:15),
                CircularProgressIndicator(strokeWidth: 3, color: Colors.black),
              ],
            ),
          )),
    );
    return;
  }

  showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Espere por favor'),
          content: Column(
            children: const [
              Text('Calculando ruta...'),
              CupertinoActivityIndicator()
            ],
          )));
}
