import 'package:provider/provider.dart';
import 'package:rasil_whatsapp/State/home_page_provider.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/widgets/app_bar.dart';
import 'package:rasil_whatsapp/widgets/side_menu.dart';

class HomePage extends StatelessWidget {
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
          child: Container(
            child: Consumer<HomePageProvider>(
              builder: ((context, provider, child) {
                String name = provider.getScreenName;
                return Column(
                  children: [
                    provider.getPageContent(name),
                  ],
                );
              }),
            ),
          ),
        )
      ],
    );
  }
}
