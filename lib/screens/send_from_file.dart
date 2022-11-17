import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:flutter/material.dart';
import '../State/send_from_file_provider.dart';

class SendFromFile extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _messageFieldController = TextEditingController();
  late FocusNode myFocusNode;
  late FilePickerResult result;
  String sheetsDropdownValue = '';

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
                style: cons.kStyleBodyDark,
                minLines: 3,
                maxLines: 3,
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
              Row(
                children: [
                  Text(
                    "اختر عمود",
                    style: cons.kStyleBody,
                  ),
                  const SizedBox(
                    width: cons.elementsGap,
                  ),
                  DropdownButton<String>(
                    style: cons.kStyleBodyDark,
                    icon: const Icon(
                      Icons.view_column_outlined,
                      color: cons.kLightGreen,
                    ),
                    value: provider.selectedColumn,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(cons.borderRadius)),
                    onChanged: (String? newValue) {
                      provider.selectColumn(newValue.toString());
                    },
                    items: provider.columnsList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value, /////////
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Spacer(),
                  Text(
                    "اختر حقل متغير",
                    style: cons.kStyleBody,
                  ),
                  const SizedBox(
                    width: cons.elementsGap,
                  ),
                  DropdownButton<String>(
                    style: cons.kStyleBodyDark,
                    icon: const Icon(
                      Icons.text_fields_rounded,
                      color: cons.kLightGreen,
                    ),
                    value: provider.selectedParameter,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(cons.borderRadius)),
                    onChanged: (String? newValue) {
                      provider.selectParameter(newValue.toString());
                      // add parameter to text field
                      _messageFieldController.value =
                          _messageFieldController.value.copyWith(
                        text: _messageFieldController.text.replaceRange(
                            _messageFieldController.selection.base.offset,
                            _messageFieldController.selection.base.offset,
                            '{${newValue.toString()}}'),
                        selection: TextSelection.collapsed(
                            offset:
                                _messageFieldController.selection.base.offset),
                      );

                      print(
                          "current cursos is ${_messageFieldController.selection.base.offset} ");
                    },
                    items: provider.columnsList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value, /////////
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: cons.elementsGap,
              ),
              TextFormField(
                style: cons.kStyleBodyDark,
                minLines: 3,
                maxLines: 3,
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
                      borderRadius: const BorderRadius.all(
                          Radius.circular(cons.borderRadius)),
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
              const SizedBox(
                height: cons.elementsGap,
              ),
              SizedBox(
                width: 200.0,
                child: TextFormField(
                  style: cons.kStyleBodyDark,
                  controller: provider.intervalFieldController,
                  onChanged: (value) {
                    provider.updateINtervalFieldValue(value);
                  },
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
                    await provider.validateSending(
                        _messageFieldController.text, context);
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
