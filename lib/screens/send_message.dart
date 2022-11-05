import 'package:flutter/services.dart';
import 'package:rasil_whatsapp/State/send_message_provider.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:flutter/material.dart';

class SendMessageScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _numberFieldController = TextEditingController();
  final _messageFieldController = TextEditingController();
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
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: cons.kDarkGreen,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: cons.kLightGreen,
                    width: 2.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.0,
                  ),
                ),
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
          SizedBox(
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
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: cons.kDarkGreen,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: cons.kLightGreen,
                    width: 2.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.0,
                  ),
                ),
                errorStyle: cons.kStyleError),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'أدخل نص الرسالة بشكل صحيح';
              }
              return null;
            },
          ),
          SizedBox(
            height: cons.elementsGap,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await SendMessageProvider().sendMessage(
                    _numberFieldController.text,
                    _messageFieldController.text,
                    context);
              }
              // clear fields
              _messageFieldController.clear();
              _numberFieldController.clear();
              // request focus to numbers field
              myFocusNode.requestFocus();
              // show message
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'تم الانتهاء من الارسال',
                  style: cons.kStyleBody,
                ),
              ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: cons.kDarkGreen,
            ),
            child: Text('إرسال ', style: cons.kStyleTitle),
          ),
        ],
      ),
    );
  }
}
