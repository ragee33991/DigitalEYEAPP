import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/pages/add_question.dart';
import 'package:digital_eye_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

import '../../globals.dart';
import '../MyCustomDialogOne.dart';

void main() => runApp(new FindDoctorScreen(firebaseId));

class FindDoctorScreen extends StatefulWidget {
  final String firebaseId;
  FindDoctorScreen(this.firebaseId);

  @override
  _editsurveyState createState() => _editsurveyState();
}

class Item {
  Item(this.name);
  String name;
}

class _editsurveyState extends State<FindDoctorScreen> {
  int surveyquestionnum = 1;
  int surveyquestiontotal = 1;
  List<TextEditingController> selectedTime = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  static const double _kPickerItemHeight = 32.0;
  List<TextEditingController> selectedItem = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

//  TextEditingController selectedItem = TextEditingController();
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  String quizImgUrl,
      quizTitle,
      quizWeekday,
      ItemDesc1,
      ItemDesc2,
      ItemDesc3,
      ItemDesc4,
      ItemDesc5;

  String uid;
  double _currentSliderValue = 20;

  createQuiz() async {
    quizId = randomAlphaNumeric(16);

    Map<String, String> quizData = {
      "ItemDesc1": selectedItem[0].text + ": " + selectedTime[0].text,
      "ItemDesc2": selectedItem[1].text + ": " + selectedTime[1].text,
      "ItemDesc3": selectedItem[2].text + ": " + selectedTime[2].text,
      "ItemDesc4": selectedItem[3].text + ": " + selectedTime[3].text,
      "ItemDesc5": selectedItem[4].text + ": " + selectedTime[4].text,
      "quizId": quizId,
      "quizImgUrl": quizImgUrl,
      "quizTitle": quizTitle,
      "quizWeekday": quizWeekday
    };

    await databaseService
        .addQuizData(quizData, quizId, RouterName.id.toString())
        .then((value) {
      databaseService.updateTime(RouterName.id.toString());
      setState(() {
        print(ItemDesc1);
        isLoading = false;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AddQuestion(quizId, widget.firebaseId)));
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes";
  }

  bool isLoading = false;
  String quizId;

  List<Item> selectedUser = [null];
  List<Item> selecteddata = [null, null];
  List<Item> users;

  int linkdevices = 1;
  String dropdownvalue = "SELECT FROM DROPDOWN";

  @override
  void initState() {
    super.initState();
    users = <Item>[
      Item('TV'),
      Item('Mobile Phone'),
      Item('Tablet'),
      Item('Computer'),
      Item('Laptop'),
    ];
  }

  @override
  Widget _dropdownbutton(List<Item> userlist, int index) {
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
      child: DropdownButton<Item>(
        underline: SizedBox(),
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down),
        hint: Text("  $dropdownvalue"),
        value: selectedUser[index],
        onChanged: (Item Value) {
          print(Value.toString());
          print(index);
          setState(() {
            selectedUser[index] = Value;
          });
        },
        items: userlist.map((Item user) {
          return DropdownMenuItem<Item>(
            value: user,
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  user.name,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
        title: setHeaderTitle(
            AppTranslations.of(context).text(AppTitle.dashbFindDoctor),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            children: <Widget>[
              setCommonText(
                  "How much time did you spend and what device did you use?",
                  Colors.black54,
                  22.0,
                  FontWeight.w700,
                  2),
              SizedBox(
                height: 35,
              ),
              // setCommonTextFieldForFillTheDetailsTime("How much time did you spend",Icons.access_time),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: linkdevices,
                itemBuilder: (context, index) {
                  return Container(
                    width: 5,
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 18,
                        ),
                        setCommonTextFieldForFillTheDetailsDevice(
                            "How much time did you spend", Icons.tv, index),
                        SizedBox(
                          width: 20,
                        ),
                        setCommonTextFieldForFillTheDetailsTime(
                            "How much time did you spend",
                            Icons.access_time,
                            index),
                      ],
                    ),
                  );

                  /*
                             Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:setCommonTextFieldForFillTheDetailsTime("How much time did you spend",Icons.access_time,index),
                            );

                             */
                },
                separatorBuilder: (context, index) => Container(height: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    child: new Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: new Material(
                        color: AppColor.themeColor,
                        borderRadius: BorderRadius.circular(25),
                        elevation: 5.0,
                        child: new Center(
                          child: new Text(
                            "Add Device",
                            textDirection: SharedManager.shared.direction,
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      selectedUser.add(null);
                      if (linkdevices < 5) {
                        linkdevices++;
                      }
                      setState(() {});
                    },
                  ),
                  InkWell(
                    child: new Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: new Material(
                        color: AppColor.themeColor,
                        borderRadius: BorderRadius.circular(25),
                        elevation: 5.0,
                        child: new Center(
                          child: new Text(
                            "Clear Devices",
                            textDirection: SharedManager.shared.direction,
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    // child: Text("CLEAR ALL DEVICE"),
                    onTap: () {
                      //   selectedUser.clear();
                      linkdevices = 1;
                      setState(() {
                        selectedItem[0].clear();
                        selectedItem[1].clear();
                        selectedItem[2].clear();
                        selectedItem[3].clear();
                        selectedItem[4].clear();

                        selectedTime[0].clear();
                        selectedTime[1].clear();
                        selectedTime[2].clear();
                        selectedTime[3].clear();
                        selectedTime[4].clear();

                        linkdevices = 1;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          backgroundColor: AppColor.themeColor,
          onPressed: () {
            if (selectedTime[0].text.isEmpty == true ||
                selectedItem[0].text.isEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomDialogOne(
                    title: "Alert",
                    content: "Please fill out all the Information.",
                    negativeBtnText: "Done",
                  );
                },
              );
            }
            if (selectedTime[0].text.isEmpty == false) {
              int index = 0;
              createQuiz();
              index++;
            }
          }),
    );
  }

  setCommonTextFieldForFillTheDetailsDevice(
      String hinttext, dynamic myIcon, int index) {
    return new Container(
      height: 50,
      width: 150,
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
              controller: selectedItem[index],
              readOnly: true,
              onTap: () {
                _buildDatePicker(context, index);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                hintText: hinttext,
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }

  setCommonTextFieldForFillTheDetailsTime(
      String hinttext, dynamic myIcon, int index) {
    return new Container(
      height: 50,
      width: 150,

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
            child: new TextFormField(
              controller: selectedTime[index],
              readOnly: true,
              textDirection: SharedManager.shared.direction,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hinttext,
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              onTap: () {
                _buildTimePicker(index);
              },
              style: new TextStyle(color: Colors.black87, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  _buildTimePicker(int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250.0,
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hm,
              onTimerDurationChanged: (Duration value) {
                setState(() {
                  selectedTime[index].text = _formatDuration(value);
                  //ItemDesc ++ index.toString() = selectedTime[index].text;
                  quizTitle = new DateTime.now().toString();
                  quizWeekday =
                      new DateFormat.EEEE().format(new DateTime.now());
                  // print( quizDesc);
                });
              },
            ),
          );
        });
  }

  static const List<String> coolColorNames = <String>[
    'TV',
    'Mobile Phone',
    'Tablet',
    'Computer',
    'Laptop',
    'VR',
  ];

  _buildDatePicker(BuildContext context, int i) {
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
                  selectedItem[i].text = coolColorNames[index];
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

  void showSnackBarHandler(BuildContext context) {
    var snackBar = SnackBar(content: Text("Hello"));

    Scaffold.of(context).showSnackBar(snackBar);
  }
}

class admincontent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}