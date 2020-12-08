import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';


void main () => runApp(new PersonalInformations());


class PersonalInformations extends StatefulWidget {
  @override
  _PersonalInformationsState createState() => _PersonalInformationsState();
}

class _PersonalInformationsState extends State<PersonalInformations> {

  _setAboutWidgets(){
    return new Container(
      // height: 200,
      padding: new EdgeInsets.all(20),
      child: new Material(
        color: Colors.white,
        elevation: 3.0,
        borderRadius: BorderRadius.circular(8),
        child: new Padding(
          padding: EdgeInsets.all(10),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              setCommonText(AppTranslations.of(context).text(AppTitle.about), Colors.black, 16.0, FontWeight.w600, 1),
              SizedBox(height: 5,),
              setCommonText("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              Colors.grey, 15.0, FontWeight.w400, 10)
            ],
          ),
        ),
      ),
    );
  }

_setPersonalInformationView(){
  return new Container(
    // color: Colors.red,
    padding: new EdgeInsets.all(20),
    child: new Column(
      children: <Widget>[
        _setCommonWidget(AppTranslations.of(context).text(AppTitle.addressandTiming), "D Block,15th Avenue,3rd floor", "09.00AM - 17.00 Mon to Fri"),
        SizedBox(height: 20,),
        _setCommonWidget(AppTranslations.of(context).text(AppTitle.phone), "+ 123 456 789", "+ 098 876 543"),
        SizedBox(height: 20,),
        _setCommonWidget(AppTranslations.of(context).text(AppTitle.degree), "MBBS", "MD"),
      ],
    ),
  );
}

_setCommonWidget(String title,String subStr1,String subStr2){
  return Container(
    width: MediaQuery.of(context).size.width,
    child: new Material(
      color: Colors.white,
          elevation: 3.0,
          borderRadius: BorderRadius.circular(8),
          child: new Padding(
            padding: new EdgeInsets.all(8),
              child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                setCommonText(title, Colors.black, 17.0, FontWeight.w600, 1),
                SizedBox(height: 8,),
                setCommonText(subStr1, Colors.grey, 15.0, FontWeight.w500, 5),
                SizedBox(height: 5,),
                setCommonText(subStr2, Colors.grey, 15.0, FontWeight.w500, 5),
              ],
            ),
          ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: new Scaffold(
        body: new Container(
          color: Colors.grey[100],
          child: new ListView(
            children: <Widget>[
              _setAboutWidgets(),
              _setPersonalInformationView(),
            ],
          ),
        ),
        appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.informations),Colors.white),
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
}