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
import 'package:intl/intl.dart';

import 'CommonBLogs.dart';


void main()=>runApp(new LifeStyle());


class LifeStyle extends StatefulWidget {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
  @override
  _LifeStyleState createState() => _LifeStyleState();
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




class _LifeStyleState extends State<LifeStyle> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();


   quizList() {
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
                    snapshot.data.documents[index].data("quizId");
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
        body: StreamBuilder(
            stream: quizStream,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  :  Container(
                color: Colors.grey[200],
                child: new GridView.count(
                  crossAxisCount: 1,
                  children: List<Widget>.generate(snapshot.data.documents.length,(index){
                    var id =snapshot.data.documents[index].get("quizId").toString();
                    var ind =index +1;
                    var date = snapshot
                        .data.documents[index].get('quizTitle');
                    var moonLanding = DateTime.parse(date);  // 8:18pm

                   // DateTime now = DateTime(date);
                  //  final DateTime now = DateTime(int.tryParse(date));
                    final DateFormat formatter = DateFormat('yyyy-MM-dd');
                  //  final String formatted = formatter.format(now);
                     String date2 = new DateFormat.yMMMd().add_jm().format(moonLanding).toString();
                    return new Hero(
                      tag: index,
                      child: new InkWell(
                        onTap: (){
                          Navigator.of(context,rootNavigator: false).push(MaterialPageRoute(builder: (context)=>BlogDetails(
                            title: "Questionnaire",quizId : id,
                          )));
                        },
                        child: setCommonBlog(AppImage.blogFoodImage, "Questionnaire " + ind.toString() , date2, width, width),
                      ),
                    );
                  }),
                )
            );
          }
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