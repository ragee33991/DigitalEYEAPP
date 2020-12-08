import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';


void main()=>runApp(new WorkingAddress());


class WorkingAddress extends StatefulWidget {
  @override
  _WorkingAddressState createState() => _WorkingAddressState();
}

class _WorkingAddressState extends State<WorkingAddress> {

  _setWorkingAddressView(){
    return new ListView.builder(
      itemCount: 10,
      itemBuilder: (context,index){
            return new Container(
              padding: new EdgeInsets.all(10),
              // height: 150,
              child: new Material(
                elevation: 2,
                borderRadius: new BorderRadius.circular(8),
                child: new Padding(
                  padding: EdgeInsets.all(8),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      setCommonText("Children Hospital", Colors.black, 16.0, FontWeight.w600,1),
                      SizedBox(height: 10,),
                      setCommonText("220 A-2 Avenue,Parsipanny near HDFC Bank road,New York 09876564", Colors.grey, 14.0, FontWeight.w600,3),
                      SizedBox(height: 10,),
                      new Row(
                        children: <Widget>[
                          Icon(Icons.place,color:AppColor.themeColor,size:18,),
                          SizedBox(width: 3,),
                          setCommonText("0.8 km away",AppColor.themeColor, 14.0, FontWeight.w500, 1)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: new Scaffold(
        body: new Container(
          color: Colors.white,
          child: _setWorkingAddressView(),
        ),
        appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.workAddress),Colors.white),
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