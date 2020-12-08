import 'package:digital_eye_app/Screens/LoginPage/ComonLoginWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/generated/i18n.dart';
import 'package:digital_eye_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Screens/DoctorProfileScreen/DoctorProfileScreen.dart';

void main() => runApp(new ForgotPassword());

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

_setForGotPasswordView(){
  return new Container(
    padding: new EdgeInsets.all(20),
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: new Column(
      children: <Widget>[
        new Text(AppTranslations.of(context).text(AppTitle.loginForgetPass),
        textDirection: SharedManager.shared.direction,
        style: new TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w500
        ),
        ),
        SizedBox(height: 5,),
        new Text(AppTranslations.of(context).text(AppTitle.forgetPassStr),
        textAlign: TextAlign.center,
        textDirection: SharedManager.shared.direction,
        style: new TextStyle(
          color: Colors.black54,
          fontSize: 16,
          fontWeight: FontWeight.w500
        ),
        ),
        SizedBox(height: 35,),
        setTextFiels(AppTranslations.of(context).text(AppTitle.forgotPassEmail),Icons.email),
        SizedBox(height: 25,),
        new Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: new Material(
                color: AppColor.themeColor,
                borderRadius: BorderRadius.circular(22.5),
                elevation: 5.0,
                child: new Center(
                  child: new Text(AppTranslations.of(context).text(AppTitle.forgotPassSendEmail),
                  textDirection: SharedManager.shared.direction,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                  ),
                ),
              ),
            ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home:Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios,color:AppColor.themeColor),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: new Container(
          color: Colors.white,
          child: _setForGotPasswordView()
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