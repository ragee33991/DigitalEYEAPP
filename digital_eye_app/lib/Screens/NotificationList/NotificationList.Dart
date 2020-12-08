import 'dart:io';

import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Screens/Notifications/builder/NotificationSwitchBuilder.dart';
import 'package:digital_eye_app/Screens/Notifications/builder/ReminderAlertBuilder.dart';
import 'package:digital_eye_app/Screens/Notifications/builder/RemindersListViewBuilder.dart';
import 'package:digital_eye_app/Screens/Notifications/models/Reminder.dart';
import 'package:digital_eye_app/Screens/Notifications/store/AppState.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


void main() => runApp(new NotificationsScreen());

class NotificationsScreen extends StatefulWidget {

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}
class _NotificationsScreenState extends State<NotificationsScreen> {
  final Store<AppState> store =  RouterName.store;

  @override
Widget build(BuildContext context) {
  return StoreProvider<AppState>(
    child: MaterialApp(
        debugShowCheckedModeBanner:false,
        home: Scaffold(
          appBar: new AppBar(
            centerTitle: true,
            // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
            title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.notification),Colors.white),
            backgroundColor: AppColor.themeColor,
            elevation: 1.0,
            leading: new IconButton(
              icon: Icon(Icons.arrow_back_ios,color:Colors.white),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: ReminderAlertBuilder()),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: NotificationSwitchBuilder()),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child:setCommonText("Scheduled Notifications",Colors.grey,22.0,FontWeight.w500,2),),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 2,
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: SizedBox(
                          child: StoreConnector<AppState, List<Reminder>>(
                              converter: (store) =>
                              store.state.remindersState.reminders,
                              builder: (context, reminders) {
                                return RemindersList(reminders: reminders);
                              }),
                          height: Platform.isAndroid ? 220 : 250,
                        ))),
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
    ),

    store: store,
  );

  ;
}
}


_setCommonWidgetsForNotification(String title,String time, Icon icon,BuildContext context){
    return new Container(
      height: 100,
      padding: new EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: new Material(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(5),
        elevation: 2.0,
        child: new Padding(
          padding: new EdgeInsets.only(left: 15,right: 15),
            child: new Row(
            children: <Widget>[
              new Icon(Icons.insert_link),
              SizedBox(width: 8,),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  setCommonText(title, Colors.black, 18.0, FontWeight.w500, 1),
                  SizedBox(height: 5,),
                  setCommonText(time, Colors.grey, 16.0, FontWeight.w500, 1),
                ],
              )
            ],
          ),
        ),
      ),
    );
}

_setCommonWidgetsForNotificationMessage(String title,String time,String imgUrl,BuildContext context){
    return new Container(
      height: 170,
      padding: new EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: new Material(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(5),
        elevation: 2.0,
        child: new Padding(
          padding: new EdgeInsets.only(left: 15,right: 15),
            child: new Row(
            children: <Widget>[
              new  Container(
                    height: 50,
                    width: 50,
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(AppImage.doctorList),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
              SizedBox(width: 8,),
              new Expanded(
                  child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    setCommonText(title, Colors.black, 17.0, FontWeight.w500, 2),
                    SizedBox(height: 5,),
                    setCommonText(time, Colors.grey, 16.0, FontWeight.w500, 1),
                    SizedBox(height: 8,),
                    new Container(
                      width: 120,
                      height: 35,
                      child: new Material(
                        elevation: 2.0,
                        borderRadius: new BorderRadius.circular(17.5),
                        color: AppColor.themeColor,
                        child: new Center(
                          child: setCommonText("REPLY", Colors.white, 17.0, FontWeight.w500,1),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
}