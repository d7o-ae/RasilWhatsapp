import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;

class SideMenu {
// ############# METHODS #############
// Open specefic screen
  void openScreen(BuildContext context, int screenNumber) {
    switch (screenNumber) {
      case 1:
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return Text("");
        }));
        break;
      case 2:
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return Text("");
        }));
        break;
    }
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Icon(
            Icons.message,
            color: cons.kDarkGreen,
          ),
          title: Text(
            'إرسال رسالة',
            style: cons.kStyleSecondary,
          ),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(
            Icons.file_present_rounded,
            color: cons.kDarkGreen,
          ),
          title: Text(
            'إرسال رسالة من ملف (متغيرات)',
            style: cons.kStyleSecondary,
          ),
          onTap: () => openScreen(context, 5),
        ),
        ListTile(
          leading: Icon(
            Icons.file_copy_sharp,
            color: cons.kDarkGreen,
          ),
          title: Text(
            ' تقارير',
            style: cons.kStyleSecondary,
          ),
          onTap: () => {
            showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return AlertDialog(
                    title: const Text('تسجيل الخروج'),
                    content: const Text(
                        'أنت على وشك تسجيل الخروج من حسابك, جميع بياناتك محفوظة ويمكنك العودة لها فور تسجيل الدخول لحسابك مرة اخرى'),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {}, child: const Text('تسجيل خروج')),
                      TextButton(
                          onPressed: () {
                            // Close the dialog
                            Navigator.of(ctx).pop(false);
                          },
                          child: const Text('إلغاء'))
                    ],
                  );
                })
          },
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              color: cons.kDarkGreen,
            ),
            Icon(
              Icons.whatsapp_outlined,
              color: cons.kDarkGreen,
            ),
            Icon(
              Icons.settings,
              color: cons.kDarkGreen,
            )
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
