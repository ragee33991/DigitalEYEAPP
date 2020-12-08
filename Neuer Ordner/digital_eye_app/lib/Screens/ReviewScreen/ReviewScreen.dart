import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';


void main()=>runApp(new ReviewScreen());


class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  _setReviewList(dynamic data){
        return new ListView.builder(
          itemCount: 10,
          itemBuilder: (context,index){
            return new Container(
              height: 160,
              padding: new EdgeInsets.all(15),
              child: new Material(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(8),
                elevation: 2.0,
                child: new Column(
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        padding: new EdgeInsets.all(10),
                        // color: Colors.white,
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                                new Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(AppImage.doctorProfile)
                                    )
                                  ),
                                ),
                                SizedBox(width: 8,),
                                new Expanded(
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                      setCommonText("John Mike", Colors.black, 17.0, FontWeight.w500,2),
                                      SizedBox(height: 3,),
                                      setCommonText("09-10-2019", Colors.grey[600], 14.0, FontWeight.w500,2),
                                  ],
                                ),
                                ),
                                SizedBox(width: 5,),
                                new Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Icon(Icons.star_border,size:18,color:AppColor.themeColor),
                                    setCommonText("4.3", AppColor.themeColor, 14.0, FontWeight.w500, 1)
                                  ],
                                )
                          ],
                        ),
                      ),
                    ),
                    new Expanded(
                      child: new Container(
                        padding: new EdgeInsets.only(left: 15,right: 15,bottom: 5),
                        child: setCommonText("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                         Colors.grey[500], 16.0, FontWeight.w500,4)
                      ),
                    ),
                  ],
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
          color: Colors.grey[100],
          child: _setReviewList("test"),
        ),
        appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.reviews),Colors.white),
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