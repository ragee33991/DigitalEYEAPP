import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_eye_app/Screens/LoginPage/ComonLoginWidgets.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/Screens/create_account/create_account_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:random_string/random_string.dart';

import '../../globals.dart';


void mian() => runApp(new SignupPage());

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  bool isLoading = false;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final userName = TextEditingController();
  final password =TextEditingController();
  String uid = randomAlphaNumeric(16);
  String usern = randomAlphaNumeric(6);


  callApi() async {
    print("hello");

    try {
        setState(() {
          isLoading = true;
        });

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: usern + "@gmail.com",
        password: usern,

      );

        setState(() {
          isLoading = false;
        });
        RouterName.id = uid;
        RouterName.usern = usern;

        Navigator.of(context).pushReplacementNamed(RouterName.CREATE_ACCOUNT);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    print('object');

  }

  // Alert Box
  void _showAlert(String value, String userName, String password) {
    showDialog(
      builder: (context) => AlertDialog(
        title: MediumText(text: "Alert!"),
        content: value == ""
            ? LightText(text: "UserName: $userName, Password: $userName")
            : LightText(
          text: value,
        ),
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
  _setSignUPView(){
  return new Container(
    padding: new EdgeInsets.all(20),
    width: MediaQuery.of(context).size.width,
    // color: Colors.red,
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(AppImage.appLogo)
            )
          ),
        ),
        SizedBox(height: 50,),
       // setTextFiels1(AppTranslations.of(context).text(AppTitle.loginUserName),Icons.person,uid),
        SizedBox(height: 25,),


        new InkWell(
          onTap: (){
            callApi();
          },
                child: new Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: new Material(
                  color: AppColor.themeColor,
                  borderRadius: BorderRadius.circular(22.5),
                  elevation: 5.0,
                  child: new Center(
                    child: new Text(AppTranslations.of(context).text(AppTitle.loginSignUp),
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
        ),
            SizedBox(height: 25,),

            SizedBox(height: 100,),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(AppTranslations.of(context).text(AppTitle.signUpNote),
                textDirection: SharedManager.shared.direction,
                style: new TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
                ),
                SizedBox(width: 2,),
                InkWell(
                  child: new Text(AppTranslations.of(context).text(AppTitle.loginSignIn),
                  textDirection: SharedManager.shared.direction,
                  style: new TextStyle(
                    color: AppColor.themeColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                  ),
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home:isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),)
          : new Scaffold(
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios,color:AppColor.themeColor),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              _setSignUPView()
            ],
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