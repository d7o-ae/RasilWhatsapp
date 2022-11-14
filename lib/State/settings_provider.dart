import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:rasil_whatsapp/shared%20preferences/shared_preferences.dart';
import 'package:rasil_whatsapp/widgets/confirm_dialog.dart';
import 'package:rasil_whatsapp/windowsAPI/keyboard_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import 'package:window_manager/window_manager.dart';

class SettingsProvider extends ChangeNotifier {
  void saveSettings(String intervals) {
// update settings values
    SharedPrefs().addStringToSF(cons.intervalTimeKey, intervals);
  }
}
