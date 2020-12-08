import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';


void main()=> runApp(new CallingScreen());

class CallingScreen extends StatefulWidget {
  @override
  _CallingScreenState createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: new Scaffold(
        body: new Container(
          color:Colors.white,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              new Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    setCommonText(AppTranslations.of(context).text(AppTitle.calling),Colors.grey, 18.0, FontWeight.w500,1),
                    SizedBox(height: 5,),
                    setCommonText("Jems Andeson",Colors.black, 16.0, FontWeight.w500,1),
                  ],
                ),
                ),
              new SizedBox(height: 20,),
              new Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Center(
                  child: new Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      new Container(
                        height: MediaQuery.of(context).size.width - 150,
                        width: MediaQuery.of(context).size.width - 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1,color:Colors.grey[300])
                        ),
                      ),
                      new Container(
                        height: MediaQuery.of(context).size.width - 220,
                        width: MediaQuery.of(context).size.width - 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1,color:Colors.grey[300])
                        ),
                      ),
                      new Container(
                        height: MediaQuery.of(context).size.width - 280,
                        width: MediaQuery.of(context).size.width - 280,
                        child: new Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular((MediaQuery.of(context).size.width - 280)/2),
                          child:Container(
                            decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(AppImage.doctorProfile)
                          )
                        ),
                          )
                        ),
                      ),
                    ],
                  ),
                )
              ),
              SizedBox(height: 20,),
              new Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      height: 50,
                      width: 50,
                      child: new Material(
                        color: Colors.white,
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(25),
                        child: new IconButton(
                          icon: Icon(Icons.volume_off),
                          onPressed: (){},
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    new Container(
                      height: 50,
                      width: 50,
                      child: new Material(
                        color: Colors.red,
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(25),
                        child: new IconButton(
                          icon: Icon(Icons.call_end,color:Colors.white),
                          onPressed: (){},
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.calling),AppColor.themeColor),
          backgroundColor: Colors.white,
          elevation: 2.0,
          leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios,color:AppColor.themeColor),
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
