import 'dart:ffi';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rasil_whatsapp/State/send_message_provider.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:flutter/material.dart';
import 'package:win32/win32.dart';

import '../State/send_from_file_provider.dart';

class SendFromFile extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _messageFieldController = TextEditingController();
  final _intervalFieldController = TextEditingController();
  late FocusNode myFocusNode;
  late FilePickerResult result;
  String sheetsDropdownValue = '', columnsDropdownValue = '';

  @override
  Widget build(BuildContext context) {
    myFocusNode = FocusNode();
    return ChangeNotifierProvider<SendMessageFromFileProvider>(
        create: (context) => SendMessageFromFileProvider(),
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

  buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Consumer<SendMessageFromFileProvider>(
        builder: ((context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  MaterialButton(
                    onPressed: provider.pickFile,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(cons.borderRadius),
                    ),
                    color: cons.kDarkGreen,
                    child: Text(
                      'اختر ملف',
                      style: cons.kStyleTitle,
                    ),
                  ),
                  const SizedBox(
                    width: cons.elementsGap,
                  ),
                  DropdownButton<String>(
                    icon: const Icon(
                      Icons.table_chart_outlined,
                      color: cons.kLightGreen,
                    ),
                    value: sheetsDropdownValue,
                    // ignore: prefer_const_constructors
                    borderRadius: BorderRadius.all(
                        const Radius.circular(cons.borderRadius)),
                    onChanged: (newValue) {
                      // call select method from provider
                      provider.selectSheet(newValue.toString());
                      // update current value of dropdown
                      sheetsDropdownValue = provider
                          .selectedSheet; // this causes the error of "Another exception was thrown: There should be exactly one item with [DropdownButton]'s value"
                      // read columns of current selected sheet
                      provider.readColumns(sheetsDropdownValue);
                    },
                    items: provider.sheetsList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value, ////////////
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    width: cons.elementsGap,
                  ),
                  Text(
                    provider.getFilePathMessage,
                    style: cons.kStyleBody,
                  )
                ],
              ),
              const SizedBox(
                height: cons.elementsGap,
              ),
              TextFormField(
                minLines: 3,
                maxLines: 10,
                controller: provider.numbersFieldController,
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
                onChanged: (newValue) {
                  provider.updateNumberFieldValue(newValue);
                },
              ),
              const SizedBox(
                height: cons.elementsGap,
              ),
              DropdownButton<String>(
                icon: const Icon(
                  Icons.view_column_outlined,
                  color: cons.kLightGreen,
                ),
                value: columnsDropdownValue,
                borderRadius:
                    const BorderRadius.all(Radius.circular(cons.borderRadius)),
                onChanged: (String? newValue) {
                  provider.selectColumn(newValue.toString());
                  columnsDropdownValue = provider.selectedColumn;
                  // read numbers of the selected column
                  provider.readNumbers();
                },
                items: provider.columnsList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value, /////////
                    child: Text(value),
                  );
                }).toList(),
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
                      provider.numbersFieldValue,
                      _messageFieldController.text,
                      int.parse(_intervalFieldController.text),
                      context,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: cons.kDarkGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(cons.borderRadius), // <-- Radius
                  ),
                ),
                child: Text('إرسال ', style: cons.kStyleTitle),
              ),
            ],
          );
        }),
      ),
    );
  }
}
