
import 'dart:ui';

import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/Screens/TabBarScreens/Tabbar/Tabbar.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'Constant.dart';

class SharedManager {
  static String firebaseId;

  static final SharedManager shared = SharedManager._internal(firebaseId);




  factory SharedManager() {
    return shared;
  }

  SharedManager._internal(firebaseId);

  // bool isRTL = true;
  bool isRTL = false;
  var direction = TextDirection.ltr;
  var count = 2;
  bool isOnboarding = false;
  int currentIndex = 0;
  var fontFamilyName = "Quicksand";
bool isOpenMessageScreen = false;
var ipAddress = "";

String name;
String mobile;
String specility;
bool isDoctor;

  var language =   Locale("en", "");
  // var language =   Locale("es", "");
  // var language =   Locale("ar", "");
  // var language =   Locale("fr", "");

setNavigation(BuildContext context, dynamic viewScreen){
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>viewScreen()));
}

  storeBoolValueLocally(bool value,String key)async{
    final prefs = await SharedPreferences.getInstance();
          await prefs.setBool(key, value);
  }

  dynamic retriveStoredValue(String key)async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }


String themeType = 'light';
ThemeData getThemeType(){
    return new ThemeData(
      brightness: _getBrightness(),
    );
}

Brightness _getBrightness(){
  if(themeType == "dark"){
     return Brightness.dark;
  }
  else{
    return Brightness.light;
  }
}

final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();



ValueNotifier<Locale> locale = new ValueNotifier(Locale('en', ''));

      String validateEmail(String value) {
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(value))
            return 'Enter Valid Email';
          else
            return null;
        }


setDrawer(BuildContext context,String name,String email){
          return new Drawer(
            child: new Container(
              color: Colors.white,
              child: ListView(
                  padding: new EdgeInsets.all(0.0),
                  children: <Widget>[
                    new UserAccountsDrawerHeader(
                          accountName: new Text(name,
                           textDirection: SharedManager.shared.direction,
                            style: new TextStyle(
                              fontSize: 18,
                              color: Colors.black
                            )
                          ),
                          accountEmail: new Text(email,
                           textDirection: SharedManager.shared.direction,
                            style: new TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            )
                          ),
                          currentAccountPicture: new GestureDetector(
                            onTap: (){
                              },
                              child: new CircleAvatar(
                              backgroundImage: new AssetImage(AppImage.doctorProfile),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white
                          ),
                      ),
                    new ListTile(
                      title: new Text(AppTranslations.of(context).text(AppTitle.drawerHome),
                      textDirection: SharedManager.shared.direction,
                      style: new TextStyle(
                        fontSize: 18,
                        color: AppColor.themeColor
                      )
                      ),
                      leading: new Icon(Icons.home,color:AppColor.themeColor),
                      onTap: (){
                        SharedManager.shared.currentIndex = 0;
                        Navigator.of(context).
                        pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen(firebaseId))
                        ,ModalRoute.withName('/TabBar'));
                      },
                    ),
                    new ListTile(
                      title: new Text(AppTranslations.of(context).text(AppTitle.drawerDoctors),
                       textDirection: SharedManager.shared.direction,
                      style: new TextStyle(
                        fontSize: 18,
                        color: AppColor.themeColor
                      )
                      ),
                      leading: new Icon(Icons.image,color:AppColor.themeColor),
                      onTap: (){
                        SharedManager.shared.currentIndex = 1;
                        Navigator.of(context).
                        pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen(firebaseId))
                        ,ModalRoute.withName('/TabBar'));
                      },
                    ),
                    new ListTile(
                      title: new Text(AppTranslations.of(context).text(AppTitle.drawerBlogs),
                       textDirection: SharedManager.shared.direction,
                      style: new TextStyle(
                        fontSize: 18,
                        color: AppColor.themeColor
                      )
                      ),
                      leading: new Icon(Icons.speaker_group,color:AppColor.themeColor),
                      onTap: (){
                        SharedManager.shared.currentIndex = 2;
                        Navigator.of(context).
                        pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen(firebaseId))
                        ,ModalRoute.withName('/TabBar'));
                      },
                    ),
                    new ListTile(
                      title: new Text(AppTranslations.of(context).text(AppTitle.drawerIndicators),
                       textDirection: SharedManager.shared.direction,
                      style: new TextStyle(
                        fontSize: 18,
                        color: AppColor.themeColor
                      )
                      ),
                      leading: new Icon(Icons.grain,color:AppColor.themeColor),
                      onTap: (){
                        SharedManager.shared.currentIndex = 3;
                        Navigator.of(context).
                        pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen(firebaseId))
                        ,ModalRoute.withName('/TabBar'));
                      },
                    ),
                    new ListTile(
                      title: new Text(AppTranslations.of(context).text(AppTitle.drawerProfile),
                       textDirection: SharedManager.shared.direction,
                      style: new TextStyle(
                        fontSize: 18,
                        color: AppColor.themeColor
                      )
                      ),
                      leading: new Icon(Icons.person,color:AppColor.themeColor),
                      onTap: (){
                        SharedManager.shared.currentIndex = 4;
                        Navigator.of(context).
                        pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen(firebaseId))
                        ,ModalRoute.withName('/TabBar'));
                      },
                    ),
                    new ListTile(
                      title: new Text(AppTranslations.of(context).text(AppTitle.drawerLogout),
                       textDirection: SharedManager.shared.direction,
                      style: new TextStyle(
                        fontSize: 18,
                        color: AppColor.themeColor
                      )
                      ),
                      leading: new Icon(Icons.power_settings_new,color:AppColor.themeColor),
                      onTap: (){
                        SharedManager.shared.currentIndex = 0;
                        Navigator.of(context).
                        pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MyHomePage())
                        ,ModalRoute.withName('/MyHomePage'));
                      },
                    ),
                    Divider(color:Colors.grey,),
                    // ExpansionTile(
                    //   title: new Text('Select Theme',
                    //   style: new TextStyle(
                    //     fontSize: 20,
                    //     color: Colors.black
                    //      )
                    //   ),
                    //   initiallyExpanded: false,
                    //   backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
                    //         children: <Widget>[
                    //           new ListTile(
                    //             title: const Text('Dark',style:  TextStyle(
                    //               color: Colors.black,
                    //             ),),
                    //             onTap: () {
                    //               themeType = 'dark';
                    //               SharedManager.shared.currentIndex = 0;
                    //               Navigator.of(context,rootNavigator: true).
                    //               pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen())
                    //               ,ModalRoute.withName('/TabBar'));
                    //             },      
                    //             leading: Icon(Icons.cloud,color:Colors.black),        
                    //           ),
                    //           new ListTile(
                    //             title: const Text('Light',style:  TextStyle(
                    //               color: Colors.grey,
                    //             ),
                    //             ),
                    //             onTap: () {
                    //               themeType = 'light';
                    //               SharedManager.shared.currentIndex = 0;
                    //               Navigator.of(context,rootNavigator: true).
                    //               pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen())
                    //               ,ModalRoute.withName('/TabBar'));
                    //             },              
                    //             leading: Icon(Icons.cloud,color:AppColor.themeColor),
                    //           ),
                    //     ],
                    // ),


                  ],
                ),
               )
              );
  }

void showAlertDialog(String message,BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Health Care"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}