import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';

import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/models/question_model.dart';
import 'package:digital_eye_app/pages/result.dart';
import 'package:digital_eye_app/services/database.dart';
import 'package:digital_eye_app/widgets/quiz_play_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() => runApp(new BlogDetails());
class BlogDetails extends StatefulWidget {

  final  title,quizId;

  BlogDetails({this.title,this.quizId});

  @override
  _BlogDetailsState createState() => _BlogDetailsState();
}



int total = 0;
Stream infoStream;

class _BlogDetailsState extends State<BlogDetails> {
  QuerySnapshot questionSnaphot;
  DatabaseService databaseService = new DatabaseService();
  bool isLoading = true;

  _setImageBarView() {
    return new Container(
      height: MediaQuery
          .of(context)
          .size
          .width - 100,
      color: Colors.white,
      child: new Stack(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: new Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImage.blogFoodImage),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: new Container(
              height: 30,
              width: 30,
              child: new Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 40,
            child: new Container(
              height: 45,
              width: 120,
              child: new Material(
                elevation: 2.0,
                borderRadius: new BorderRadius.circular(22.5),
                color: AppColor.themeColor,
                child: new Center(
                  child: setCommonText(
                      widget.title, Colors.white, 18.0, FontWeight.w500, 1),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  _setBlogDescriptionView({QuestionModel questionModel, int index}) {
    return new Container(
      padding: new EdgeInsets.all(15),
      child:isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),)
          :  new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          setCommonText(
              questionModel.question.toString(),Colors.black54,22.0,FontWeight.w500,2),
          SizedBox(height: 8,),
          SizedBox(height: 15,),
          setCommonText(
              questionModel.answer.toString(),Colors.grey,16.0,FontWeight.w500,2),
        ],
      ),
    );
  }


  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    databaseService.getQuestionData(widget.quizId, RouterName.id.toString())
        .then((value) {
      questionSnaphot = value;
      isLoading = false;
      total = questionSnaphot.documents.length;
      setState(() {
        SharedManager.shared.isOnboarding = true;
        _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
        application.onLocaleChanged = onLocaleChange;
      });
      print("init don $total ${widget.quizId} ");
    });

    super.initState();
  }

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.get('question');
    questionModel.id = questionSnapshot.get("id");
    questionModel.quizId = widget.quizId;
    questionModel.quizWeekday = questionSnapshot.get('quizWeekday');
    questionModel.answer = questionSnapshot.get("answer");
    print(questionModel.answer.toString());
    RouterName.quizid = widget.quizId;
    return questionModel;
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return  isLoading ? Container(
      child: Center(child: CircularProgressIndicator()),)
        :MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        _newLocaleDelegate,
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        SharedManager.shared.language
      ],
      home: Scaffold(
        appBar: EmptyAppBar(),
        body: ListView(
          children: <Widget>[
            questionSnaphot.documents == null
                ? Container(
              child: Center(child: Text("No Data"),),
            ) :
            _setImageBarView(),
            Container(
              child: ListView.builder(
                  itemCount: questionSnaphot.documents.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _setBlogDescriptionView(
                      questionModel: getQuestionModelFromDatasnapshot(
                          questionSnaphot.documents[index]),
                      index: index,
                    );
                  }),
            ),

          ],
        ),

      ),

      theme: SharedManager.shared.getThemeType(),
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}

class  EmptyAppBar  extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  @override
  Size get preferredSize => Size(0.0,0.0);
}