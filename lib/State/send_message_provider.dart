import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/widgets/confirm_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class SendMessageProvider extends ChangeNotifier {
  // #### PROPERTIES ####
  Uri _whatsAppurl = Uri.parse('https://wa.me/');
  int correctN = 0, errorN = 0, mobileLength = 12, listCount = 0;
  List numbersList = [];

  // #### METHODS ####
  Future<void> sendMessage(String num, String msg, BuildContext context) async {
    // process the numbers
    numbersList = num.split(',');

    // calculating correct and wrong numbers and count of numbers
    listCount = numbersList.length;
    for (String element in numbersList) {
      if (element.length != mobileLength) {
        errorN++;
      } else
        correctN++;
    }

    // show confirm message before sending
    String message =
        "عدد الأرقام الصحيحة: $correctN \nعدد الأرقام الغير صحيحة: $errorN";

    //show dialog and wait for response
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => CustomDialog().showAlertDialog(
            context, message, "تأكيد الإرسال")).then((response) {
      //  if confirmed clicked
      if (response) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('جاري الإرسال ...')));

        // send message
        for (String element in numbersList) {
          send(msg, element);
        }
      }
    });
  }

  Future<void> send(String msg, String num) async {
    String url = '$_whatsAppurl$num?text=$msg';
    _whatsAppurl = Uri.parse(url);

    if (!await launchUrl(_whatsAppurl)) {
      throw 'Could not launch $_whatsAppurl';
    }
  }
}
