import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:rasil_whatsapp/widgets/confirm_dialog.dart';
import 'package:rasil_whatsapp/windowsAPI/keyboard_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import 'package:window_manager/window_manager.dart';

class SendMessageProvider extends ChangeNotifier {
  // #### PROPERTIES ####
  int correctN = 0, errorN = 0, mobileLength = 12, listCount = 0;
  List numbersList = [];

  // #### METHODS ####
  Future<void> sendMessage(
      String num, String msg, int intervals, BuildContext context) async {
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

    // process the interval
    if (intervals < 5 || intervals > 30 || intervals == null) {
      intervals = 5;
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
          duration: const Duration(seconds: 2),
        ));

        // send message by using for loop
        for (int i = 0; i < listCount; i++) {
          //  open Whatsapp conversation
          send(msg, numbersList[i]);
          // wait 5 sec
          sleep(Duration(seconds: intervals));
          // type message
          KeyboardManager().sendInputString(msg);
          // wait for 5 message
          sleep(Duration(seconds: intervals));
          // hit enter
          KeyboardManager().sendKey(VirtualKey.VK_RETURN);
        }

        // after finish of sending - show message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'تم الانتهاء من الارسال',
            style: cons.kStyleBody,
          ),
          duration: const Duration(seconds: 3),
        ));

        // get focus to window again
        WindowManager.instance.focus();
      }
    });
  }

  Future<void> send(String msg, String num) async {
    //Uri url = Uri.parse('https://wa.me/$num/?text=$msg&type=phone_number&app_absent=0');
    Uri url = Uri.parse('https://wa.me/$num');

    if (!await launchUrl(url)) {
      throw 'لا يمكن الإرسال لـ ';
    }
  }
}
