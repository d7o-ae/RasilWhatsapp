import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rasil_whatsapp/State/settings_provider.dart';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsProvider>(
        create: (context) => SettingsProvider(),
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
    return Form(
        key: _formKey,
        child: Consumer<SettingsProvider>(
          builder: ((context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 400.0,
                  child: TextFormField(
                    controller: provider.licenceFieldController,
                    onChanged: (value) {
                      provider.updateLicenceFieldValue(value);
                    },
                    decoration: InputDecoration(
                        labelText: "كود الترخيص للبرنامج",
                        hintText: "الكود",
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
                        return 'فضلاً أدخل كود ترخيص';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: cons.elementsGap,
                ),
                SizedBox(
                  width: 400.0,
                  child: TextFormField(
                      controller: provider.intervalFieldController,
                      onChanged: (value) {
                        provider.updateIntervalsFieldValue(value);
                      },
                      decoration: InputDecoration(
                          labelText: "المدة الافتراضية للانتظار بالثواني ",
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
                      }),
                ),
                const SizedBox(
                  height: cons.elementsGap,
                ),
                const SizedBox(
                  height: cons.elementsGap,
                ),
                Row(
                  children: [
                    Text(
                      "تحميل ملف نموذج إكسل لخاصية الإرسال من ملف",
                      style: cons.kStyleBody,
                    ),
                    IconButton(
                      onPressed: () async {
                        {
                          if (!await launchUrl(
                              Uri.parse(cons.whatsappExcelTemplate))) {
                            throw 'Not opening ';
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cons.kWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                      icon: const Icon(
                        Icons.download,
                        color: cons.kDarkGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: cons.elementsGap,
                ),
                Row(
                  children: [
                    Text(
                      "طريقة إستخدام البرنامج",
                      style: cons.kStyleBody,
                    ),
                    IconButton(
                      onPressed: () async {
                        {
                          if (!await launchUrl(
                              Uri.parse(cons.rasilWhatsappYoutubeTutorial))) {
                            throw 'Not opening ';
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cons.kWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                      icon: const Icon(
                        Icons.video_collection_rounded,
                        color: cons.kDarkGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: cons.elementsGap),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      provider.saveSettings(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cons.kDarkGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  child: Text('حفظ الإعدادات ', style: cons.kStyleTitle),
                ),
              ],
            );
          }),
        ));
  }
}
