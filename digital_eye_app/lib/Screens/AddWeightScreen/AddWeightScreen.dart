import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/models/user.dart';
import 'package:digital_eye_app/pages/add_question.dart';
import 'package:digital_eye_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

import '../../globals.dart';

void main() => runApp(new AddWeightScreen(firebaseId));

class AddWeightScreen extends StatefulWidget {
  final String firebaseId;

  AddWeightScreen(this.firebaseId);

  @override
  _AddWeightScreenState createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  TextEditingController selectedTime = TextEditingController();
  static const double _kPickerItemHeight = 32.0;
  TextEditingController selectedItem = TextEditingController();

  DatabaseService databaseService = new DatabaseService();

  String quizImgUrl, quizTitle, quizDesc, quizWeekday;
  String uid;

  bool isLoading = false;
  String quizId;

  CustomRadioState(User gCurrentUser) {
    this.uid = gCurrentUser as String;
  }

  static const List<String> coolColorNames = <String>[
    'Male',
    'Female',
    'Non-Binary',
    'Other',
  ];

  createQuiz() async {
    quizId = randomAlphaNumeric(16);

    Map<String, String> quizData = {
      "quizId": quizId,
      "quizImgUrl": quizImgUrl,
      "quizTitle": quizTitle,
      "quizDesc": quizDesc,
      "quizWeekday": quizWeekday
    };
  }

  @override
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Widget build(BuildContext context) {
    String gender;
    String dob;
    var year;
    var month;
    var date;
    var selectedItems = "";
    var selectedTimes = "";
    var defaultdate = "";
    var defaultgender = "";
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(RouterName.id.toString()).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            print("Full Name: ${data['dob']} ${data['gender']}");
            defaultgender = data['gender'].toString();
            defaultdate = data['dob'].toString();
            gender = data['gender'].toString();
            dob = data['dob'].toString();
            var parts = dob.split('-');
            print("gender: " + gender);
            year = parts[0].trim();
            month = parts[1].trim();
            date = parts[2].trim();
            print("month" + month);
            print("year" + year);
            print("date" + date);
            selectedItems = gender;
            selectedTimes = new DateFormat.yMMMd().format(
                DateTime(int.parse(year), int.parse(month), int.parse(date)));
          }

          return new MaterialApp(
            debugShowCheckedModeBanner: false,
            home: new Scaffold(
              body: new Container(
                padding: new EdgeInsets.all(20),
                color: Colors.white,
                child: new ListView(
                  children: <Widget>[
                    setCommonText("Update Your Data", Colors.black54, 22.0,
                        FontWeight.w700, 2),
                    SizedBox(
                      height: 35,
                    ),
                    setCommonTextFieldForFillTheDetailsDevice(
                      selectedItems,
                      Icons.person,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    setCommonTextFieldForFillTheDetailsTime(
                        selectedTimes, Icons.cake),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (selectedTime.text.isEmpty) {
                          setState(() {
                            selectedTime.text = defaultdate;
                            print("is empty");
                            print(selectedTime.text);
                          });
                        }
                        if (selectedItem.text.isEmpty) {
                          selectedItem.text = defaultgender;
                          print("hello there");
                          print(selectedItem.text);
                        }
                        print(selectedItem.text);
                        print(selectedTime.text);

                        databaseService.updateUser(RouterName.id.toString(),
                            selectedTime.text, selectedItem.text);
                        // createQuiz();
                        Navigator.of(context).pop();
                      },
                      child: new Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: new Material(
                          color: AppColor.themeColor,
                          borderRadius: BorderRadius.circular(25),
                          elevation: 5.0,
                          child: new Center(
                            child: new Text(
                              "SAVE",
                              textDirection: SharedManager.shared.direction,
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              appBar: new AppBar(
                centerTitle: true,
                // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
                title: setHeaderTitle(
                    AppTranslations.of(context).text(AppTitle.addWeight),
                    Colors.white),
                backgroundColor: AppColor.themeColor,
                elevation: 1.0,
                leading: new IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            theme: SharedManager.shared.getThemeType(),
            localizationsDelegates: [
              //provides localised strings
              GlobalMaterialLocalizations.delegate,
              //provides RTL support
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [SharedManager.shared.language],
          );
        });
  }

  _buildTimePicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime(1969, 1, 1),
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() {
                  print(newDateTime);
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(newDateTime);
                  print("format dat :" + formattedDate);

                  selectedTime.text = formattedDate;

                  // print( quizDesc);
                });
              },
              use24hFormat: false,
              minuteInterval: 1,
            ),
          );
        });
  }

  _buildDatePicker(BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250.0,
            child: CupertinoPicker(
              itemExtent: _kPickerItemHeight,
              backgroundColor: CupertinoColors.white,
              onSelectedItemChanged: (int index) {
                setState(() {
                  selectedItem.text = coolColorNames[index];
                });
              },
              children:
                  List<Widget>.generate(coolColorNames.length, (int index) {
                return Center(
                  child: Text(coolColorNames[index]),
                );
              }),
            ),
          );
        });
  }

  setCommonTextFieldForFillTheDetailsDevice(String hinttext, dynamic myIcon) {
    return new Container(
      height: 50,
      // color: Colors.teal,
      padding: new EdgeInsets.only(
        left: 12,
        right: 25,
        bottom: 4,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
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
            child: new TextField(
              controller: selectedItem,
              readOnly: true,
              onTap: () {
                _buildDatePicker(context);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                hintText: hinttext,
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }

  setCommonTextFieldForFillTheDetailsTime(String hinttext, dynamic myIcon) {
    return new Container(
      height: 50,
      // color: Colors.teal,
      padding: new EdgeInsets.only(
        left: 12,
        right: 25,
        bottom: 4,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
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
              controller: selectedTime,
              readOnly: true,
              textDirection: SharedManager.shared.direction,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hinttext,
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              onTap: () {
                _buildTimePicker();
              },
              style: new TextStyle(color: Colors.black87, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
