import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;

class TopAppBar {
  AppBar body(BuildContext context) {
    return AppBar(
      title: Text(
        'راسل واتساب',
        style: cons.kStyleTitle,
      ),
      backgroundColor: cons.kWhite,
    );
  }
}
