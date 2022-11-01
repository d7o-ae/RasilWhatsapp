import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasil_whatsapp/State/home_page_provider.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;

class SideMenu extends StatelessWidget {
// ############# METHODS #############
// Open specefic screen

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, provider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.message,
                color: cons.kDarkGreen,
              ),
              title: Text(
                'إرسال رسالة',
                style: cons.kStyleSecondary,
              ),
              onTap: () => {provider.set("1st")},
            ),
            ListTile(
              leading: const Icon(
                Icons.file_present_rounded,
                color: cons.kDarkGreen,
              ),
              title: Text(
                'إرسال رسالة من ملف (متغيرات)',
                style: cons.kStyleSecondary,
              ),
              onTap: () => {provider.set("2nd")},
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
                              onPressed: () {},
                              child: const Text('تسجيل خروج')),
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
            const Spacer(),
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
            const SizedBox(
              height: 20,
            )
          ],
        );
      },
    );
  }
}
