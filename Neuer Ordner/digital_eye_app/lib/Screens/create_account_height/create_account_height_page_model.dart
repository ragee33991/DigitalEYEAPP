import 'package:flutter/material.dart';

class CreateAccountHeightPageModel extends ChangeNotifier {
  //Map data;
  List<int> lstHeight;

  int unitSelected = 0;

  int height;

  CreateAccountHeightPageModel() {
    lstHeight = List<int>.generate(100, (i) {
      return i + 100;
    });

    height = lstHeight[0];
  }

  void updateData(String value) {
    //data['height'] = value;
    //data['unit'] = value;
  }

  void updateUnit(int value) {
    unitSelected = value;
    notifyListeners();
  }

  void updateWeight(int value) {
    height = lstHeight[value];
    notifyListeners();
  }
}
