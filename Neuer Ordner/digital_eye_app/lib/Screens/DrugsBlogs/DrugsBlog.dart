import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_eye_app/Screens/BlogDetails/BlogDetails.dart';
import 'package:digital_eye_app/Screens/DoctorList/DoctorList.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/models/question_model.dart';
import 'package:digital_eye_app/pages/quiz_play.dart';
import 'package:digital_eye_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Screens/DoctorProfileScreen/DoctorProfileScreen.dart';


import '../../globals.dart';
import 'CommonBLogs.dart';
import 'movie.dart';

void main() => runApp(new DrugsBlog(firebaseId));

class DrugsBlog extends StatefulWidget {

  final String firebaseId;

  DrugsBlog(this.firebaseId);

  @override
  _DrugsBlogState createState() => _DrugsBlogState();
}

class _DrugsBlogState extends State<DrugsBlog> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
  final List<Movie> movies =[];
  static Future<List<QuestionModel>> _getEventsFromFirestore() async {
    CollectionReference ref = Firestore.instance
        .collection("users")
        .document(RouterName.id.toString())
        .collection("Quiz")
        .document("82190J96n6423250")
        .collection("QNA");

    QuerySnapshot eventsQuery = await ref
        .where("option1", isEqualTo: "None")
        .getDocuments();

    HashMap<String, QuestionModel> eventsHashMap = new HashMap<
        String,
        QuestionModel>();

    eventsQuery.documents.forEach((document) {
      eventsHashMap.putIfAbsent(document['id'], () =>
      new QuestionModel(
          question: document['name'],
          answer: document['answer'],
          quizId: document['quizId']));
    });
    print(eventsHashMap.values.toList());

    return eventsHashMap.values.toList();

  }

  List<Movie> customers = [];


  Widget quizList2() {
    var itemID;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder(

          stream: quizStream,
                  builder: (context, snapshot) {
                    return snapshot.data == null
                        ? Container()
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                        Movie m = new Movie(
                            title: snapshot
                                .data.documents[index].data['quizTitle'],
                            genre: snapshot
                                .data.documents[index].data['quizDesc'],
                            year: snapshot.data.documents[index]
                                .data["quizId"],
                            imageUrl: "https://i.pinimg.com/564x/a6/22/55/a6225503c05cebb2b3763ab9583ecdf5.jpg");
                         itemID = snapshot.data.documents[index].data["quizId"];
                        String question =itemID.data.documents[index];
                                  print(question);
                            /*
                         String head;
                         String irr;
                         String red;
                         String blurr;
                         String double;
                         String neck;

                        if(result.data["question"] == "Have you experienced neck or back pain today?"){


                        }

                        if(result.data["question"] == "Have you experienced blurred vision today?"){
                        }

                        if(result.data["question"] == "Have you experienced dry or red eyes today? "){
                        }

                        if(result.data["question"] == "Have you experience eye irritation today?"){

                        }

                        if(result.data["question"] == "Have you experienced headaches today?"){

                        }

                        if(result.data["question"] == "Have you experienced double vision today?"){

                        }

                        var myMap = {
                          "date": "JoeDoe",
                          "tvTime": "admin123",
                          "Have you experienced headaches today? ": "John Doe",
                          "Have you experience eye irritation today? ": "John Doe",
                          "Have you experienced dry or red eyes today? ": "John Doe",
                          "Have you experienced blurred vision today? ": "John Doe",
                          "Have you experienced double vision today? ": "John Doe",
                          "Have you experienced neck or back pain today? ": "John Doe",
                        };


                        final list = snapshot.data.documents;
                        */

                        movies.add(m);
                        print(movies);
                        return  Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 7.0, vertical: 15.0),
                      );
                     },
                  );
                }
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Text(
                  'Swipe right to dismiss items from below list',
                  textScaleFactor: 1.0,
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 300.0,
                child: movies.length > 0
                    ? ListView.builder(
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (DismissDirection direction) {
                              setState(() {
                                movies.removeAt(index);
                                databaseService.removeQuiz(itemID,RouterName.id.toString());

                              });
                            },
                            secondaryBackground: Container(
                              color: Colors.red,
                              child: Center(
                                child: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            background: Container(),
                            child: MovieCard(
                              movie: movies[index],
                            ),
                          );
                        },
                      )
                    : Container(
                        child: Text('No items'),
                      ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget quizList22() {
    Column(
      children: [
        StreamBuilder(
            stream: quizStream,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                           Movie m = new Movie(
                          title:  snapshot
                              .data.documents[index].data['quizTitle'],
                            genre: snapshot
                                .data.documents[index].data['quizDesc'],
                            year:  snapshot.data.documents[index].data["quizId"],
                            imageUrl:  "https://i.pinimg.com/564x/a6/22/55/a6225503c05cebb2b3763ab9583ecdf5.jpg");

                        final itemID =
                            snapshot.data.documents[index].documentID;
                        final list = snapshot.data.documents;
                           movies.add(m);
                           print("myId " +  itemID);
                        return Column(
                          children: [
                            QuizTile(
                              noOfQuestions: snapshot.data.documents.length,
                              imageUrl: snapshot.data.documents[index]
                                      .data['quizImgUrl'] ??
                                  "https://i.pinimg.com/564x/a6/22/55/a6225503c05cebb2b3763ab9583ecdf5.jpg",
                              title: snapshot
                                  .data.documents[index].data['quizTitle'],
                              description: snapshot
                                  .data.documents[index].data['quizDesc'],
                              quizId:
                                  snapshot.data.documents[index].data["quizId"],
                            ),
                          ],
                        );
                      },
                    );
            }),
      ],
    );
  }

  setCommonBlog1(String imgUrl, String title, String description, double width,
      double height, Widget h) {
    return new Container(
      height: height,
      width: width,
      padding: new EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 0),
      child: new Material(
          elevation: 2.0,
          borderRadius: BorderRadius.circular(5),
          // color: Colors.white,
          child: new Padding(
            padding: new EdgeInsets.all(12),
            child: new Column(
              children: <Widget>[
                StreamBuilder(
                  stream: quizStream,
                  builder: (context, snapshot) {
                    return snapshot.data == null
                        ? Container()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              return QuizTile(
                                noOfQuestions: snapshot.data.documents.length,
                                imageUrl: snapshot.data.documents[index]
                                        .data['quizImgUrl'] ??
                                    "https://i.pinimg.com/564x/a6/22/55/a6225503c05cebb2b3763ab9583ecdf5.jpg",
                                title: snapshot
                                    .data.documents[index].data['quizTitle'],
                                description: snapshot
                                    .data.documents[index].data['quizDesc'],
                                quizId: snapshot
                                    .data.documents[index].data["quizId"],
                              );
                            });
                  },
                ),
                new Expanded(
                  flex: 3,
                  child: new Container(
                    // color: Colors.red,
                    decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(8),
                        image: DecorationImage(
                            image: AssetImage(imgUrl), fit: BoxFit.cover)),
                  ),
                ),
                new Expanded(
                  child: new Container(
                    // color: Colors.blue,
                    padding: new EdgeInsets.only(top: 10),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        setCommonText(
                            title, Colors.black, 17.0, FontWeight.w500, 1),
                        SizedBox(
                          height: 5,
                        ),
                        setCommonText(
                            description, Colors.grey, 16.0, FontWeight.w500, 2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    databaseService.getQuizData(RouterName.id.toString()).then((value) {
      setState(() {
        quizStream = value;
      });
    });
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    final width = MediaQuery.of(context).size.width;
    var dummytext = "30.09.2020";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        child: new Scaffold(
          body: quizList2(),
        ),
      ),
      theme: SharedManager.shared.getThemeType(),
      localizationsDelegates: [
        _newLocaleDelegate,
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [SharedManager.shared.language],
    );
  }

  //This is for localization
  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}

class QuizTile extends StatelessWidget {
  final String imageUrl, title, quizId, description,firebaseId;
  final int noOfQuestions;

  QuizTile(
      {@required this.title,
      this.imageUrl,
      @required this.description,
      @required this.quizId,
      @required this.noOfQuestions, @required this.firebaseId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QuizPlay(quizId,RouterName.id.toString())));
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
              ),
              title: Text(title),
              subtitle: Text(quizId),
              trailing: Text(description),
            ),
          ],
        ),
      ),
    );
  }
}

class Movie {
  final String title;
  final String genre;
  final String year;
  final String imageUrl;

  Movie({this.genre, this.title, this.year, this.imageUrl});
}
