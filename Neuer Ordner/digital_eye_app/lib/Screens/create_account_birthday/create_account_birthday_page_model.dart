import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';

class CreateAccountBirthdayPageModel extends ChangeNotifier {
  //Map data;
  List<int> lstYear;
  List<int> lstDay;

  int yearSelected = 0;
  int monthSelected = 0;
  int daySelected = 0;

  CreateAccountBirthdayPageModel() {
    DateTime now = DateTime.now();
    lstYear = List<int>.generate(now.year - 1920, (i) {
      return i + 1920 + 1;
    });

    yearSelected = lstYear[0];

    lstDay = getDayMonth(year: now.year, month: 1);
    daySelected = lstDay[0];
  }

  void updateData(String value) {
   // data['birthday'] = value;




  }

  List<int> getDayMonth({int year, int month}) {
    final dateTime = DateUtil();
    final countDay = dateTime.daysInMonth(month, year);

    return List<int>.generate(countDay, (i) {
      return i + 1;
    });
  }

  void updateMonth(int value) {
    monthSelected = value;
    notifyListeners();
  }

  void updateYear(int value) {
    yearSelected = lstYear[value];
    notifyListeners();
  }

  void updateDay(int value) {
    daySelected = lstDay[value];
    notifyListeners();
  }
}
