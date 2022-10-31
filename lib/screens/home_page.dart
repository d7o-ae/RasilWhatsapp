import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/widgets/side_menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("برنامج راسل"),
      ),
      body: SideMenu().body(context),
    );
  }

  Widget buildHomePageBody(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
          ),
        )
      ],
    ));
  }
}
