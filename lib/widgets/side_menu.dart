import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasil_whatsapp/State/home_page_provider.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:url_launcher/url_launcher.dart';

class SideMenu extends StatelessWidget {
// ############# METHODS #############
// Open specefic screen

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(cons.elementsGap),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border(),
              color: cons.kWhite,
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: <BoxShadow>[
                // shadow color and radius
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 0.40))
              ],
            ),
            child: Column(
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
                    'إرسال من ملف',
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
                    IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () => openURL(cons.techcodeWhatsappURL),
                      color: cons.kDarkGreen,
                    ),
                    IconButton(
                      icon: Icon(Icons.whatsapp_outlined),
                      onPressed: () => openURL(cons.whatsappWebURL),
                      color: cons.kDarkGreen,
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: (() => {}),
                      color: cons.kDarkGreen,
                    )
                  ],
                ),
                const SizedBox(
                  height: cons.elementsGap,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> openURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Not opening $url';
    }
  }
}
