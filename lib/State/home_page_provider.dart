import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/screens/send_from_file.dart';
import 'package:rasil_whatsapp/screens/send_message.dart';
import 'package:rasil_whatsapp/screens/settings_file.dart';

class HomePageProvider extends ChangeNotifier {
// #### PROPERTIES ####
  String _currentSelectedScreen = '';
  String time = "";

// #### METHODS ####
  Widget getPageContent(String screenName) {
    notifyListeners();
    switch (screenName) {
      case "1st":
        return SendMessageScreen();
      case "2nd":
        return SendFromFile();
      case "3rd":
        return SettingsScreen();

      default:
        return SendMessageScreen();
    }
  }

// #### GETTERS AND SETTERS
  set(String name) {
    _currentSelectedScreen = name;
    notifyListeners();
  }

  get getScreenName => _currentSelectedScreen;
}
