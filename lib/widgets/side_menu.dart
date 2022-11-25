import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasil_whatsapp/State/home_page_provider.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:url_launcher/url_launcher.dart';

class SideMenu extends StatelessWidget {
// ######## PROPERTIES ########
  bool listTile1Selected = true,
      listTile2Selected = false,
      listTile3Selected = false,
      settingsSelected = false;

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
                  height: cons.elementsGap * 2,
                ),
                Material(
                  type: MaterialType.transparency,
                  child: ListTile(
                    selected: listTile1Selected,
                    selectedTileColor: cons.kDarkGreen,
                    hoverColor: cons.kLightGreen,
                    leading: Icon(
                      Icons.message,
                      color: listTile1Selected ? cons.kDark : cons.kDarkGreen,
                    ),
                    title: Text(
                      'إرسال رسالة',
                      style: cons.kStyleSecondary,
                    ),
                    onTap: () {
                      provider.set("1st");
                      listTile1Selected = true;
                      listTile2Selected = false;
                      listTile3Selected = false;
                      settingsSelected = false;
                    },
                  ),
                ),
                Material(
                  type: MaterialType.transparency,
                  child: ListTile(
                    selected: listTile2Selected,
                    selectedTileColor: cons.kDarkGreen,
                    hoverColor: cons.kLightGreen,
                    leading: Icon(
                      Icons.file_present_rounded,
                      color: listTile2Selected ? cons.kDark : cons.kDarkGreen,
                    ),
                    title: Text(
                      'إرسال من ملف',
                      style: cons.kStyleSecondary,
                    ),
                    onTap: () {
                      provider.set("2nd");
                      listTile1Selected = false;
                      listTile2Selected = true;
                      listTile3Selected = false;
                      settingsSelected = false;
                    },
                  ),
                ),
                Material(
                  type: MaterialType.transparency,
                  child: ListTile(
                    selected: listTile3Selected,
                    selectedTileColor: cons.kDarkGreen,
                    selectedColor: cons.kRed,
                    hoverColor: cons.kLightGreen,
                    leading: Icon(
                      Icons.favorite,
                      color: listTile3Selected ? cons.kDark : cons.kDarkGreen,
                    ),
                    title: Text(
                      ' المفضلة',
                      style: cons.kStyleSecondary,
                    ),
                    onTap: () {
                      provider.set("4th");
                      listTile1Selected = false;
                      listTile2Selected = false;
                      listTile3Selected = true;
                      settingsSelected = false;
                    },
                  ),
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
                      icon: Icon(Icons.whatsapp),
                      onPressed: () => openURL(cons.whatsappWebURL),
                      color: cons.kDarkGreen,
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        settingsSelected = true;
                        listTile1Selected = false;
                        listTile2Selected = false;
                        listTile3Selected = false;
                        provider.set("3rd");
                      },
                      color: settingsSelected ? cons.kDark : cons.kDarkGreen,
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
