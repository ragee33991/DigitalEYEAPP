import 'package:flutter/material.dart';

class CreateAccountPageModel extends ChangeNotifier {
  String fullname = "";
  String birthday = "";
  String gender = "";
  String weight = "";
  String height = "";

  Map get data => {
        "fullname": fullname,
        "birthday": birthday,
        "gender": gender,
        "weight": weight,
        "height": height
      };
}
