import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Screens/AddWeightScreen/AddWeightScreen.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../main.dart';




class UserProfile extends StatefulWidget {


  @override
  _UserProfileState createState() => _UserProfileState();
}

bool isLoading = true;



class _UserProfileState extends State<UserProfile> {
  DatabaseService databaseService = new DatabaseService();


  List profileList = [];




  final List<String> languagesList = application.supportedLanguages;
  final List<String> languageCodesList = application.supportedLanguagesCodes;
  String neckpain = "";
  String blurred = "";
  String dryeyes = "";
  String irritation = "";
  String headache = "";
  String doublevision = "";




  _setCommonViewForGoal() {
    getData();




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
                            child: _setCommonViewForDescription("Neckpain",neckpain),
                          ),
                        ),
                        new Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(width: 5,),
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription("Blurred Vision",blurred),
                          ),
                        ),
                        new Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(width: 5,),
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription("Dry Eyes",dryeyes),
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
                            child: _setCommonViewForDescription("Eye Irritation",irritation),
                          ),
                        ),
                        new Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(width: 5,),
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription("Headaches", headache),
                          ),
                        ),
                        new Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(width: 5,),
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription("Double Vision",doublevision),
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


                if(index ==0){
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
  initState()  {

    super.initState();
    isLoading = false;


    SharedManager.shared.isOnboarding = true;
    _newLocaleDelegate = AppTranslationsDelegate(newLocale:null);
    application.onLocaleChanged = onLocaleChange;
  }


  getData() async {
    DatabaseService databaseService = DatabaseService();
    double head = await databaseService.getIntFromSharedPref("head");
    double blurredq = await databaseService.getIntFromSharedPref("blurred");
    double doubleh = await databaseService.getIntFromSharedPref("double");
    double dry = await databaseService.getIntFromSharedPref("dry");
    double eye = await databaseService.getIntFromSharedPref("eye");
    double pain = await databaseService.getIntFromSharedPref("pain");

    setState(() {
      neckpain =pain.toString();
      blurred = blurredq.toString();
      dryeyes = dry.toString();
      irritation =eye.toString();
      headache = head.toString();
      doublevision = doubleh.toString();

    });
  }


  @override
  Widget build(BuildContext context) {

    this.profileList = [
     // {"title":AppTranslations.of(context).text(AppTitle.profileGoalSetting),"icon":Icon(Icons.local_hospital,color: AppColor.themeColor,size: 18,)},
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