import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;

class SdeMenu extends StatelessWidget {
// ############# METHODS #############
// Open specefic screen
  void openScreen(BuildContext context, int screenNumber) {
    switch (screenNumber) {
      case 1:
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) {}));
        break;
      case 2:
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) {}));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {}));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {}));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Text(''),
                Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 4,
                      ),
                    )),
              ],
            ),
            decoration: BoxDecoration(),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
            
            ),
            title: Text(
              'الرئيسية',
            ),
            onTap: () => openScreen(context, 1),
          ),
          ListTile(
            leading: Icon(
              Icons.pie_chart_sharp,
            ),
            title: Text(
              'الرسم البياني',
            ),
            onTap: () => openScreen(context, 3),
          ),
          ListTile(
            leading: Icon(
              Icons.category_outlined,
              color: cons.kDarkGreen,
            ),
            title: Text(
              'التصنيفات',
              style: cons.kStyleSecondary,
            ),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ),
              )
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: cons.kDarkGreen,
            ),
            title: Text(
              'حول التطبيق',
              style: cons.kStyleSecondary,
            ),
            onTap: () => openScreen(context, 5),
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: cons.kDarkGreen,
            ),
            title: Text(
              'تسجيل الخروج',
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
                            onPressed: () {    },
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
        ],
      ),
    );
  }
}
