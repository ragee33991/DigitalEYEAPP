import 'package:digital_eye_app/Screens/DrugShop/DrugShop.dart';
import 'package:digital_eye_app/Screens/InsuranceScreen/InsuranceScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Screens/DoctorProfileScreen/DoctorProfileScreen.dart';

void main()=>runApp(new DrugListScreen());


class DrugListScreen extends StatefulWidget {
  @override
  _DrugListScreenState createState() => _DrugListScreenState();
}

class _DrugListScreenState extends State<DrugListScreen> {

_setDrugList(){
  return new ListView.builder(
    itemCount: 10,
    itemBuilder: (context,index){
      return new Container(
        height: 100,
        padding: new EdgeInsets.only(left: 15,right: 15,top: 7,bottom:7),
        child: new InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DrugShop()));
          },
            child: new Material(
            color: Colors.white,
            elevation: 1.0,
            borderRadius: BorderRadius.circular(5.0),
            child: new Padding(
              padding: new EdgeInsets.only(left: 15,right: 15),
              child: new Row(
                  children: <Widget>[
                    new Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: AssetImage(AppImage.drugImage)
                        )
                      ),
                    ),
                    // SizedBox(width: 12,),
                    // new Container(
                    //   height: 20,
                    //   width: 2,
                    //   color: Colors.grey,
                    // ),
                    SizedBox(width: 12,),
                    new Expanded(
                      /*

                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          setCommonText("Augmentin Sachet",Colors.black, 17.0, FontWeight.w500, 1),
                          SizedBox(height: 5,),
                          setCommonText("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",Colors.grey, 14.0, FontWeight.w500, 3),
                        ],

                      ),
                    */),
                    SizedBox(width: 12,),
                   // new Icon(Icons.arrow_forward_ios,color:AppColor.themeColor,size: 15),
                  ],
                )
            ),
          ),
        ),
      );
    },
  );
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
        body: Container(
          color: Colors.grey[200],
          child: _setDrugList(),
        ),
        appBar:new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.drugList),Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios,color:Colors.white),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InsuranceScreen()));
          },
          child: new Icon(Icons.brightness_low,size:30),
          backgroundColor: AppColor.themeColor,
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
  //This is for localization
  void onLocaleChange(Locale locale) {
      setState(() {
        _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
      });
    }
}