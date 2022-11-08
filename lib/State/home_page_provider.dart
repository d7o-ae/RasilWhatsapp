import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/screens/send_from_file.dart';
import 'package:rasil_whatsapp/screens/send_message.dart';

class HomePageProvider extends ChangeNotifier {
// #### PROPERTIES ####
  String _currentSelectedScreen = '';
  String time = "";

// #### METHODS ####
  Widget getPageContent(String screenName) {
    notifyListeners();
    switch (screenName) {
      case "1st":
        print("1st screen clicked");
        return SendMessageScreen();
        break;
      case "2nd":
        print("2nd screen clicked");
        return SendFromFile();
        break;

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
