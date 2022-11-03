import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;

class CustomDialog {
  AlertDialog showAlertDialog(
      BuildContext context, String message, String title) {
    return AlertDialog(
      title: Text(
        title,
        style: cons.kStyleTitle,
      ),
      content: Text(
        message,
        style: cons.kStyleBody,
      ),
      actions: [
        TextButton.icon(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: Icon(
            Icons.thumb_up,
            color: cons.kDarkGreen,
          ),
          label: Text(
            'تأكيد',
            style: cons.kStyleSecondary,
          ),
        ),
        TextButton.icon(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          icon: Icon(
            Icons.cancel_outlined,
            color: cons.kDarkGreen,
          ),
          label: Text(
            'إلغاء',
            style: cons.kStyleSecondary,
          ),
        )
      ],
    );
  }
}
