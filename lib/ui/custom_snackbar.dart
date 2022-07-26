import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar(
      {Key? key,
      required String message,
      String btnLbel = 'OK',
      VoidCallback? onOk,
      Duration duration = const Duration(seconds: 2)})
      : super(
            key: key,
            content: Text(message),
            duration: duration,
            action: SnackBarAction(
                label: btnLbel,
                onPressed: () {
                  if (onOk != null) {
                    onOk();
                  }
                }));
}
