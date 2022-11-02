import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SendMessageProvider extends ChangeNotifier {
  Uri _url = Uri.parse('https://wa.me/');

  Future<void> sendMessage(String num, String msg) async {
    var url = _url.toString() + num + '?text=' + msg;
    _url = Uri.parse(url);
    print(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
