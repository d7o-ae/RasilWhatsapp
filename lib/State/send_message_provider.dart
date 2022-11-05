import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:rasil_whatsapp/screens/send_message.dart';
import 'package:rasil_whatsapp/widgets/confirm_dialog.dart';
import 'package:rasil_whatsapp/windowsAPI/keyboard_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class SendMessageProvider extends ChangeNotifier {
  // #### PROPERTIES ####
  Uri _whatsAppurl = Uri.parse('https://api.whatsapp.com/send/?phone=');
  int correctN = 0, errorN = 0, mobileLength = 12, listCount = 0;
  List numbersList = [];
  int currentIndex = 0;
  Timer mytimer = Timer.periodic(Duration(seconds: 10), (timer) {});

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
        'اجمالي الارقام: $listCount \nعدد الأرقام الصحيحة: $correctN \nعدد الأرقام الغير صحيحة: $errorN';

    //show dialog and wait for response
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => CustomDialog().showAlertDialog(
            context, message, "تأكيد الإرسال")).then((response) {
      //  if confirmed clicked
      if (response) {
        // show bottom bar with sending message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'جاري الإرسال ...',
            style: cons.kStyleBody,
          ),
        ));

        // wait for 2 sec.

        // for loop for sending all message
        for (int i = 0; i < listCount; i++) {
          // test
          print(
              "at ${DateTime.now()}, the index is $i and the listCount is always $listCount , the number will be sent is ${numbersList[i]} with message $msg ");

          // send
          send(context, msg, numbersList[i]);
          // wait 5 sec
          sleep(const Duration(seconds: 4));
          KeyboardManager().sendKey(VirtualKey.VK_RETURN);
        }
      }
    });
  }

  Future<void> send(BuildContext context, String msg, String num) async {
    String url = '$_whatsAppurl$num&text=$msg';
    print(url);

    if (!await launchUrl(Uri.parse(url))) {
      throw 'لا يمكن الإرسال لـ $_whatsAppurl';
    }
  }
}
