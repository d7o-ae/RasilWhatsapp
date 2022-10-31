import 'package:flutter/cupertino.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/widgets/app_bar.dart';
import 'package:rasil_whatsapp/widgets/side_menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar().body(context),
      body: buildHomePageBody(context),
    );
  }

  Widget buildHomePageBody(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SideMenu().body(context),
          flex: 1,
        ),
        Expanded(
          child: Container(
            color: cons.kDark,
          ),
          flex: 4,
        )
      ],
    );
  }
}
