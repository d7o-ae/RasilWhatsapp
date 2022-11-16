import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;

import '../widgets/confirm_dialog.dart';

class FavouriteProvider extends ChangeNotifier {
  List<String> list = [];
  int listCount = 0;

  Future<List<String>> read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    list = prefs.getStringList(cons.favMessagesLey)!;
    listCount = list.length;

    return list;
  }

  void delete(BuildContext context, int index) {
    showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => CustomDialog().showAlertDialog(
                context, "هل تريد حذف هذه الرسالة من المفضلة؟", "تأكيد الحذف"))
        .then((response) {
      if (response) {
        update(index);
      }
    });
  }

  update(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    list = prefs.getStringList(cons.favMessagesLey)!;
    listCount = list.length;
    //remove from list
    list.removeAt(index);
    // update (set) list on preferences again
    prefs.setStringList(cons.favMessagesLey, list);

    notifyListeners();
  }
}
