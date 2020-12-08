import 'package:flutter/material.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';

setTextFiels1(String hinttext, dynamic myIcon, TextEditingController m) {
  return new Container(
    height: 45,
    // color: Colors.teal,
    padding: new EdgeInsets.only(left: 8, right: 25),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.5),
        border: Border.all(color: AppColor.themeColor)),
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(
          myIcon,
          color: Colors.grey,
          size: 18,
        ),
        SizedBox(
          width: 5,
        ),
        new Expanded(
          child: new TextFormField(
            textDirection: SharedManager.shared.direction,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hinttext,
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            controller: m,
            style: new TextStyle(color: Colors.grey, fontSize: 16),
          ),
        )
      ],
    ),
  );
}

setTextFiels(String hinttext, dynamic myIcon) {
  return new Container(
    height: 45,
    // color: Colors.teal,
    padding: new EdgeInsets.only(left: 8, right: 25),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.5),
        border: Border.all(color: AppColor.themeColor)),
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(
          myIcon,
          color: Colors.grey,
          size: 18,
        ),
        SizedBox(
          width: 5,
        ),
        new Expanded(
          child: new TextFormField(
            textDirection: SharedManager.shared.direction,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hinttext,
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            style: new TextStyle(color: Colors.grey, fontSize: 16),
          ),
        )
      ],
    ),
  );
}

class CreateAccountString {
  static var fullName = "";
  static var dob = "";
  static var gender = "";
  static var height = "";
  static var weight = "";
}

createAccountTextField(String hinttext, dynamic myIcon, int tag) {
  return new Container(
    height: 65,
    // color: Colors.teal,
    padding: new EdgeInsets.only(left: 20, right: 8, bottom: 4, top: 4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.5),
        border: Border.all(color: AppColor.themeColor)),
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
          child: new TextFormField(
            textDirection: SharedManager.shared.direction,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hinttext,
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            style: new TextStyle(color: Colors.grey, fontSize: 16),
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter $hinttext first";
              }
              {
                switch (tag) {
                  case 0:
                    CreateAccountString.fullName = value;
                    break;
                  case 1:
                    CreateAccountString.dob = value;
                    break;
                  case 2:
                    CreateAccountString.gender = value;
                    break;
                  case 3:
                    CreateAccountString.weight = value;
                    break;
                  case 4:
                    CreateAccountString.height = value;
                    break;
                  default:
                }
                return value;
              }
            },
          ),
        ),
        new Icon(
          myIcon,
          color: Colors.grey,
          size: 30,
        ),
        SizedBox(
          width: 3,
        ),
      ],
    ),
  );
}
