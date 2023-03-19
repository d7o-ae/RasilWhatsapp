import 'package:provider/provider.dart';
import 'package:rasil_whatsapp/State/home_page_provider.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/widgets/app_bar.dart';
import 'package:rasil_whatsapp/widgets/side_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageProvider>(
        create: (context) => HomePageProvider(),
        builder: (context, child) {
          return Scaffold(
            appBar: TopAppBar().body(context),
            body: buildHomePageBody(context),
          );
        });
  }

  Widget buildHomePageBody(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: SideMenu().build(context),
        ),
        Expanded(
          flex: 4,
          child: Consumer<HomePageProvider>(
            builder: ((context, provider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  provider.getPageContent(provider.getScreenName),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: cons.elementsGap, left: cons.elementsGap),
                    child: Row(
                      children: [
                        Text(
                          "النسخة ${cons.appVersion}",
                          style: cons.kStyleBodyDark,
                        ),
                        Spacer(),
                        Image.asset(
                          "lib/assets/images/logo.png",
                          scale: 3,
                        ),
                        Text(
                          "tech-code.net",
                          style: cons.kStyleBodyDark,
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}
