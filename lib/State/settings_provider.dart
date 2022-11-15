import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SettingsProvider extends ChangeNotifier {
  // #### CONSTRUCTOR ####
  SettingsProvider() {
    read(); //read preferences settings
  }

// #### PROPERTIES ####
  String _intervalsFieldValue = "", _licenceCodeValue = "";
  final _intervalFieldController = TextEditingController(),
      _licenceFieldController = TextEditingController();

// #### METHODS #####
  Future<void> read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    updateIntervalsFieldValue(prefs.getString(cons.intervalTimeKey)!);
    _intervalFieldController.text = intervalsFieldValue;

    updateLicenceFieldValue(prefs.getString(cons.licenceKey)!);
    _licenceFieldController.text = _licenceCodeValue;
  }

  Future<void> saveSettings(BuildContext context) async {
    // update settings values
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        cons.intervalTimeKey, intervalFieldController.text.toString());
    prefs.setString(cons.licenceKey, licenceCodeValue);

    // show message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'تم الحفظ',
        style: cons.kStyleBody,
      ),
      duration: const Duration(seconds: 2),
    ));
  }

// #### SETTERS AND GETTERS ####
  void updateIntervalsFieldValue(String newValue) {
    _intervalsFieldValue = newValue;
  }

  void updateLicenceFieldValue(String newValue) {
    _licenceCodeValue = newValue;
  }

  get intervalsFieldValue => _intervalsFieldValue;
  get intervalFieldController => _intervalFieldController;
  get licenceCodeValue => _licenceCodeValue;
  get licenceFieldController => _licenceFieldController;
}
