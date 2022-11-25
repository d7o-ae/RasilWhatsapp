// ignore_for_file: prefer_const_constructors

import 'dart:ffi';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rasil_whatsapp/State/send_message_provider.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:flutter/material.dart';

class SendMessageScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _numberFieldController = TextEditingController();
  final _messageFieldController = TextEditingController();

  late FocusNode myFocusNode;

  SendMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    myFocusNode = FocusNode();
    return ChangeNotifierProvider<SendMessageProvider>(
        create: (context) => SendMessageProvider(),
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 30, left: 100, top: 40),
                  child: buildForm(context))
            ],
          );
        });
  }

  Form buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Consumer<SendMessageProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                minLines: 3,
                maxLines: 3,
                style: cons.kStyleBodyDark,
                controller: _numberFieldController,
                focusNode: myFocusNode,
                decoration: InputDecoration(
                    labelText: "الأرقام",
                    hintText:
                        "أدخل الأرقام مفصولة بفاصلة (,) ومبدوءة بكود الدولة مثل :  (966558866521)",
                    labelStyle: cons.kStyleBody,
                    hintStyle: cons.kStyleBody,
                    fillColor: Colors.white,
                    focusedBorder: cons.kNormalOutlineInputBorder,
                    enabledBorder: cons.kNormalOutlineInputBorder,
                    errorBorder: cons.kErrorOutlineInputBorder,
                    focusedErrorBorder: cons.kErrorOutlineInputBorder,
                    errorStyle: cons.kStyleError),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'فضلأ ادخل رقم صحيح واحد على الأقل';
                  }
                  return null;
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                    (cons.mobileNumbersRE),
                  ),
                ],
              ),
              const SizedBox(
                height: cons.elementsGap,
              ),
              TextFormField(
                minLines: 3,
                maxLines: 3,
                controller: _messageFieldController,
                style: cons.kStyleBodyDark,
                decoration: InputDecoration(
                    labelText: "الرسالة",
                    hintText: "أدخل نص الرسالة التي تود إرسالها",
                    labelStyle: cons.kStyleBody,
                    hintStyle: cons.kStyleBody,
                    fillColor: Colors.white,
                    focusedBorder: cons.kNormalOutlineInputBorder,
                    enabledBorder: cons.kNormalOutlineInputBorder,
                    errorBorder: cons.kErrorOutlineInputBorder,
                    focusedErrorBorder: cons.kErrorOutlineInputBorder,
                    errorStyle: cons.kStyleError),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'أدخل نص الرسالة بشكل صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: cons.elementsGap,
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "اختر من المفضلة",
                      style: cons.kStyleBody,
                    ),
                    DropdownButton<String>(
                      style: cons.kStyleBodyDark,
                      icon: const Icon(
                        Icons.message,
                        color: cons.kLightGreen,
                      ),
                      borderRadius: BorderRadius.all(
                          const Radius.circular(cons.borderRadius)),
                      items: provider.favList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value, ////////////
                          child: (value.length > 50)
                              ? Text("${value.substring(0, 50)}....")
                              : Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        provider.selectFavMessage(value.toString());
                        _messageFieldController.text =
                            (provider.selectedFaveMessage);
                      },
                    ),
                    const Spacer(),
                    Text(
                      "إضافة الرسالة للمفضلة",
                      style: cons.kStyleBody,
                    ),
                    IconButton(
                        selectedIcon: const Icon(
                          Icons.favorite,
                          color: cons.kRed,
                        ),
                        onPressed: () {
                          provider.addToFav(
                              _messageFieldController.text, context);
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          color: cons.kRed,
                        ))
                  ]),
              const SizedBox(
                height: cons.elementsGap,
              ),
              SizedBox(
                width: 200.0,
                child: TextFormField(
                  style: cons.kStyleBodyDark,
                  controller: provider.intervalFieldController,
                  onChanged: (value) =>
                      provider.updateIntervalFieldValue(value),
                  decoration: InputDecoration(
                      labelText: "الانتظار ما بين الارسال",
                      hintText: "عدد الثواني",
                      labelStyle: cons.kStyleBody,
                      hintStyle: cons.kStyleBody,
                      fillColor: Colors.white,
                      focusedBorder: cons.kNormalOutlineInputBorder,
                      enabledBorder: cons.kNormalOutlineInputBorder,
                      errorBorder: cons.kErrorOutlineInputBorder,
                      focusedErrorBorder: cons.kErrorOutlineInputBorder,
                      errorStyle: cons.kStyleError),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      (cons.correctSecondIntervalsRE),
                    ),
                  ],
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.parse(value) > cons.maxAllowedInterval ||
                        int.parse(value) < cons.minAllowedInterval) {
                      return 'مسموح بين ${cons.minAllowedInterval} و ${cons.maxAllowedInterval}';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: cons.elementsGap,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await provider.sendMessage(_numberFieldController.text,
                        _messageFieldController.text, context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: cons.kDarkGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
                child: Text('إرسال ', style: cons.kStyleTitle),
              ),
            ],
          );
        },
      ),
    );
  }
}
