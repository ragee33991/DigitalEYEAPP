import 'package:flutter/material.dart';

class CreateAccountWeightPageModel extends ChangeNotifier {
  //Map data;
  List<int> lstWeight;

  int unitSelected = 0;

  int weight;

  CreateAccountWeightPageModel() {
    lstWeight = List<int>.generate(100, (i) {
      return i + 1;
    });

    weight = lstWeight[0];
  }

  void updateData(String value) {
    //data['weight'] = value;
    //data['unit'] = value;
  }

  void updateUnit(int value) {
    unitSelected = value;
    notifyListeners();
  }

  void updateWeight(int value) {
    weight = lstWeight[value];
    notifyListeners();
  }
}
