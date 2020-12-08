import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_eye_app/Screens/DoctorList/DoctorList.dart';
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
  final _formKey = GlobalKey<FormState>();

  String quizImgUrl, quizTitle, quizDesc,quizWeekday;
  String uid;
  double _currentSliderValue = 20;

  bool isLoading = false;
  String quizId;

  CustomRadioState(User gCurrentUser){
    this.uid = gCurrentUser as String;
  }


  static const List<String> coolColorNames = <String>[
    'MALE',
    'FEMALE',
    'NON-BINARY',
    'OTHER',
  ];


  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  createQuiz() async{

    quizId = randomAlphaNumeric(16);



    Map<String, String> quizData = {
      "quizId":quizId,
      "quizImgUrl" : quizImgUrl,
      "quizTitle" : quizTitle,
      "quizDesc" : quizDesc,
      "quizWeekday": quizWeekday




    };

    await databaseService.addQuizData(quizData, quizId,RouterName.id.toString()).then((value){
      setState(() {
        print( quizDesc);
        isLoading = false;
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) =>  AddQuestion(quizId,widget.firebaseId)
        ));
      });

    });

  }


  @override
  CollectionReference users = FirebaseFirestore.instance.collection('users');


  Widget build(BuildContext context) {
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

                selectedItem.text = coolColorNames[0];
                selectedTime.text = new DateFormat.yMMMd().format(DateTime(1969, 1, 1));


              }
              return new MaterialApp(
          debugShowCheckedModeBanner:false,
          home: new Scaffold(
            body: new Container(
              padding: new EdgeInsets.all(20),
              color:Colors.white,
              child: new ListView(
                children: <Widget>[
                  setCommonText("Update Your Data",Colors.black54,22.0, FontWeight.w700,2),
                  SizedBox(height: 35,),
                  setCommonTextFieldForFillTheDetailsDevice("GENDER",Icons.person,),
                  SizedBox(height: 20,),
                  setCommonTextFieldForFillTheDetailsTime("DATE OF BIRTH",Icons.cake),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
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
                          child: new Text("SAVE",
                            textDirection: SharedManager.shared.direction,
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            ),
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
              title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.addWeight),Colors.white),
              backgroundColor: AppColor.themeColor,
              elevation: 1.0,
              leading: new IconButton(
                icon: Icon(Icons.arrow_back_ios,color:Colors.white),
                onPressed: (){
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
          supportedLocales: [
            SharedManager.shared.language
          ],
        );
      }
    );
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
                  DateTime now = DateTime(1969, 1, 1);
                  String formattedDate = DateFormat('yyyy-MM-dd').format(newDateTime);
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


  setCommonTextFieldForFillTheDetailsDevice(String hinttext,dynamic myIcon){
    return new Container(
      height: 50,
      // color: Colors.teal,
      padding: new EdgeInsets.only(left: 12,right: 25,bottom: 4,),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColor.themeColor)
      ),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(myIcon,color: Colors.grey,size: 18,),
          SizedBox(width: 5,),
          new Expanded(
            child: new  TextField(
              controller: selectedItem,
              readOnly: true,
              onTap: () {
                _buildDatePicker(context);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                hintText: hinttext,
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                ),
              ),
            ),
          )
        ],
      ),
    );
  }



  setCommonTextFieldForFillTheDetailsTime(String hinttext,dynamic myIcon){
    return new Container(
      height: 50,
      // color: Colors.teal,
      padding: new EdgeInsets.only(left: 12,right: 25,bottom: 4,),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColor.themeColor)
      ),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(myIcon,color: Colors.grey,size: 18,),
          SizedBox(width: 5,),
          new Expanded(
            child: new TextFormField(
              controller: selectedTime,
              readOnly: true,
              textDirection: SharedManager.shared.direction,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hinttext,
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                ),

              ),
              onTap: () {
                _buildTimePicker();
              },
              style: new TextStyle(
                  color: Colors.black87,
                  fontSize: 16
              ),
            ),
          )
        ],
      ),
    );
  }
}