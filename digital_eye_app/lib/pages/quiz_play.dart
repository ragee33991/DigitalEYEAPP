import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Screens/MyCustomDialogOne.dart';
import 'package:digital_eye_app/Screens/TabBarScreens/DoctorList/DoctorList.dart';

import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/models/question_model.dart';
import 'package:digital_eye_app/services/constants.dart';
import 'package:digital_eye_app/services/database.dart';
import 'package:digital_eye_app/widgets/quiz_play_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';

class QuizPlay extends StatefulWidget {
  final String quizId, firebaseId;
  SharedPreferences sharedPreferences;

  QuizPlay(this.quizId, this.firebaseId);

  @override
  _QuizPlayState createState() => _QuizPlayState();
}

int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int total = 0;
int neck = 0;
int blurred = 0;
int dry = 0;
int irritation = 0;
int headaches = 0;
int doublev = 0;
int none = 0;
int verym = 25;
int mild = 50;
int moderate = 75;
int severe = 100;
int counter = 0;
String date;

////////

double blurredvalue = 0;
String blurredvalues = "";
double pain = 0;
String painvalues = "";
double drypain = 0;
String drypainvalues = "";
double eyepain = 0;
String eyepainvalues = "";
double headpain = 0;
String headpainvalues = "";
double doublepain = 0;
String doublepainvalues = "";

/// Stream
Stream infoStream;

class _QuizPlayState extends State<QuizPlay> {
  QuerySnapshot questionSnaphot;
  DatabaseService databaseService = new DatabaseService();

  bool isLoading = true;

  @override
  void initState() {
    databaseService
        .getQuestionData(widget.quizId, RouterName.id.toString())
        .then((value) {
      questionSnaphot = value;
      _notAttempted = questionSnaphot.docs.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionSnaphot.docs.length;
      setState(() {});
      print("init don $total ${widget.quizId} ");
    });

    if (infoStream == null) {
      infoStream = Stream<List<int>>.periodic(Duration(milliseconds: 100), (x) {
        return [_correct, _incorrect];
      });
    }

    super.initState();
  }

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();

    questionModel.question = questionSnapshot.get("question");
    questionModel.id = questionSnapshot.get("id");
    questionModel.quizId = widget.quizId;
    questionModel.quizWeekday = questionSnapshot.get("quizWeekday");
    date = questionModel.quizWeekday;

    RouterName.quizid = widget.quizId;

    /// shuffling the options
    List<String> options = [
      questionSnapshot.get("option1"),
      questionSnapshot.get("option2"),
      questionSnapshot.get("option3"),
      questionSnapshot.get("option4"),
      questionSnapshot.get("option6"),
      questionSnapshot.get("option7"),
      questionSnapshot.get("option8"),
    ];

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.option6 = options[4];
    questionModel.option7 = options[5];
    questionModel.option8 = options[6];

    questionModel.correctOption = questionSnapshot.get("option1");
    ;
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  final _fbKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Form(
                    // context,
                    key: _fbKey,
                    autovalidate: true,
                    child: Column(
                      children: [
                        Container(
                          child: InfoHeader(
                            length: questionSnaphot.docs.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  questionSnaphot.docs == null
                      ? Container(
                          child: Center(
                            child: Text("No Data"),
                          ),
                        )
                      : ListView.builder(
                          itemCount: questionSnaphot.docs.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return QuizPlayTile(
                              questionModel: getQuestionModelFromDatasnapshot(
                                  questionSnaphot.docs[index]),
                              index: index,
                            );
                          }),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        backgroundColor: AppColor.themeColor,
        onPressed: () {
          if (_notAttempted > 0) {
            showDialog(
              context: context,
              builder: (context) {
                return CustomDialogOne(
                  title: "Alert",
                  content: "Please answer all the Questions.",
                  negativeBtnText: "Done",
                );
              },
            );
          }
          if (_notAttempted == 0) {
            databaseService.setData(date + blurredvalues, blurredvalue);
            databaseService.setMinMaxData(blurredvalues, blurredvalue);
            databaseService.setData(date + painvalues, pain);
            databaseService.setMinMaxData(painvalues, pain);
            databaseService.setData(date + drypainvalues, drypain);
            databaseService.setMinMaxData(drypainvalues, drypain);
            databaseService.setData(date + eyepainvalues, eyepain);
            databaseService.setMinMaxData(eyepainvalues, eyepain);
            databaseService.setData(date + headpainvalues, headpain);
            databaseService.setMinMaxData(headpainvalues, headpain);
            databaseService.setData(date + doublepainvalues, doublepain);
            databaseService.setMinMaxData(doublepainvalues, doublepain);

            double average =
                (blurredvalue + pain + drypain + headpain + doublepain) / 5.0;
            print(average);
            print(blurredvalue);
            print(pain);
            print(drypain);
            print(headpain);
            print(doublepain);

            databaseService.setData(date + "Average", average);

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorsList(),
                ));
          }
        },
      ),
    );
  }
}

class InfoHeader extends StatefulWidget {
  final int length;

  InfoHeader({@required this.length});

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.0,
      child: StreamBuilder(
          stream: infoStream,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Container(
                    height: 40,
                    margin: EdgeInsets.only(left: 14),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        NoOfQuestionTile(
                          text: "Total",
                          number: widget.length,
                        ),
                        NoOfQuestionTile(
                          text: "NotAttempted",
                          number: _notAttempted,
                        ),
                      ],
                    ),
                  )
                : Container();
          }),
    );
  }
}

Map myMap = new Map();
int counter2 = 1;

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  static Map myMap;

  QuizPlayTile({@required this.questionModel, @required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  bool attempted = false;
  String _haveStarted3Times = '';

  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = new DatabaseService();
    var IDe = widget.questionModel.id;
    RouterName.DateOfQuiz = DateTime.now();

    int counter = 1;

    // create our map

// populate it
    List<QuestionModel> people = new List<QuestionModel>();
    people.add(new QuestionModel(
        question: widget.questionModel.question,
        answer: optionSelected,
        quizId: widget.questionModel.id));
    ;
//    print(widget.questionModel.question);

    double sumfortheDay = neck.toDouble() +
        blurred.toDouble() +
        dry.toDouble() +
        irritation.toDouble() +
        headaches.toDouble() +
        doublev.toDouble();
    double result = sumfortheDay / 6;

    String date = widget.questionModel.quizWeekday.toString();
    // String date = "Tuesday";

    //var futuredate =new DateFormat.yMMMMd('en_US') .format(new DateTime.now());
    var addDt = DateTime.now();
    RouterName.TimeOfQuiz = new DateFormat.yMMMMd('en_US')
        .format(addDt.add(Duration(days: 2, hours: 1, minutes: 00)));
    RouterName.Time = new DateFormat.jm().format(new DateTime.now()).toString();
    double MaxBlurr = blurred.toDouble();
    double Maxneck = neck.toDouble();
    double Maxdry = dry.toDouble();
    double MaxBirr = irritation.toDouble();
    double Maxhead = headaches.toDouble();
    double Maxdouble = doublev.toDouble();

    double MinBlurr = blurred.toDouble();
    double Minneck = neck.toDouble();
    double Mindry = dry.toDouble();
    double MinBirr = irritation.toDouble();
    double Minhead = headaches.toDouble();
    double Mindouble = doublev.toDouble();

    String MaxBlurrdate =
        new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Maxneckdate =
        new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Maxdrydate =
        new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String MaxBirrdate =
        new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Maxheaddate =
        new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Maxdoubledate =
        new DateFormat.yMMMd().format(new DateTime.now()).toString();

    String MinBlurrdate =
        new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Minneckdate =
        new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Mindrydate =
        new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String MinBirrdate =
        new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Minheaddate =
        new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Mindoubledate =
        new DateFormat.yMMMd().format(new DateTime.now()).toString();

    if (RouterName.MaxBlurr == Null) {
      RouterName.MaxBlurr = MaxBlurr;
      RouterName.MaxBlurrdate = MaxBlurrdate;
      RouterName.MinBlurrdate = MinBlurrdate;
      RouterName.MinBlurrdate = MinBlurrdate;
    }

    if (RouterName.Minneck == Null) {
      RouterName.Maxneck = Maxneck;
      RouterName.Maxneckdate = Maxneckdate;
      RouterName.Minneck = Minneck;
      RouterName.Maxneckdate = Maxneckdate;
    }

    if (RouterName.Mindrydate == Null) {
      RouterName.Maxdry = Maxdry;
      RouterName.Maxdrydate = Maxdrydate;
      RouterName.Mindry = Mindry;
      RouterName.Mindrydate = Mindrydate;
    }

    if (RouterName.MinBirr == Null) {
      RouterName.MaxBirr = MaxBirr;
      RouterName.MaxBirrdate = MaxBirrdate;
      RouterName.MinBirr = MinBirr;
      RouterName.MinBirrdate = MinBirrdate;
    }

    if (RouterName.Mindouble == Null) {
      RouterName.Maxdouble = Maxdouble;
      RouterName.Maxdoubledate = Maxdoubledate;
      RouterName.Mindouble = Mindouble;
      RouterName.Mindoubledate = Mindoubledate;
      ;
    }
    if (RouterName.Minhead == Null) {
      RouterName.Maxhead = Maxhead;
      RouterName.Maxheaddate = Maxheaddate;
      RouterName.Minhead = Minhead;
      RouterName.Minheaddate = Minheaddate;
    }

    if (MaxBlurr > RouterName.MaxBlurr) {
      RouterName.MaxBlurr = MaxBlurr;
      RouterName.MaxBlurrdate = MaxBlurrdate;
    }

    if (MinBlurr < RouterName.MinBlurr) {
      RouterName.MinBlurr = MinBlurr;
      RouterName.MinBlurrdate = MinBlurrdate;
    }
    if (Maxneck > RouterName.Maxneck) {
      RouterName.Maxneck = Maxneck;
      RouterName.Maxneckdate = Maxneckdate;
    }
    if (Minneck < RouterName.Minneck) {
      RouterName.Minneck = Minneck;
      RouterName.Minneckdate = Minneckdate;
    }
    if (Maxdry > RouterName.Maxdry) {
      RouterName.Maxdry = Maxdry;
      RouterName.Maxdrydate = Maxdrydate;
    }
    if (Mindry < RouterName.Mindry) {
      RouterName.Mindry = Mindry;
      RouterName.Mindrydate = Mindrydate;
    }
    if (MaxBirr > RouterName.MaxBirr) {
      RouterName.MaxBirr = MaxBirr;
      RouterName.MaxBirrdate = MaxBirrdate;
    }
    if (MinBirr < RouterName.MinBirr) {
      RouterName.MinBirr = MinBirr;
      RouterName.MinBirrdate = MinBirrdate;
    }

    if (Maxhead > RouterName.Maxhead) {
      RouterName.Maxhead = Maxhead;
      RouterName.Maxheaddate = Maxheaddate;
    }
    if (Minhead < RouterName.Minhead) {
      RouterName.Minhead = Minhead;
      RouterName.Minheaddate = Minheaddate;
    }

    if (Maxdouble > RouterName.Maxdouble) {
      RouterName.Maxdouble = Maxdouble;
      RouterName.Maxdoubledate = Maxdoubledate;
    }
    if (Mindouble < RouterName.Mindouble) {
      RouterName.Mindouble = Mindouble;
      RouterName.Mindoubledate = Mindoubledate;
    }

    RouterName.blurredToday = blurred.toDouble();
    RouterName.neckToday = neck.toDouble();
    RouterName.dryToday = dry.toDouble();
    RouterName.irritationToday = irritation.toDouble();
    RouterName.headachesToday = headaches.toDouble();
    RouterName.doublevToday = doublev.toDouble();

    if (date == "Monday") {
      RouterName.blurredMe = blurred.toDouble();
      RouterName.neckMe = neck.toDouble();
      RouterName.dryMe = dry.toDouble();
      RouterName.irritationMe = irritation.toDouble();
      RouterName.headachesMe = headaches.toDouble();
      RouterName.doublevMe = doublev.toDouble();

      RouterName.value1 = result.roundToDouble();
      RouterName.dateOfQuiz = "Wednesday";
    }
    if (date == "Tuesday") {
      RouterName.value2 = result.roundToDouble();
      RouterName.dateOfQuiz = "Friday";

      RouterName.blurredT = blurred.toDouble();
      RouterName.neckT = neck.toDouble();
      RouterName.dryT = dry.toDouble();
      RouterName.irritationT = irritation.toDouble();
      RouterName.headachesT = headaches.toDouble();
      RouterName.doublevT = doublev.toDouble();
    }
    if (date == "Wednesday") {
      RouterName.value3 = result.roundToDouble();
      RouterName.dateOfQuiz = "Sunday";

      RouterName.blurredW = blurred.toDouble();
      RouterName.neckW = neck.toDouble();
      RouterName.dryW = dry.toDouble();
      RouterName.irritationW = irritation.toDouble();
      RouterName.headachesW = headaches.toDouble();
      RouterName.doublevW = doublev.toDouble();
    }
    if (date == "Thursday") {
      RouterName.value4 = result.roundToDouble();
      RouterName.dateOfQuiz = "Tuesday";

      RouterName.blurredTH = blurred.toDouble();
      RouterName.neckTH = neck.toDouble();
      RouterName.dryTH = dry.toDouble();
      RouterName.irritationTH = irritation.toDouble();
      RouterName.headachesTH = headaches.toDouble();
      RouterName.doublevTH = doublev.toDouble();
    }
    if (date == "Friday") {
      RouterName.value5 = result.roundToDouble();
      RouterName.dateOfQuiz = "Thursday";

      RouterName.blurredFR = blurred.toDouble();
      RouterName.neckFR = neck.toDouble();
      RouterName.dryFR = dry.toDouble();
      RouterName.irritationFR = irritation.toDouble();
      RouterName.headachesFR = headaches.toDouble();
      RouterName.doublevFR = doublev.toDouble();
    }
    if (date == "Saturday") {
      RouterName.value6 = result.roundToDouble();
      RouterName.dateOfQuiz = "Saturday";

      RouterName.blurredSA = blurred.toDouble();
      RouterName.neckSA = neck.toDouble();
      RouterName.drySA = dry.toDouble();
      RouterName.irritationSA = irritation.toDouble();
      RouterName.headachesSA = headaches.toDouble();
      RouterName.doublevSA = doublev.toDouble();
    }
    if (date == "Sunday") {
      RouterName.value7 = result.roundToDouble();
      RouterName.dateOfQuiz = "Tuesday";

      Constants c = new Constants();

      RouterName.blurredSU = blurred.toDouble();
      RouterName.neckSU = neck.toDouble();
      RouterName.drySU = dry.toDouble();
      RouterName.irritationSU = irritation.toDouble();
      RouterName.headachesSU = headaches.toDouble();
      RouterName.doublevSU = doublev.toDouble();
    }

    Future<int> _getIntFromSharedPref() async {
      final prefs = await SharedPreferences.getInstance();
      final startupNumber = prefs.getInt('startupNumber');
      if (startupNumber == null) {
        return 0;
      }
      return startupNumber;
    }

    Future<void> _resetCounter() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('startupNumber', 0);
    }

    Future<void> _incrementStartup() async {
      final prefs = await SharedPreferences.getInstance();

      int lastStartupNumber = await _getIntFromSharedPref();
      int currentStartupNumber = ++lastStartupNumber;

      await prefs.setInt('startupNumber', currentStartupNumber);

      if (currentStartupNumber == 3) {
        setState(() =>
            _haveStarted3Times = '$currentStartupNumber Times started the app');

        // Reset only if you want to
        await _resetCounter();
      } else {
        setState(() =>
            _haveStarted3Times = '$currentStartupNumber Times started the app');
      }
    }

    myMap.putIfAbsent(counter2, () => widget.questionModel.question.toString());
    myMap.putIfAbsent(counter2, () => optionSelected);
    counter2++;
    myMap.putIfAbsent(counter2, () => widget.questionModel.id.toString());
    counter2++;
    myMap.putIfAbsent(counter2, () => DateTime.now().toString());
    counter2++;

    if (widget.questionModel.question ==
        "Have you experienced neck pain today?") {
      if (optionSelected == "None") {
        setState(() => pain = 0.0);
        setState(() => painvalues = 'pain');

        print(date + "blurred");
      }

      if (optionSelected == "Very Mild") {
        print(date + "blurred");

        setState(() => pain = 28.0);
        setState(() => painvalues = 'pain');
      }
      if (optionSelected == "Mild") {
        print(date + "blurred");

        setState(() => pain = 42.0);
        setState(() => painvalues = 'pain');
      }
      if (optionSelected == "Moderate") {
        print(date + "blurred");

        setState(() => pain = 57.0);
        setState(() => painvalues = 'pain');
      }
      if (optionSelected == "Moderate Severe") {
        print(date + "blurred");

        setState(() => pain = 71.0);
        setState(() => painvalues = 'pain');
      }

      if (optionSelected == "Severe") {
        print(date + "blurred");

        setState(() => pain = 85.0);
        setState(() => painvalues = 'pain');
      }
      print(optionSelected);

      if (optionSelected == "Very Severe") {
        print(date + "blurred");

        setState(() => pain = 100.0);
        setState(() => painvalues = 'pain');
      }
    }

    if (widget.questionModel.question ==
        "Have you experienced blurred vision today?") {
      if (optionSelected == "None") {
        setState(() => blurredvalue = 0.0);
        setState(() => blurredvalues = 'blurred');

        print(date + "blurred");
      }

      if (optionSelected == "Very Mild") {
        print(date + "blurred");

        setState(() => blurredvalue = 28.0);
        setState(() => blurredvalues = 'blurred');
      }
      if (optionSelected == "Mild") {
        print(date + "blurred");

        setState(() => blurredvalue = 42.0);
        setState(() => blurredvalues = 'blurred');
      }
      if (optionSelected == "Moderate") {
        print(date + "blurred");

        setState(() => blurredvalue = 57.0);
        setState(() => blurredvalues = 'blurred');
      }
      if (optionSelected == "Moderate Severe") {
        print(date + "blurred");

        setState(() => blurredvalue = 71.0);
        setState(() => blurredvalues = 'blurred');
      }

      if (optionSelected == "Severe") {
        print(date + "blurred");

        setState(() => blurredvalue = 85.0);
        setState(() => blurredvalues = 'blurred');
      }
      print(optionSelected);

      if (optionSelected == "Very Severe") {
        print(date + "blurred");

        setState(() => blurredvalue = 100.0);
        setState(() => blurredvalues = 'blurred');
      }
    }

    if (widget.questionModel.question ==
        "Have you experienced dry eyes today?") {
      if (optionSelected == "None") {
        setState(() => drypain = 0.0);
        setState(() => drypainvalues = 'dry');

        print(date + "blurred");
      }

      if (optionSelected == "Very Mild") {
        print(date + "blurred");

        setState(() => drypain = 28.0);
        setState(() => drypainvalues = 'dry');
      }
      if (optionSelected == "Mild") {
        print(date + "blurred");

        setState(() => drypain = 42.0);
        setState(() => drypainvalues = 'dry');
      }
      if (optionSelected == "Moderate") {
        print(date + "blurred");

        setState(() => drypain = 57.0);
        setState(() => drypainvalues = 'dry');
      }
      if (optionSelected == "Moderate Severe") {
        print(date + "blurred");

        setState(() => drypain = 71.0);
        setState(() => drypainvalues = 'dry');
      }

      if (optionSelected == "Severe") {
        print(date + "blurred");

        setState(() => drypain = 85.0);
        setState(() => drypainvalues = 'dry');
      }
      print(optionSelected);

      if (optionSelected == "Very Severe") {
        print(date + "blurred");

        setState(() => drypain = 100.0);
        setState(() => drypainvalues = 'dry');
      }
    }

    if (widget.questionModel.question ==
        "Have you experience eye irritation today?") {
      if (optionSelected == "None") {
        setState(() => eyepain = 0.0);
        setState(() => eyepainvalues = 'eye');

        print(date + "blurred");
      }

      if (optionSelected == "Very Mild") {
        print(date + "blurred");

        setState(() => eyepain = 28.0);
        setState(() => eyepainvalues = 'eye');
      }
      if (optionSelected == "Mild") {
        print(date + "blurred");

        setState(() => eyepain = 42.0);
        setState(() => eyepainvalues = 'eye');
      }
      if (optionSelected == "Moderate") {
        print(date + "blurred");

        setState(() => eyepain = 57.0);
        setState(() => eyepainvalues = 'eye');
      }
      if (optionSelected == "Moderate Severe") {
        print(date + "blurred");

        setState(() => eyepain = 71.0);
        setState(() => eyepainvalues = 'eye');
      }

      if (optionSelected == "Severe") {
        print(date + "blurred");

        setState(() => eyepain = 85.0);
        setState(() => eyepainvalues = 'eye');
      }
      print(optionSelected);

      if (optionSelected == "Very Severe") {
        print(date + "blurred");

        setState(() => eyepain = 100.0);
        setState(() => eyepainvalues = 'eye');
      }
    }

    if (widget.questionModel.question ==
        "Have you experienced headaches today?") {
      if (optionSelected == "None") {
        setState(() => headpain = 0.0);
        setState(() => headpainvalues = 'head');

        print(date + "blurred");
      }

      if (optionSelected == "Very Mild") {
        print(date + "blurred");

        setState(() => headpain = 28.0);
        setState(() => headpainvalues = 'head');
      }
      if (optionSelected == "Mild") {
        print(date + "blurred");

        setState(() => headpain = 42.0);
        setState(() => headpainvalues = 'head');
      }
      if (optionSelected == "Moderate") {
        print(date + "blurred");

        setState(() => headpain = 57.0);
        setState(() => headpainvalues = 'head');
      }
      if (optionSelected == "Moderate Severe") {
        print(date + "blurred");

        setState(() => headpain = 71.0);
        setState(() => headpainvalues = 'head');
      }

      if (optionSelected == "Severe") {
        print(date + "blurred");

        setState(() => headpain = 85.0);
        setState(() => headpainvalues = 'head');
      }
      print(optionSelected);

      if (optionSelected == "Very Severe") {
        print(date + "blurred");

        setState(() => headpain = 100.0);
        setState(() => headpainvalues = 'head');
      }
    }

    if (widget.questionModel.question ==
        "Have you experienced double vision today?") {
      if (optionSelected == "None") {
        setState(() => doublepain = 0.0);
        setState(() => doublepainvalues = 'double');

        print(date + "blurred");
      }

      if (optionSelected == "Very Mild") {
        print(date + "blurred");

        setState(() => doublepain = 28.0);
        setState(() => doublepainvalues = 'double');
      }
      if (optionSelected == "Mild") {
        print(date + "blurred");

        setState(() => doublepain = 42.0);
        setState(() => doublepainvalues = 'double');
      }
      if (optionSelected == "Moderate") {
        print(date + "blurred");

        setState(() => doublepain = 57.0);
        setState(() => doublepainvalues = 'double');
      }
      if (optionSelected == "Moderate Severe") {
        print(date + "blurred");

        setState(() => doublepain = 71.0);
        setState(() => doublepainvalues = 'double');
      }

      if (optionSelected == "Severe") {
        print(date + "blurred");

        setState(() => doublepain = 85.0);
        setState(() => doublepainvalues = 'double');
      }
      print(optionSelected);

      if (optionSelected == "Very Severe") {
        print(date + "blurred");

        setState(() => doublepain = 100.0);
        setState(() => doublepainvalues = 'double');
      }
    }

// read from it
// read from it
    //print(IDe);
    databaseService.updateQuizData(widget.questionModel.quizId, optionSelected,
        IDe, RouterName.id.toString());

    ///  TestIndicators.setChardIndicatorView(new DateFormat.EEEE().format(new DateTime.now()).toString(),result);

    return Container(
      child: Card(
        color: Colors.white,
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  "${widget.index + 1} ${")"} ${widget.questionModel.question}",
                  style: TextStyle(
                      fontSize: 18, color: Colors.black.withOpacity(0.8)),
                  //    setCommonText(AppTranslations.of(context).text(AppTitle.dashbTitleNote),Colors.black54,22.0, FontWeight.w700,2),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  if (!widget.questionModel.answered) {
                    ///correct
                    if (widget.questionModel.option1 ==
                        widget.questionModel.correctOption) {
                      setState(() {
                        optionSelected = widget.questionModel.option1;
                        widget.questionModel.answered = false;
                      });
                    } else {
                      setState(() {
                        optionSelected = widget.questionModel.option1;
                        widget.questionModel.answered = false;
                      });
                    }
                  }
                  if (attempted == false) {
                    _notAttempted = _notAttempted - 1;
                    attempted = true;
                  }
                },
                child: OptionTile(
                  option: "1",
                  description: "${widget.questionModel.option1}",
                  correctAnswer: optionSelected,
                  optionSelected: optionSelected,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              GestureDetector(
                onTap: () {
                  if (!widget.questionModel.answered) {
                    ///correct
                    if (widget.questionModel.option2 ==
                        widget.questionModel.correctOption) {
                      setState(() {
                        optionSelected = widget.questionModel.option2;
                        widget.questionModel.answered = false;
                      });
                    } else {
                      setState(() {
                        optionSelected = widget.questionModel.option2;
                        widget.questionModel.answered = false;
                      });
                    }
                  }
                  if (attempted == false) {
                    _notAttempted = _notAttempted - 1;
                    attempted = true;
                  }
                },
                child: OptionTile(
                  option: "2",
                  description: "${widget.questionModel.option2}",
                  correctAnswer: optionSelected,
                  optionSelected: optionSelected,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              GestureDetector(
                onTap: () {
                  if (!widget.questionModel.answered) {
                    ///correct
                    if (widget.questionModel.option3 ==
                        widget.questionModel.correctOption) {
                      setState(() {
                        optionSelected = widget.questionModel.option3;
                        widget.questionModel.answered = false;
                      });
                    } else {
                      setState(() {
                        optionSelected = widget.questionModel.option3;
                        widget.questionModel.answered = false;
                      });
                    }
                  }
                  if (attempted == false) {
                    _notAttempted = _notAttempted - 1;
                    attempted = true;
                  }
                },
                child: OptionTile(
                  option: "3",
                  description: "${widget.questionModel.option3}",
                  correctAnswer: optionSelected,
                  optionSelected: optionSelected,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              GestureDetector(
                onTap: () {
                  if (!widget.questionModel.answered) {
                    ///correct
                    if (widget.questionModel.option4 ==
                        widget.questionModel.correctOption) {
                      setState(() {
                        optionSelected = widget.questionModel.option4;
                        widget.questionModel.answered = false;
                      });
                    } else {
                      setState(() {
                        optionSelected = widget.questionModel.option4;
                        widget.questionModel.answered = false;
                      });
                    }
                  }
                  if (attempted == false) {
                    _notAttempted = _notAttempted - 1;
                    attempted = true;
                  }
                },
                child: OptionTile(
                  option: "4",
                  description: "${widget.questionModel.option4}",
                  correctAnswer: optionSelected,
                  optionSelected: optionSelected,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              GestureDetector(
                onTap: () {
                  if (!widget.questionModel.answered) {
                    ///correct
                    if (widget.questionModel.option6 ==
                        widget.questionModel.correctOption) {
                      setState(() {
                        optionSelected = widget.questionModel.option6;
                        widget.questionModel.answered = false;
                      });
                    } else {
                      setState(() {
                        optionSelected = widget.questionModel.option6;
                        widget.questionModel.answered = false;
                      });
                    }
                  }
                  if (attempted == false) {
                    _notAttempted = _notAttempted - 1;
                    attempted = true;
                  }
                },
                child: OptionTile(
                  option: "5",
                  description: "${widget.questionModel.option6}",
                  correctAnswer: optionSelected,
                  optionSelected: optionSelected,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              GestureDetector(
                onTap: () {
                  if (!widget.questionModel.answered) {
                    ///correct
                    if (widget.questionModel.option7 ==
                        widget.questionModel.correctOption) {
                      setState(() {
                        optionSelected = widget.questionModel.option7;
                        widget.questionModel.answered = false;
                      });
                    } else {
                      setState(() {
                        optionSelected = widget.questionModel.option7;
                        widget.questionModel.answered = false;
                      });
                    }
                  }
                  if (attempted == false) {
                    _notAttempted = _notAttempted - 1;
                    attempted = true;
                  }
                },
                child: OptionTile(
                  option: "6",
                  description: "${widget.questionModel.option7}",
                  correctAnswer: optionSelected,
                  optionSelected: optionSelected,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              GestureDetector(
                onTap: () {
                  if (!widget.questionModel.answered) {
                    ///correct
                    if (widget.questionModel.option8 ==
                        widget.questionModel.correctOption) {
                      setState(() {
                        optionSelected = widget.questionModel.option8;
                        widget.questionModel.answered = false;
                      });
                    } else {
                      setState(() {
                        optionSelected = widget.questionModel.option8;
                        widget.questionModel.answered = false;
                      });
                    }
                  }
                  if (attempted == false) {
                    _notAttempted = _notAttempted - 1;
                    attempted = true;
                  }
                },
                child: OptionTile(
                  option: "7",
                  description: "${widget.questionModel.option8}",
                  correctAnswer: optionSelected,
                  optionSelected: optionSelected,
                ),
              ),
              SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
