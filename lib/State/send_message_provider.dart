import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/screens/send_message.dart';
import 'package:rasil_whatsapp/widgets/confirm_dialog.dart';
import 'package:rasil_whatsapp/windowsAPI/keyboard_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class SendMessageProvider extends ChangeNotifier {
  // #### PROPERTIES ####
  Uri _whatsAppurl = Uri.parse('https://wa.me/');
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
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('جاري الإرسال ...')));

        // send message
        mytimer = Timer.periodic(
          Duration(seconds: 10),
          (timer) {
            print("$currentIndex");
            print("message is $msg");
            try {
              send(context, msg, numbersList[currentIndex],
                  listCount); //error if increased.
            } catch (e) {
              send(context, msg, "", listCount);
            }
          },
        );
      }
    });
  }

  Future<void> send(
      BuildContext context, String msg, String num, int maxCount) async {
    // check if numbers list finished

    if ((currentIndex < maxCount) && (num.isNotEmpty)) {
      String url = '$_whatsAppurl$num?text=$msg';

      if (!await launchUrl(Uri.parse(url))) {
        throw 'لا يمكن الإرسال لـ $_whatsAppurl';
      }

      // send Ente key stroke
      KeyboardManager().sendKey(VirtualKey.VK_RETURN);
      KeyboardManager().sendKey(VirtualKey.VK_RETURN);
      KeyboardManager().sendKey(VirtualKey.VK_RETURN);
      KeyboardManager().sendKey(VirtualKey.VK_RETURN);
      // increase current Index
      currentIndex++;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم الانتهاء من الارسال')));
      print("finished f sending");
      mytimer.cancel();
    }
  }
}
