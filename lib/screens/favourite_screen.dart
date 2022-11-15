import 'package:provider/provider.dart';
import 'package:rasil_whatsapp/State/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;

class FavouriteScreen extends StatelessWidget {
  List<String>? list = [];
  int listCount = 1;

  FavouriteScreen({super.key}) {
    read();
  }

  void read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    list = prefs.getStringList(cons.favMessagesLey);
    listCount = list!.length;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavouriteProvider>(
        create: (context) => FavouriteProvider(),
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 30, left: 100, top: 40),
                  child: buildScreen(context)),
            ],
          );
        });
  }

  Widget buildScreen(BuildContext context) {
    return Consumer<FavouriteProvider>(
      builder: ((context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(cons.elementsGap),
          child: ListView.separated(
            padding: const EdgeInsets.all(cons.elementsGap),
            separatorBuilder: (BuildContext context, int i) {
              return const SizedBox(
                height: cons.elementsGap,
              );
            },
            itemBuilder: (context, index) {
              return buildFavMessafeTile(index);
            },
            itemCount: listCount,
          ),
        );
      }),
    );
  }

  Widget buildFavMessafeTile(int index) {
    return ListTile(
      leading: Text(list![index]),
    );
  }
}
