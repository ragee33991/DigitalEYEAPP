import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';




void main() => runApp(new MessageScreen());



class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {


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
        appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle("Alexander Wolfe",Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios,color:Colors.white),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
        body: new Container(
          color:Colors.grey[300],
          child:Column(
            children: <Widget>[
              new Expanded(
                child: new ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context,index){
                    return (index % 2 == 0)?_setRightBubble():_setLeftBubble();
                  },
                ),
              ),
              new Container(
                padding: new EdgeInsets.only(left: 15,right: 15,bottom: 25,top: 15),
                height: 90,
                color:Colors.white,
                child: new Row(
                  children: <Widget>[
                    new Icon(Icons.message,color:AppColor.themeColor,size: 22,),
                    SizedBox(width: 10,),
                    new Expanded(
                      child: new Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2,color:AppColor.themeColor),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        padding: new EdgeInsets.only(left: 12,right: 12),
                        child: new TextFormField(
                          textDirection: SharedManager.shared.direction,
                          decoration: InputDecoration(
                            hintText: AppTranslations.of(context).text(AppTitle.typeHere),
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: AppColor.themeColor,fontSize: 16)
                          ),
                          style: TextStyle(color: AppColor.themeColor,fontSize: 16),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send,size: 22,),
                      color: AppColor.themeColor,
                      onPressed: (){},
                    )
                  ],
                ),
              )
            ],
          )
        ),
      ),
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


_setLeftBubble(){
    return new Container(
      // height: 100,
      padding: new EdgeInsets.only(left: 15,right:100,top: 15,bottom: 15),
      child: new Container(
        child: new Material(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          child: new Padding(
            padding: new EdgeInsets.all(8),
              child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: setCommonText("Hello, How may I help you?", Colors.black54, 16.0, FontWeight.w500,5),
                    )
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                      setCommonText("10.45 AM", Colors.grey[400], 14.0, FontWeight.w500,5),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
}

_setRightBubble(){
      return new Container(
      // height: 110,
      padding: new EdgeInsets.only(right: 15,left:100,top: 15,bottom: 15),
      child: new Container(
        child: new Material(
          color: AppColor.themeColor,
          borderRadius: new BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft:  Radius.circular(8),
          ),
          child: new Padding(
            padding: new EdgeInsets.all(8),
              child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: setCommonText("Hello doctor, Are you there? I want to discuss something with you.", Colors.black87, 16.0, FontWeight.w500,5),
                    )
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                      setCommonText("10.45 AM", Colors.white, 14.0, FontWeight.w500,5),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
}