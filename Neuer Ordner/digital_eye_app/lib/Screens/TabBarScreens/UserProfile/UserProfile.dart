import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Screens/AddWeightScreen/AddWeightScreen.dart';
import 'package:digital_eye_app/Screens/DoctorList/DoctorList.dart';
import 'package:digital_eye_app/Screens/GoalSettingsScreen/GoalSettingsScreen.dart';
import 'package:digital_eye_app/Screens/OrderList.dart/OrderList.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/pages/result.dart';
import 'package:digital_eye_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../main.dart';




class UserProfile extends StatefulWidget {


  @override
  _UserProfileState createState() => _UserProfileState();
}

bool isLoading = true;

String question;
String answer;
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
final firestoreInstance = Firestore.instance;


_setUserQuestions(quizId) async {
 await  firestoreInstance
      .collection("users")
      .doc(RouterName.id)
      .collection("Quiz")
      .doc(quizId)
      .collection("QNA").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
     // print(result.data["question"] + " "+  result.data["answer"]);

      if(result.get("question") == "Have you experienced neck or back pain today?"){
      //  print("hello");
        if(result.get("answer")== "None"){
          neck += none;

        }
        if(result.get("answer")== "Very Mild"){
          neck += (verym/counter).round();
        }

        if(result.get("answer")== "Mild"){
          neck += (mild/counter).round();

        }
        if(result.get("answer")== "Moderate"){
          neck += (moderate/counter).round();

        }
        if(result.get("answer")== "Severe"){
          neck += (severe/counter).round();

        }
      }

      if(result.get("question") == "Have you experienced blurred vision today?"){

        if(result.get("answer")== "None"){
          blurred += none;
        }
        if(result.get("answer")== "Very Mild"){
          blurred += (verym/counter).round();

        }
        if(result.get("answer")== "Mild"){
          blurred += (mild/counter).round();

        }
        if(result.get("answer")== "Moderate"){
          blurred += (moderate/counter).round();

        }
        if(result.get("answer")== "Severe"){
          blurred += (severe/counter).round();

        }
      }

      if(result.get("question") == "Have you experienced dry or red eyes today? "){

        if(result.get("answer")== "None"){
          dry += none;
        }
        if(result.get("answer")== "Very Mild"){
          dry += (verym/counter).round();
        }
        if(result.get("answer")== "Mild"){
          dry += (mild/counter).round();
        }
        if(result.get("answer")== "Moderate"){
          dry += (moderate/counter).round();
        }
        if(result.get("answer")== "Severe"){
          dry += (severe/counter).round();
        }
      }

      if(result.get("question") == "Have you experience eye irritation today?"){

        if(result.get("answer")== "None"){
          irritation += none;
        }
        if(result.get("answer")== "Very Mild"){
          irritation += (verym/counter).round();
        }
        if(result.get("answer")== "Mild"){
          irritation += (mild/counter).round();
        }
        if(result.get("answer")== "Moderate"){
          irritation += (moderate/counter).round();
        }
        if(result.get("answer")== "Severe"){
          irritation += (severe/counter).round();
        }
      }

      if(result.get("question") == "Have you experienced headaches today?"){

        if(result.get("answer")== "None"){
          headaches += none;
        }
        if(result.get("answer")== "Very Mild"){
          headaches += (verym/counter).round();
        }
        if(result.get("answer")== "Mild"){
          headaches += (mild/counter).round();
        }
        if(result.get("answer")== "Moderate"){
          headaches += (moderate/counter).round();
        }
        if(result.get("answer")== "Severe"){
          headaches +=(severe/counter).round();
        }
      }

      if(result.get("question") == "Have you experienced double vision today?"){

        if(result.get("answer")== "None"){
          doublev += none;
        }
        if(result.get("answer")== "Very Mild"){
          doublev += (verym/counter).round();
        }
        if(result.get("answer")== "Mild"){
          doublev += (mild/counter).round();
        }
        if(result.get("answer")== "Moderate"){
          doublev += (moderate/counter).round();
        }
        if(result.get("answer")== "Severe"){
          doublev += (severe/counter).round();
        }
      }

      RouterName.neck= neck;
      RouterName.blurred =blurred;
      RouterName.dry = dry;
      RouterName.irritation = irritation;
      RouterName.headaches = headaches;
      RouterName.doublev = doublev;

      // print(result.data.values.toList());
    });
  });
}





class _UserProfileState extends State<UserProfile> {

  List profileList = [];




  final List<String> languagesList = application.supportedLanguages;
  final List<String> languageCodesList = application.supportedLanguagesCodes;


  _setUserProfiel()  {


    return new Container(
      height: 180,
      // color: Colors.red,
      child: new Column(
        children: <Widget>[
          new Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(AppImage.doctorProfile)
                )
            ),
          ),
          SizedBox(height: 15,),
          setCommonText(PersonalInfo.name, Colors.black, 18.0, FontWeight.w500, 1),
          setCommonText(PersonalInfo.email, Colors.grey, 17.0, FontWeight.w400, 1)
        ],

      ),
    );
  }

  _setCommonViewForGoal(){
    return new Container(
      height: MediaQuery.of(context).size.width/1.4,
      padding: new EdgeInsets.all(15),
      child: isLoading
          ? Container(
        child: Center(child: CircularProgressIndicator()),
      ):
      new Material(
        color: Colors.white,
        elevation: 2.0,
        borderRadius: BorderRadius.circular(5),
        child: new Padding(
            padding: new EdgeInsets.all(10),
            child: new Column(
              children: <Widget>[
                new Expanded(
                  child: new Container(
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription("Neckpain",RouterName.neck.toString()),
                          ),
                        ),
                        new Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(width: 5,),
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription("Blurred Vision",RouterName.blurred.toString()),
                          ),
                        ),
                        new Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(width: 5,),
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription("Dry Eyes", RouterName.dry.toString()),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                new Container(
                  height: 2,
                  color: Colors.grey[300],
                ),
                new Expanded(
                  child: new Container(
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription("Eye Irritation",RouterName.irritation.toString()),
                          ),
                        ),
                        new Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(width: 5,),
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription("Headaches", RouterName.headaches.toString()),
                          ),
                        ),
                        new Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(width: 5,),
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription("Double Vision",RouterName.doublev.toString()),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }


  _setCommonViewForDescription(String title,String bpm){
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FittedBox(
            child: setCommonText(title, AppColor.themeColor, 18.0, FontWeight.w700, 1),
          ),
          SizedBox(height:3),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              setCommonText(bpm, Colors.black, 18.0, FontWeight.w500, 1),
              SizedBox(width: 3,),
              setCommonText("%", Colors.grey, 16.0, FontWeight.w600, 1),
            ],
          )
        ],
      ),
    );
  }

  _setBottomView(){
    // final Map<dynamic, dynamic> languagesMap = {
    //   languagesList[0]: languageCodesList[0],
    //   languagesList[1]: languageCodesList[1]
    // };

    return new Container(
      height:profileList.length * 80.0,
      color: Colors.grey[200],
      padding: new EdgeInsets.all(15),
      child: new GridView.count(
        crossAxisCount: 1,
        childAspectRatio: 5.5,
        physics: NeverScrollableScrollPhysics(),
        children: List<Widget>.generate(profileList.length,(index){
          return new Container(
            height: 70,
            padding: new EdgeInsets.only(top:5,bottom: 5),
            child: new InkWell(
              onTap: (){
                if(index == 0){
                  Navigator.of(context,rootNavigator: false).push(MaterialPageRoute(builder: (context)=>GoalSettingsScreen(dry.toString())));
                }

                else if(index ==1){
                  Navigator.of(context,rootNavigator: false).push(MaterialPageRoute(builder: (context)=>AddWeightScreen(RouterName.id.toString())));
                }

                else{
                  SharedManager.shared.currentIndex = 0;
                  Navigator.of(context,rootNavigator: false).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MyHomePage()),ModalRoute.withName('/MyHomePage'));
                  // Navigator.of(context,rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()),ModalRoute.withName('/login'));
                }
              },
              child: new Material(
                elevation: 2.0,
                borderRadius: new BorderRadius.circular(5),
                child: new Padding(
                  padding: new EdgeInsets.only(left: 15,right: 15),
                  child: new Row(
                    children: <Widget>[
                      profileList[index]['icon'],
                      SizedBox(width: 12,),
                      new Container(height: 30,color: Colors.grey[300],width: 2,),
                      SizedBox(width: 12,),
                      new Expanded(
                          child: setCommonText(profileList[index]['title'], Colors.grey, 16.0, FontWeight.w500,1)
                      ),
                      SizedBox(width: 12,),
                      new Icon(Icons.arrow_forward_ios,size: 18,color:AppColor.themeColor),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }


  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    neck = 0;
    blurred =0;
    dry = 0;
    irritation = 0;
    headaches = 0;
    doublev = 0;
    none = 0;
    counter = 0;

    firestoreInstance.collection("users").doc(RouterName.id)
        .collection("Quiz").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        _setUserQuestions(result.get("quizId"));
        counter++;
        isLoading = false;
        setState(() {});


        // print(result.data["quizId"]);
        // print(result.data["quizId"]);

        // print(result.data.values.toList());

      });
    });



    super.initState();
    isLoading = false;


    SharedManager.shared.isOnboarding = true;
    _newLocaleDelegate = AppTranslationsDelegate(newLocale:null);
    application.onLocaleChanged = onLocaleChange;
  }


  @override
  Widget build(BuildContext context) {

    this.profileList = [
      {"title":AppTranslations.of(context).text(AppTitle.profileGoalSetting),"icon":Icon(Icons.local_hospital,color: AppColor.themeColor,size: 18,)},
      {"title":AppTranslations.of(context).text(AppTitle.profileWeight),"icon":Icon(Icons.settings,color: AppColor.themeColor,size: 18,)},
      {"title":AppTranslations.of(context).text(AppTitle.drawerLogout),"icon":Icon(Icons.settings_power,color: AppColor.themeColor,size: 18,)},
    ];

    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.drawerProfile),Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          actions: setCommonCartNitificationView(context),
        ),
        drawer: SharedManager.shared.setDrawer(context,PersonalInfo.name,PersonalInfo.email),
          body: isLoading
      ? Container(
      child: Center(child: CircularProgressIndicator()),
    ) :  new Container(
            color: Colors.grey[200],
            child: new ListView(
              children: <Widget>[
                SizedBox(height: 40,),

                SizedBox(height: 20,),
                _setCommonViewForGoal(),
                SizedBox(height: 80,),

                _setBottomView()
              ],
            )
        ),
      ),
      routes: {
        '/UserProfile': (BuildContext context) => UserProfile()
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
  //This is for localization
  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}