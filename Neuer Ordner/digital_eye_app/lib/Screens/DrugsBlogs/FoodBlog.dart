import 'package:digital_eye_app/Screens/BlogDetails/BlogDetails.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
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

import 'CommonBLogs.dart';


void main()=> runApp(new FoodBlog());


class FoodBlog extends StatefulWidget {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
  @override
  _FoodBlogState createState() => _FoodBlogState();
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




class _FoodBlogState extends State<FoodBlog> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();


  Widget quizList() {
    return Container(
      child: Column(
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
                    final item = snapshot.data.documents[index];
                    final itemID =
                    snapshot.data.documents[index].get("quizId");
                    print("hello my foodblog" + snapshot.data.documents.length.toString());
                    final list = snapshot.data.documents;
                    return Column(
                      children: [
                        QuizTile(
                          noOfQuestions: snapshot.data.documents.length,
                          imageUrl: "https://i.pinimg.com/564x/a6/22/55/a6225503c05cebb2b3763ab9583ecdf5.jpg",
                          title: snapshot
                              .data.documents[index].get('quizTitle'),
                          description: snapshot
                              .data.documents[index].get('quizDesc'),
                          quizId:
                          snapshot.data.documents[index].get("quizId"),
                        ),
                      ],
                    );
                  });
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    final width = MediaQuery.of(context).size.width;
    var dummytext = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[

            quizList(),
          ],
        )
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

  //This is for localization
  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }




}