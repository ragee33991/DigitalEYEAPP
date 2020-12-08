import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Screens/FindDoctorScreen/FindDoctorScreen.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:intl/intl.dart';


void main() => runApp(new NotificationsScreen());

class NotificationsScreen extends StatefulWidget {
  var value;
  var result;
  
  
   NotificationsScreen( {Key key, this.value, this.result});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: new Scaffold(
        body: new Container(
          color: Colors.grey[100],
          child:  GestureDetector(
            onTap: () {
              widget.value = value -1;
          Navigator.push(
          context, MaterialPageRoute(builder: (context) =>FindDoctorScreen(RouterName.id)));
            },
            child: new ListView.builder(
              itemCount:value,
              itemBuilder: (context,index){
                return
                _setCommonWidgetsForNotification("Questionnaire is Waiting", result.toString() +" mins ago",Icon(Icons.link),context);
              },
            ),
          ),
        ),
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