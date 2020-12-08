import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';

class CreateAccountGenderPageModel extends ChangeNotifier {
  //Map data;
  int genderSelected = 0;

  CreateAccountGenderPageModel();

  void updateData(String value) {
    //data['gender'] = value;
  }

  void updateGender(int value) {
    genderSelected = value;
    notifyListeners();
  }
}
