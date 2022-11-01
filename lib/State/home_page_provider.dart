import 'package:flutter/cupertino.dart';

class HomePageProvider extends ChangeNotifier {
// #### PROPERTIES ####
  String _currentSelectedScreen = '';
// #### METHODS ####

  Widget getPageContent(String screenName) {
    notifyListeners();
    switch (screenName) {
      case "1st":
        print("1st screen clicked");
        return buildSendMessageScreen();
        break;
      case "2nd":
        print("2nd screen clicked");
        return buildSendWithParametersScreen();
        break;
      case "3rd":
        return buildThirdScreen();
        break;
      default:
        return buildSendMessageScreen();
    }
  }

// #### Widgets ####
  Widget buildSendMessageScreen() {
    return Text("Send message screen ");
  }

  Widget buildSendWithParametersScreen() {
    return Text("Send message with parameters screen ");
  }

  Widget buildThirdScreen() {
    return Text("Third screen ");
  }

// #### GETTERS AND SETTERS
  set(String name) {
    _currentSelectedScreen = name;
    notifyListeners();
  }

  get getScreenName => _currentSelectedScreen;
}
