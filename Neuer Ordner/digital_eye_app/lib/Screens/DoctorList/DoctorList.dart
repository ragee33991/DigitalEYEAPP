import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Screens/DoctorProfileScreen/DoctorProfileScreen.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/pages/HomePage.dart';
import 'package:digital_eye_app/pages/quiz_play.dart';
import 'package:digital_eye_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



void main() => runApp(new DoctorList());

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
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
                    return QuizTile(
                      noOfQuestions: snapshot.data.documents.length,
                      imageUrl:
                      snapshot.data.documents[index].data['quizImgUrl'] ??
                          "https://i.pinimg.com/564x/a6/22/55/a6225503c05cebb2b3763ab9583ecdf5.jpg",
                      title:
                      snapshot.data.documents[index].data['quizTitle'],
                      description:
                      snapshot.data.documents[index].data['quizDesc'],
                      quizId: snapshot.data.documents[index].data["quizId"],
                    );
                  });
            },
          )
        ],

      ),

    );
  }

  AppTranslationsDelegate _newLocaleDelegate;
  @override
  void initState() {
    databaseService.getQuizData( RouterName.id.toString() ).then((value) {

      setState(() {
        quizStream = value;
      });
    });
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale:null);
    application.onLocaleChanged = onLocaleChange;
  }



//start Questionare

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        body: new Container(
          color: Colors.grey[100],
          child: new ListView.builder(
            itemCount: listDoctor.length,
            itemBuilder: (context,index){
              return new InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DoctorProfileScreen(
                    doctorInfo: listDoctor[index],
                  )));
                },
                child: setWidgetsForList(listDoctor[index].image,listDoctor[index].name,listDoctor[index].role,listDoctor[index].distance,listDoctor[index].review, false),
              );
            },
          )
        ),
       appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle("Questionnaire",Colors.white),
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
      routes: {
        '/DoctorList': (BuildContext context) => DoctorList()
      },
      theme: SharedManager.shared.getThemeType(),
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
    );
  }
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
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => QuizPlay(
                quizId,firebaseId
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom:8),
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                color: Colors.black26,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        description,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

