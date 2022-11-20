// ignore_for_file: avoid_print
import 'package:provider/provider.dart';
import 'package:rasil_whatsapp/State/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:lottie/lottie.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavouriteProvider>(
        create: (context) => FavouriteProvider(),
        builder: (context, child) {
          return buildScreen(context);
        });
  }

  Widget buildScreen(BuildContext context) {
    return Consumer<FavouriteProvider>(builder: ((context, provider, child) {
      return Expanded(
        child: FutureBuilder<List<String>>(
            future: provider.read(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Lottie.network(
                      "https://assets3.lottiefiles.com/packages/lf20_MDZxRPY65m.json",
                      repeat: true,
                      height: cons.elementsGap * 200),
                );
              } else if (!snapshot.hasData) {
                return Center(
                    child: Lottie.network(
                        "https://assets8.lottiefiles.com/packages/lf20_JkzqCb.json"));
              } else if (snapshot.hasData) {
                if (snapshot.data!.length == 0) {
                  return Center(
                    child: Lottie.network(
                        "https://assets8.lottiefiles.com/packages/lf20_t7uqr8of.json"),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return buildFavMessageTile(
                        snapshot.data!, index, context, provider);
                  },
                  itemCount: snapshot.data!.length,
                );
              } else {
                return Text("dddd");
              }
            }),
      );
    }));
  }

  SizedBox buildFavMessageTile(List<String> list, int index,
      BuildContext context, FavouriteProvider provider) {
    return SizedBox(
      child: ListTile(
        leading: IconButton(
            onPressed: () {
              provider.delete(context, index);
            },
            icon: const Icon(
              Icons.delete_forever_rounded,
              color: cons.kRed,
            )),
        title: Text(
          list[index],
          style: cons.kStyleBody,
        ),
      ),
    );
  }
}
