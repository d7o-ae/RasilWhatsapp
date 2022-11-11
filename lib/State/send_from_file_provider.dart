// ignore_for_file: avoid_print

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class SendMessageFromFileProvider extends ChangeNotifier {
  // #### PROPERTIES ####
  String _filePath = '';
  String _pathMessage = '';
  String _selectedSheet = '';
  String _selectedColumn = '';
  List<String> _sheetsList = [''];
  List<String> _columnsList = [''];
  List<String> _numbersList = [''];
  TextEditingController _numbersFieldController = TextEditingController();
  String numbersFieldValue = '';

// #### METHODS #####
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
    print("the number of clumns are: $columnsCount");

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

    // update fields of numbers in UI
    _numbersFieldController.text =
        numberList.toString().replaceAll('[', '').replaceAll(']', '');
    print(numberList);
  }

  void selectSheet(String newValue) {
    _selectedSheet = newValue;
    notifyListeners();
  }

  void selectColumn(String newValue) {
    _selectedColumn = newValue;
    notifyListeners();
  }

  void updateNumberFieldValue(String newValue) {
    numbersFieldValue = newValue;
    notifyListeners();
  }

// #### SETTERS AND GETTERS ####
  set setFilePath(String path) {
    _filePath = path;
  }

  get getFilePathMessage {
    return _pathMessage;
  }

  String get selectedSheet => _selectedSheet;
  String get selectedColumn => _selectedColumn;
  List<String> get sheetsList => _sheetsList;
  List<String> get columnsList => _columnsList;
  List<String> get numberList => _numbersList;
  TextEditingController get numbersFieldController => _numbersFieldController;
}
