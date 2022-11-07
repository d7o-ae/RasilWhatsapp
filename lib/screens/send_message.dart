import 'dart:ffi';
import 'package:flutter/services.dart';
import 'package:rasil_whatsapp/State/send_message_provider.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:flutter/material.dart';

class SendMessageScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _numberFieldController = TextEditingController();
  final _messageFieldController = TextEditingController();
  final _intervalFieldController = TextEditingController();
  late FocusNode myFocusNode;

  @override
  Widget build(BuildContext context) {
    myFocusNode = FocusNode();
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 30, left: 100, top: 40),
            child: buildForm(context))
      ],
    ));
  }

  Form buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            minLines: 3,
            maxLines: 10,
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
            maxLines: 10,
            controller: _messageFieldController,
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
          SizedBox(
            width: 200.0,
            child: TextFormField(
              controller: _intervalFieldController,
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
                    int.parse(value) > 30 ||
                    int.parse(value) < 5) {
                  return 'مسموح بين 5 و 30 ثانية';
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
                await SendMessageProvider().sendMessage(
                  _numberFieldController.text,
                  _messageFieldController.text,
                  int.parse(_intervalFieldController.text),
                  context,
                );
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
      ),
    );
  }
}
