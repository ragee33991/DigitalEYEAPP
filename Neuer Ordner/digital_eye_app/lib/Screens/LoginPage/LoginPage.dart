import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_eye_app/Constant/sharedpreference_page.dart';
import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Screens/ForgotPassword/ForgotPassword.dart';
import 'package:digital_eye_app/Screens/SignupPage/SignupPage.dart';
import 'package:digital_eye_app/Screens/TabBarScreens/Tabbar/Tabbar.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';

import '../../globals.dart';
import 'ComonLoginWidgets.dart';



void main() => runApp(new LoginPage());
final FirebaseAuth auth = FirebaseAuth.instance;
bool isLoading = false;
String firebaseId;
final userName = TextEditingController();
final password = TextEditingController();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

bool value = false;

_setLoginView(){
  return new Container(
    padding: new EdgeInsets.all(20),
    // height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    // color: Colors.red,
    child:isLoading ? Container(
      child: Center(child: CircularProgressIndicator()),)
        :  new Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
        SizedBox(height: 25,),
        SizedBox(height: 25,),
        SizedBox(height: 50,),
        setTextFiels1(AppTranslations.of(context).text("loginUserName"),Icons.person,userName,),
        SizedBox(height: 25,),
        new Row(
          children: <Widget>[
            new Checkbox(
              value: this.value,
              onChanged: (value){
                setState(() {
                  this.value = value;
                });
              },
            ),
            new Text(AppTranslations.of(context).text("rememberMe"),
            textDirection: SharedManager.shared.direction,
            style: new TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
            ),
          ],
        ),
        SizedBox(height: 25,),
        new InkWell(
          onTap: (){
            if (!userName.text.isEmpty) {
              callApi();
            }
            if (userName.text.isEmpty) {
              final snackBar = SnackBar(
                content: Text('Please Enter Your Username'),
                action: SnackBarAction(
                  label: '',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );

              // Find the Scaffold in the widget tree and use
              // it to show a SnackBar.
              Scaffold.of(context).showSnackBar(snackBar);
            }
            },
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TabBarScreen()));
                  child: new Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: new Material(
                  color: AppColor.themeColor,
                  borderRadius: BorderRadius.circular(22.5),
                  elevation: 5.0,
                  child: new Center(
                    child: new Text(AppTranslations.of(context).text("loginSignIn"),
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
            SizedBox(height: 20,),
            SizedBox(height: 100,),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(AppTranslations.of(context).text("loginDontHaveAccount"),
                textDirection: SharedManager.shared.direction,
                style: new TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
                ),
                SizedBox(width: 2,),
                InkWell(
                  child: new Text("SIGN UP",
                  textDirection: SharedManager.shared.direction,
                  style: new TextStyle(
                    color: AppColor.themeColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>SignupPage()));
                  },
                )
              ],
            )
      ],
    ),
  );
}



callApi() async {
  // if (_submit()) {
  if (userName.text != null && userName.text != null) {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential result = await auth.signInWithEmailAndPassword(
          email:userName.text + "@gmail.com",
          password: userName.text
      );
      final User user = result.user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      final User currentUser = auth.currentUser;
      assert(user.uid == currentUser.uid);
      firebaseId = currentUser.uid;
      RouterName.id = firebaseId;


      print('object');
      prefrenceObjects.setString(
          SharedPreferenceKey.USERLOGIN, userName.text);
      setState(() {
        isLoading = false;
      });
      prefrenceObjects.setString(SharedPreferenceKey.FIREBASEID, firebaseId);
      RouterName.usern = userName.text;
      Navigator.of(context).
            pushAndRemoveUntil(
                MaterialPageRoute(builder: (context)=>TabBarScreen(firebaseId)),
                ModalRoute.withName('/TabBar')
            );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => IntroSlide(),
      //   ),
      // );
      return user;
      // }
    } catch (e) {

      setState(() {
        isLoading = false;
      });
      print("hello"+ e.toString());
        final snackBar = SnackBar(
          content: Text('Wrong Username'),
          action: SnackBarAction(
            label: '',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );


        // Find the Scaffold in the widget tree and use
        // it to show a SnackBar.
        Scaffold.of(context).showSnackBar(snackBar);

    }
  } else {


    _showAlert("Enter All Infomation", "", "");
  }
}

// Alert Box
  void _showAlert(String value, String userName, String password) {
    @override
    Widget build(BuildContext context) {
      return RaisedButton(
          child: Text("Button moved to separate widget"),
          onPressed: () {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Button moved to separate widget'),
              duration: Duration(seconds: 3),
            ));
          });
    }
  }



AppTranslationsDelegate _newLocaleDelegate;
  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale:null);
      application.onLocaleChanged = onLocaleChange;
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: new Scaffold(
        body: new Container(
          child:new ListView(
            children: <Widget>[
              _setLoginView(),
            ],
          )
        ),
      ),
        routes: {
        '/login': (BuildContext context) => LoginPage()
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