import 'package:flutter/services.dart';
import 'package:rasil_whatsapp/State/send_message_provider.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:flutter/material.dart';

class SendMessageScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _numberFieldController = TextEditingController();
  final _messageFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
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
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SizedBox(
            height: cons.elementsGap,
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );

                SendMessageProvider().sendMessage(
                    _numberFieldController.text, _messageFieldController.text);
              }
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
