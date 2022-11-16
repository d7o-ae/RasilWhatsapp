// ignore_for_file: avoid_print
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:rasil_whatsapp/constants/constants.dart' as cons;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';
import '../widgets/confirm_dialog.dart';
import '../windowsAPI/keyboard_manager.dart';

class SendMessageFromFileProvider extends ChangeNotifier {
// #### CONSTRUCTOR ####

  SendMessageFromFileProvider() {
    read();
  }

  // #### PROPERTIES ####
  List<String> _favList = [];
  int favListCount = 0;
  String _selectedFavMessage = "";
  String _filePath = '';
  String _pathMessage = '';
  String _selectedSheet = '';
  String _selectedColumn = '';
  String _intervalsFieldValue = "";
  List<String> _sheetsList = [''];
  List<String> _columnsList = [''];
  List<String> _numbersList = [''];
  final TextEditingController _numbersFieldController = TextEditingController(),
      _intervalFieldController = TextEditingController();
  String _numbersFieldValue = '';
  int correctN = 0, errorN = 0, listCount = 0;
  double estimatedTime =
      0; // the stimated time in the message shown in the dialog ( prefered interval * numbers count)
  String estimatedUnit =
      ''; // the unit shown after the estimated time in the message shown in the dialog

// #### METHODS #####

  read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    updateINtervalFieldValue(prefs.getString(cons.intervalTimeKey)!);
    _intervalFieldController.text = intervalsFieldValue;

    // favourie message
    _favList = prefs.getStringList(cons.favMessagesLey)!;
  }

  addToFav(String msg, BuildContext context) async {
    if (msg == "" || msg == null) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favList = prefs.getStringList(cons.favMessagesLey)!;
    favListCount = favList.length;

    favList.add(msg);
    // update preferences list
    prefs.setStringList(cons.favMessagesLey, favList);

    // show message
    // show bottom bar with sending message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'تم الإضافة',
        style: cons.kStyleBody,
      ),
      duration: const Duration(seconds: 2),
    ));
  }

  void pickFile() async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['xlsx'],
      dialogTitle: 'اختر ملف إكسل بإمتداد .xlsx',
      type: FileType.custom,
      allowCompression: false,
      withData: true,
      lockParentWindow: true,
    );

    // if no file is picked
    if (result == null) return;

    // we will log the name, size and path of the
    // first picked file (if multiple are selected)

    _filePath = result.files.first.path!;

    _pathMessage = 'مسار الملف: $_filePath (${result.files.first.size} بايت)';
    readFile();
    notifyListeners();
  }

  void readFile() {
    // initiate
    var bytes = File(_filePath).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    // clear content of sheets list (if any)
    _sheetsList = [''];
    // read and iterate sheets
    for (var table in excel.tables.keys) {
      // read and store sheets names - add sheets list from file to the dropdown list
      _sheetsList.add(table);
      print('Tahble Name : $table'); //sheet Name
      print('number of columns ${excel.tables[table]?.maxCols}');
      print(' number of rows ${excel.tables[table]?.maxRows}');
      for (var row in excel.tables[table]!.rows) {
        print("$row");
      }
    }

    print(_sheetsList);
  }

  void readColumns(String sheetFileName) {
    // initiate
    var bytes = File(_filePath).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    //clean current list of columns (if any)
    _columnsList = [''];
    // number of coulmns in the selected sheet
    int columnsCount = excel[sheetFileName].maxCols;

    // get columns names (values of first row)
    for (int i = 0; i < columnsCount; i++) {
      _columnsList.add(excel[sheetFileName]
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .value);
    }
  }

  void readNumbers() {
    // initiate
    var bytes = File(_filePath).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    // calculate number of rows and cols
    int rowsLength = excel[selectedSheet].maxRows;

    // get column index
    int colIndex = columnsList.indexOf(selectedColumn) - 1;

    // clear current values of numbers list
    _numbersList = [];
    // iterate over the rows on the selected Index to get the numbers and added to _numbersList
    for (int i = 1; i < rowsLength; i++) {
      String number = excel[selectedSheet]
          .cell(CellIndex.indexByColumnRow(columnIndex: colIndex, rowIndex: i))
          .value
          .toString();
      _numbersList.add(number);
    }

    // update fields of numbers
    _numbersFieldValue = numbersList
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(' ', '');

    _numbersFieldController.value = _numbersFieldController.value.copyWith(
      text: numbersFieldValue,
      selection: TextSelection.collapsed(offset: numbersFieldValue.length),
    );
  }

  void selectSheet(String newValue) {
    _selectedSheet = newValue;
    notifyListeners();
  }

  void selectColumn(String newValue) {
    // update current value of selected column
    _selectedColumn = newValue;
    // read numbers of the selected column
    readNumbers();
    //notify to update
    notifyListeners();
  }

  void updateNumberFieldValue(String newValue) {
    _numbersFieldValue = newValue;
  }

  void selectFavMessage(String newValue) {
    // update current value of selected column
    _selectedFavMessage = newValue;

    //notify to update
    notifyListeners();
  }

  Future<void> validateSending(String msg, BuildContext context) async {
    // empty counts
    errorN = 0;
    correctN = 0;
    // process the numbers
    _numbersList = numbersFieldValue.split(',');

    // calculating correct and wrong numbers and count of numbers
    listCount = numbersList.length;
    for (String element in numbersList) {
      if (element.length != cons.saudiMobileLength) {
        errorN++;
      } else {
        correctN++;
      }
    }

    // process the estimated time
    if (int.parse(intervalsFieldValue) * listCount > 60) {
      estimatedTime =
          ((int.parse(intervalsFieldValue) * listCount).toDouble() / 60.0);
      estimatedUnit = "دقيقة ";
    } else {
      estimatedTime = (int.parse(intervalsFieldValue) * listCount).toDouble();
      estimatedUnit = "ثانية ";
    }

    // show confirm message before sending
    String message =
        'اجمالي الارقام: $listCount \nعدد الأرقام الصحيحة: $correctN \nعدد الأرقام الغير صحيحة: $errorN \nالوقت المستغرق المتوقع: $estimatedTime $estimatedUnit';

    //show dialog and wait for response
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => CustomDialog().showAlertDialog(
            context, message, "تأكيد الإرسال")).then((response) {
      //  if confirmed clicked
      if (response) {
        // show bottom bar with sending message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'جاري الإرسال ...',
            style: cons.kStyleBody,
          ),
          duration: const Duration(seconds: 2),
        ));

        // send message by using for loop
        for (int i = 0; i < listCount; i++) {
          //  open Whatsapp conversation
          send(msg, numbersList[i]);
          // wait 5 sec
          sleep(Duration(seconds: int.parse(intervalsFieldValue)));
          // type message
          KeyboardManager().sendInputString(msg);
          // wait for 5 message
          sleep(Duration(seconds: int.parse(intervalsFieldValue)));
          // hit enter
          KeyboardManager().sendKey(VirtualKey.VK_RETURN);
        }

        // after finish of sending - show message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'تم الانتهاء من الارسال',
            style: cons.kStyleBody,
          ),
          duration: const Duration(seconds: 3),
        ));

        // get focus to window again
        WindowManager.instance.focus();
      }
    });
  }

  Future<void> send(String msg, String num) async {
    //Uri url = Uri.parse('https://wa.me/$num/?text=$msg&type=phone_number&app_absent=0');
    Uri url = Uri.parse('https://wa.me/$num');

    if (!await launchUrl(url, webOnlyWindowName: '_blank')) {
      throw 'لا يمكن الإرسال لـ ';
    }
  }

// #### SETTERS AND GETTERS ####
  set setFilePath(String path) {
    _filePath = path;
  }

  get getFilePathMessage {
    return _pathMessage;
  }

  void updateINtervalFieldValue(String newValue) {
    _intervalsFieldValue = newValue;
  }

  get selectedFaveMessage => _selectedFavMessage;
  String get selectedSheet => _selectedSheet;
  String get selectedColumn => _selectedColumn;
  String get numbersFieldValue => _numbersFieldValue;
  String get intervalsFieldValue => _intervalsFieldValue;
  List<String> get sheetsList => _sheetsList;
  List<String> get columnsList => _columnsList;
  List<String> get numbersList => _numbersList;
  TextEditingController get numbersFieldController => _numbersFieldController;
  TextEditingController get intervalFieldController => _intervalFieldController;
  get favList => _favList;
}
