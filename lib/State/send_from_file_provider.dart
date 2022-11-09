import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class SendMessageFromFileProvider extends ChangeNotifier {
  // #### PROPERTIES ####
  String _filePath = '';
  String _pathMessage = '';
  List<String> _sheetsList = [''];
  String _selectedSheet = '';

// #### METHODS #####
  void pickFile() async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

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
    var bytes = File(_filePath).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      _sheetsList.add(table); //add sheets list from file to the dropdown list
      print('Tahble Name : $table'); //sheet Name
      print('number of columns ${excel.tables[table]?.maxCols}');
      print(' number of rows ${excel.tables[table]?.maxRows}');
      for (var row in excel.tables[table]!.rows) {
        print("$row");
      }
    }
    print(_sheetsList);
  }

  void selectSheet(String newValue) {
    _selectedSheet = newValue;
    notifyListeners();
  }

// #### SETTERS AND GETTERS ####
  set setFilePath(String path) {
    _filePath = path;
  }

  get getFilePathMessage {
    notifyListeners();
    return _pathMessage;
  }

  String get selected => _selectedSheet;
  List<String> get sheetsList => _sheetsList;
}
