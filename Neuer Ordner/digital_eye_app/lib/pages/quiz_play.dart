import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_eye_app/Constant/sharedpreference_page.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Screens/TabBarScreens/DoctorList/DoctorList.dart';
import 'package:digital_eye_app/Screens/TabBarScreens/DoctorList/camera_preview_scanner.dart';

import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/models/question_model.dart';
import 'package:digital_eye_app/pages/result.dart';
import 'package:digital_eye_app/services/database.dart';
import 'package:digital_eye_app/widgets/quiz_play_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../globals.dart';

class QuizPlay extends StatefulWidget {
  final String quizId, firebaseId;


  QuizPlay(
      this.quizId,this.firebaseId
      );

  @override
  _QuizPlayState createState() => _QuizPlayState();


}


int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int total = 0;
int neck = 0;
int blurred =0;
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



/// Stream
Stream infoStream;

class _QuizPlayState extends State<QuizPlay> {
  QuerySnapshot questionSnaphot;
  DatabaseService databaseService = new DatabaseService();

  bool isLoading = true;





  @override
  void initState() {
    databaseService.getQuestionData(widget.quizId,RouterName.id.toString()).then((value) {
      questionSnaphot = value;
      _notAttempted = questionSnaphot.docs.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionSnaphot.docs.length;
      setState(() {});
      print("init don $total ${widget.quizId} ");
    });

    if(infoStream == null){
      infoStream = Stream<List<int>>.periodic(
          Duration(milliseconds: 100), (x){
        return [_correct, _incorrect] ;
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
    questionModel.quizWeekday =questionSnapshot.get("quizWeekday");


    RouterName.quizid =widget.quizId;

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


    questionModel.correctOption =questionSnapshot.get("option1");
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
            children:<Widget>[
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
                child: Center(child: Text("No Data"),),
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
          backgroundColor:AppColor.themeColor,
        onPressed: () {


          if(_notAttempted > 0) {
            showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    title: MediumText(
                      text: "Alert!",
                    ),
                    content: LightText(
                        text: "Please Answer All the Questions"),
                    actions: <Widget>[
                      FlatButton(
                        child: MediumText(
                          text: "Ok",
                          textColor: appColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
            );
          }
          if(_notAttempted == 0) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorsList(),
                ));          }
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
          builder: (context, snapshot){
            return snapshot.hasData ? Container(
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
            ) : Container();
          }
      ),
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
  bool attempted1 = false;
  bool attempted2 = false;
  bool attempted3 = false;
  bool attempted4 = false;
  bool attempted5 = false;
  bool attempted6 = false;
  bool attempted7 = false;
  bool attempted8 = false;




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
        question:widget.questionModel.question,
        answer: optionSelected,
        quizId: widget.questionModel.id));;
//    print(widget.questionModel.question);


    double  sumfortheDay = neck.toDouble()+blurred.toDouble()+dry.toDouble()+irritation.toDouble()+headaches.toDouble()+doublev.toDouble();
    double result = sumfortheDay/6;
    print(result.roundToDouble());


    String date = widget.questionModel.quizWeekday.toString();
   // String date = "Tuesday";

   //var futuredate =new DateFormat.yMMMMd('en_US') .format(new DateTime.now());
    var addDt = DateTime.now();
    RouterName.TimeOfQuiz = new DateFormat.yMMMMd('en_US').format(addDt.add(Duration(days: 2, hours: 1, minutes: 00)));
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


    String MaxBlurrdate = new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Maxneckdate = new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Maxdrydate = new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String MaxBirrdate = new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Maxheaddate = new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Maxdoubledate = new DateFormat.yMMMd().format(new DateTime.now()).toString();


    String MinBlurrdate = new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Minneckdate = new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Mindrydate = new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String MinBirrdate = new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Minheaddate = new DateFormat.yMMMd().format(new DateTime.now()).toString();
    String Mindoubledate = new DateFormat.yMMMd().format(new DateTime.now()).toString();


    if( RouterName.MaxBlurr == Null){
      RouterName.MaxBlurr = MaxBlurr;
      RouterName.MaxBlurrdate = MaxBlurrdate;
      RouterName.MinBlurrdate = MinBlurrdate;
      RouterName.MinBlurrdate = MinBlurrdate;


    }

    if( RouterName.Minneck == Null){
      RouterName.Maxneck = Maxneck;
      RouterName.Maxneckdate = Maxneckdate;
      RouterName.Minneck = Minneck;
      RouterName.Maxneckdate = Maxneckdate;

    }


    if( RouterName.Mindrydate == Null){
      RouterName.Maxdry = Maxdry;
      RouterName.Maxdrydate = Maxdrydate;
      RouterName.Mindry = Mindry;
      RouterName.Mindrydate = Mindrydate;
    }


    if( RouterName.MinBirr == Null){
      RouterName.MaxBirr = MaxBirr;
      RouterName.MaxBirrdate = MaxBirrdate;
      RouterName.MinBirr = MinBirr;
      RouterName.MinBirrdate = MinBirrdate;
    }

    if( RouterName.Mindouble == Null){
      RouterName.Maxdouble = Maxdouble;
      RouterName.Maxdoubledate = Maxdoubledate;
      RouterName.Mindouble = Mindouble;
      RouterName.Mindoubledate = Mindoubledate;;
    }
    if( RouterName.Minhead == Null) {
      RouterName.Maxhead = Maxhead;
      RouterName.Maxheaddate = Maxheaddate;
      RouterName.Minhead = Minhead;
      RouterName.Minheaddate = Minheaddate;
    }


    if(MaxBlurr > RouterName.MaxBlurr){

      RouterName.MaxBlurr = MaxBlurr;
      RouterName.MaxBlurrdate = MaxBlurrdate;

    }

    if(MinBlurr < RouterName.MinBlurr){
      RouterName.MinBlurr = MinBlurr;
      RouterName.MinBlurrdate = MinBlurrdate;
    }
    if(Maxneck > RouterName.Maxneck){
      RouterName.Maxneck = Maxneck;
      RouterName.Maxneckdate = Maxneckdate;
    }
    if(Minneck < RouterName.Minneck){
      RouterName.Minneck = Minneck;
      RouterName.Minneckdate = Minneckdate;

    }
    if(Maxdry > RouterName.Maxdry){
      RouterName.Maxdry = Maxdry;
      RouterName.Maxdrydate = Maxdrydate;

    }
    if(Mindry < RouterName.Mindry){
      RouterName.Mindry = Mindry;
      RouterName.Mindrydate = Mindrydate;

    }
    if(MaxBirr > RouterName.MaxBirr){
      RouterName.MaxBirr = MaxBirr;
      RouterName.MaxBirrdate = MaxBirrdate;

    }
    if(MinBirr < RouterName.MinBirr){
      RouterName.MinBirr = MinBirr;
      RouterName.MinBirrdate = MinBirrdate;

    }

    if(Maxhead > RouterName.Maxhead){
      RouterName.Maxhead = Maxhead;
      RouterName.Maxheaddate = Maxheaddate;

    }
    if(Minhead < RouterName.Minhead){
      RouterName.Minhead = Minhead;
      RouterName.Minheaddate = Minheaddate;

    }

    if(Maxdouble > RouterName.Maxdouble){
      RouterName.Maxdouble = Maxdouble;
      RouterName.Maxdoubledate = Maxdoubledate;

    }
    if(Mindouble < RouterName.Mindouble){
      RouterName.Mindouble = Mindouble;
      RouterName.Mindoubledate = Mindoubledate;

    }



    RouterName.blurredToday =blurred.toDouble();
    RouterName.neckToday =neck.toDouble();
    RouterName.dryToday=dry.toDouble();
    RouterName.irritationToday =irritation.toDouble();
    RouterName.headachesToday =headaches.toDouble();
    RouterName.doublevToday =doublev.toDouble();



    if(date == "Monday"){
      RouterName.blurredMe =blurred.toDouble();
      RouterName.neckMe =neck.toDouble();
      RouterName.dryMe =dry.toDouble();
      RouterName.irritationMe =irritation.toDouble();
      RouterName.headachesMe =headaches.toDouble();
      RouterName.doublevMe =doublev.toDouble();



      RouterName.value1 =result.roundToDouble();
    RouterName.dateOfQuiz = "Wednesday";
    }
    if(date== "Tuesday"){
    RouterName.value2 = result.roundToDouble();
    RouterName.dateOfQuiz = "Friday";

    RouterName.blurredT =blurred.toDouble();
    RouterName.neckT =neck.toDouble();
    RouterName.dryT =dry.toDouble();
    RouterName.irritationT =irritation.toDouble();
    RouterName.headachesT =headaches.toDouble();
    RouterName.doublevT =doublev.toDouble();

    }
    if(date == "Wednesday"){
    RouterName.value3 = result.roundToDouble();
    RouterName.dateOfQuiz = "Sunday";

    RouterName.blurredW =blurred.toDouble();
    RouterName.neckW =neck.toDouble();
    RouterName.dryW =dry.toDouble();
    RouterName.irritationW =irritation.toDouble();
    RouterName.headachesW =headaches.toDouble();
    RouterName.doublevW =doublev.toDouble();

    }
    if(date == "Thursday"){
    RouterName.value4 = result.roundToDouble();
    RouterName.dateOfQuiz = "Tuesday";

    RouterName.blurredTH =blurred.toDouble();
    RouterName.neckTH =neck.toDouble();
    RouterName.dryTH =dry.toDouble();
    RouterName.irritationTH =irritation.toDouble();
    RouterName.headachesTH =headaches.toDouble();
    RouterName.doublevTH =doublev.toDouble();

    }
    if(date == "Friday"){
    RouterName.value5 = result.roundToDouble();
    RouterName.dateOfQuiz = "Thursday";

    RouterName.blurredFR =blurred.toDouble();
    RouterName.neckFR =neck.toDouble();
    RouterName.dryFR =dry.toDouble();
    RouterName.irritationFR =irritation.toDouble();
    RouterName.headachesFR =headaches.toDouble();
    RouterName.doublevFR =doublev.toDouble();

    }
    if(date == "Saturday"){
    RouterName.value6 = result.roundToDouble();
    RouterName.dateOfQuiz = "Saturday";

    RouterName.blurredSA =blurred.toDouble();
    RouterName.neckSA =neck.toDouble();
    RouterName.drySA =dry.toDouble();
    RouterName.irritationSA =irritation.toDouble();
    RouterName.headachesSA =headaches.toDouble();
    RouterName.doublevSA =doublev.toDouble();

    }
    if(date == "Sunday"){
    RouterName.value7 = result.roundToDouble();
    RouterName.dateOfQuiz = "Tuesday";

    RouterName.blurredSU =blurred.toDouble();
    RouterName.neckSU =neck.toDouble();
    RouterName.drySU =dry.toDouble();
    RouterName.irritationSU =irritation.toDouble();
    RouterName.headachesSU =headaches.toDouble();
    RouterName.doublevSU =doublev.toDouble();

    }


    myMap.putIfAbsent(counter2, () => widget.questionModel.question.toString());
    myMap.putIfAbsent(counter2, () => optionSelected);
    counter2++;
    myMap.putIfAbsent(counter2, () => widget.questionModel.id.toString());
    counter2++;
    myMap.putIfAbsent(counter2, () => DateTime.now().toString());
    counter2++;

    QuizPlayTile.myMap = new Map();
    QuizPlayTile.myMap.addAll(myMap);



    print( QuizPlayTile.myMap);

    if(widget.questionModel.question == "Have you experienced neck or back pain today?"){




      if(optionSelected== "None"){
        neck= 0;

      }
      if(optionSelected== "Very Mild"){
        neck= 0;
        neck += (verym/counter).round();
      }

      if(optionSelected== "Mild"){
        neck= 0;
        neck += (mild/counter).round();

      }
      if(optionSelected== "Moderate"){
        neck= 0;
        neck += (moderate/counter).round();

      }
      if(optionSelected== "Severe"){
        neck= 0;
        neck += (severe/counter).round();

      }
    }

    if(widget.questionModel.question == "Have you experienced blurred vision today?"){

      if(optionSelected== "None"){
        blurred= 0;
        blurred += none;
      }
      if(optionSelected== "Very Mild"){
        blurred= 0;

        blurred += (verym/counter).round();

      }
      if(optionSelected== "Mild"){
        blurred= 0;
        blurred += (mild/counter).round();

      }
      if(optionSelected== "Moderate"){
        blurred= 0;
        blurred += (moderate/counter).round();

      }
      if(optionSelected== "Severe"){
        blurred= 0;
        blurred += (severe/counter).round();

      }
    }

    if(widget.questionModel.question == "Have you experienced dry or red eyes today? "){

      if(optionSelected== "None"){
        dry =0;
        dry += none;

      }
      if(optionSelected== "Very Mild"){
        dry =0;
        dry += (verym/counter).round();

      }
      if(optionSelected== "Mild"){
        dry =0;
        dry += (mild/counter).round();

      }
      if(optionSelected== "Moderate"){
        dry =0;
        dry += (moderate/counter).round();

      }
      if(optionSelected== "Severe"){
        dry =0;
        dry += (severe/counter).round();

      }
    }

    if(widget.questionModel.question== "Have you experience eye irritation today?"){

      if(optionSelected== "None"){
        irritation =0;
        irritation += none;
      }
      if(optionSelected== "Very Mild"){
        irritation =0;

        irritation += (verym/counter).round();
      }
      if(optionSelected== "Mild"){
        irritation =0;

        irritation += (mild/counter).round();
      }
      if(optionSelected== "Moderate"){
        irritation =0;

        irritation += (moderate/counter).round();
      }
      if(optionSelected== "Severe"){
        irritation =0;

        irritation += (severe/counter).round();
      }
    }

    if(widget.questionModel.question== "Have you experienced headaches today?"){

      if(optionSelected== "None"){
        headaches = 0;
        headaches += none;
      }
      if(optionSelected== "Very Mild"){
        headaches = 0;

        headaches += (verym/counter).round();
      }
      if(optionSelected== "Mild"){
        headaches = 0;

        headaches += (mild/counter).round();
      }
      if(optionSelected== "Moderate"){
        headaches = 0;

        headaches += (moderate/counter).round();
      }
      if(optionSelected== "Severe"){
        headaches = 0;

        headaches +=(severe/counter).round();
      }
    }

    if(widget.questionModel.question == "Have you experienced double vision today?"){

      if(optionSelected== "None"){
        doublev= 0;

        doublev += none;
      }
      if(optionSelected== "Very Mild"){
        doublev= 0;

        doublev += (verym/counter).round();
      }
      if(optionSelected== "Mild"){
        doublev= 0;

        doublev += (mild/counter).round();
      }
      if(optionSelected== "Moderate"){
        doublev= 0;

        doublev += (moderate/counter).round();
      }
      if(optionSelected== "Severe"){
        doublev= 0;

        doublev += (severe/counter).round();
      }
    }

// read from it
// read from it
    List<QuestionModel> bobs = people;
    QuestionModel m = new QuestionModel();
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
                margin: EdgeInsets.symmetric(
                    horizontal: 5.0
                ),
                child: Text(
                  "${widget.index + 1} ${")"} ${widget.questionModel.question}",
                  style:
                  TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
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
                  if (attempted1==false) {
                    _notAttempted = _notAttempted - 1;
                    attempted1 =true;
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
                  if (attempted2==false) {
                    _notAttempted = _notAttempted - 1;
                    attempted2 =true;
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
                  if (attempted3==false) {
                    _notAttempted = _notAttempted - 1;
                    attempted3 =true;
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
                  if (attempted4==false) {
                    _notAttempted = _notAttempted - 1;
                    attempted4 =true;
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
                  if (attempted6==false) {
                    _notAttempted = _notAttempted - 1;
                    attempted6 =true;
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
                  if (attempted7==false) {
                    _notAttempted = _notAttempted - 1;
                    attempted7 =true;
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
                  if (attempted8==false) {
                    _notAttempted = _notAttempted - 1;
                    attempted8 =true;
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

