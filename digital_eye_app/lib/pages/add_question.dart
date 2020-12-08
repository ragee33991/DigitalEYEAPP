import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/pages/quiz_play.dart';
import 'package:digital_eye_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../globals.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  final String firebaseId;

  AddQuestion(this.quizId, this.firebaseId);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = true;
  String question = "",
      option1 = "",
      option2 = "",
      option3 = "",
      option4 = "",
      answer = "";

  DatabaseService databaseService = new DatabaseService();
  uploadQuestionData() async {
    if (_isLoading == true) {
      return CircularProgressIndicator();
    }

    if (_formKey.currentState.validate()) {
      Map<String, String> questionMap1 = {
        "question":
            "Did you experienced blurred vision today??", // 1st qns has 3 choices,
        "option1": "None",
        "option2": "Very Mild",
        "option3": "Mild",
        "option4": "Moderate",
        "option5": "Severe",
        "answer": ""
      };

      Map<String, String> questionMap2 = {
        "question": "Did you experienced dry or red eyes today? ",
        "option1": "never",
        "option2": "always",
        "option3": "often",
        "option4": "sometimes"
      };

      Map<String, String> questionMap3 = {
        "question":
            "Have you experienced double vision today? ", // 2nd qns has 4 choices
        "option1": "never",
        "option2": "always",
        "option3": "often",
        "option4": "sometimes",
        "answer": ""
      };

      Map<String, String> questionMap4 = {
        "question":
            "Have you expieremnced back or shoulder pain ", // 2nd qns has 4 choices
        "option1": "never",
        "option2": "always",
        "option3": "often",
        "option4": "sometimes"
      };
    }
  }

  @override
  void initState() {
    TimeOfDay roomBooked2 = TimeOfDay.fromDateTime(
        DateTime.now().add(Duration(hours: 20, minutes: 0))); // 4:30pm
    //databaseService.addUser(uid, RouterName.usern, RouterName.dob, RouterName.gender);#
    databaseService.configureCustomReminder(
        true, roomBooked2, Duration(hours: 20, minutes: 0));
    print("add quest " + RouterName.id.toString());
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();
    DocumentReference documentReference2 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();
    DocumentReference documentReference3 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();
    DocumentReference documentReference4 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();
    DocumentReference documentReference5 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();
    DocumentReference documentReference6 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();

    DocumentReference documentReference7 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();
    DocumentReference documentReference8 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();

    DocumentReference documentReference9 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();
    DocumentReference documentReference10 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();

    DocumentReference documentReference11 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();
    DocumentReference documentReference12 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();

    DocumentReference documentReference13 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();
    DocumentReference documentReference14 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();

    DocumentReference documentReference15 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();
    DocumentReference documentReference16 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();

    DocumentReference documentReference17 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();
    DocumentReference documentReference18 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();

    DocumentReference documentReference19 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();

    DocumentReference documentReference20 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();

    DocumentReference documentReference21 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();

    DocumentReference documentReference22 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();

    DocumentReference documentReference23 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();

    DocumentReference documentReference24 = FirebaseFirestore.instance
        .collection("users")
        .doc(RouterName.id.toString())
        .collection("Quiz")
        .doc(widget.quizId)
        .collection("QNA")
        .doc();
    // var one =  databaseService.addQuestionData(questionMap4, widget.quizId);

    documentReference.set({
      "question":
          "Have you experienced blurred vision today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),

      'id': documentReference.id
    });

    documentReference2.set({
      "question": "Have you experienced dry eyes today?",
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference2.id
    });

    documentReference3.set({
      "question": "Have you experienced double vision today?",
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference3.id
    });

    documentReference4.set({
      "question":
          "Have you experience eye irritation today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference4.id
    });

    documentReference5.set({
      "question": "Have you experienced headaches today?",
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference5.id
    });

    documentReference6.set({
      "question":
          "Have you experienced neck pain today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference6.id
    });

    documentReference18.set({
      "question": "Have you experienced red eyes today? ",
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference18.id
    });

    documentReference19.set({
      "question":
          "Have you experienced back pain today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference19.id
    });

    documentReference7.set({
      "question":
          "Have you experienced burning eyes today??", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference7.id
    });
    documentReference8.set({
      "question":
          "Have you experienced difficulty concentrating today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference8.id
    });
    documentReference9.set({
      "question":
          "Have you experienced tearing eyes today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference9.id
    });
    documentReference10.set({
      "question":
          "Have you experienced eye soreness today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference10.id
    });

    documentReference11.set({
      "question":
          "Have you experienced watering of eyes today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference11.id
    });

    documentReference12.set({
      "question":
          "Have you experienced hot eyes today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference12.id
    });

    documentReference13.set({
      "question":
          "Have you experienced the feeling of worsening of sight today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference13.id
    });

    documentReference14.set({
      "question":
          "Have you experienced increased sensitivity to light today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference14.id
    });

    documentReference16.set({
      "question":
          "Have you experienced excessive blinking today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference16.id
    });

    documentReference17.set({
      "question":
          "Have you experienced heavy eyelids today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference17.id
    });

    documentReference20.set({
      "question":
          "Have you experienced seeing colored halos around objects today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference20.id
    });
    documentReference21.set({
      "question":
          "Have you experienced eye strain today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference21.id
    });

    documentReference22.set({
      "question":
          "Have you experienced eye ache today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference22.id
    });

    documentReference23.set({
      "question":
          "Have you experienced excessive blinking today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference23.id
    });

    documentReference24.set({
      "question":
          "Have you experienced shoulder pain today?", // 1st qns has 3 choices,
      "option1": "None",
      "option2": "Very Mild",
      "option3": "Mild",
      "option4": "Moderate",
      "option6": "Moderate Severe",
      "option7": "Severe",
      "option8": "Very Severe",
      "answer": "",
      "quizWeekday":
          new DateFormat.EEEE().format(new DateTime.now()).toString(),
      'id': documentReference24.id
    });

    setState(() {
      _isLoading = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
        title: setHeaderTitle(
            AppTranslations.of(context).text(AppTitle.dashbFindDoctor),
            Colors.white),
        backgroundColor: AppColor.themeColor,
        elevation: 1.0,
      ),
      // drawer: DrawerOnly(),
      body: _isLoading
          ? ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      // Linear Loader with AppBar
                      LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(appColor),
                      ),
                      // Jumping Dots Loader
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      SizedBox(height: 40.0),
                      // Jumping icon Loader
                      CollectionSlideTransition(
                        children: <Widget>[
                          Icon(Icons.android),
                          Icon(Icons.phone_iphone),
                          Icon(Icons.apps),
                        ],
                      ),
                      // Scalling Icon with jump Loader
                      SizedBox(height: 40.0),
                    ],
                  ),
                ),
              ],
            )
          : QuizPlay(widget.quizId, widget.firebaseId),
    );
  }
}
