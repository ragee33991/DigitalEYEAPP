import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';


void main()=>runApp(new InsuranceScreen());

class InsuranceScreen extends StatefulWidget {
  @override
  _InsuranceScreenState createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen> {

_setInsuranceList(){
  return new ListView.builder(
    itemCount: 10,
    itemBuilder: (context,index){
      return Container(
        height: 325,
        padding: new EdgeInsets.all(15),
        child: new Material(
          elevation: 2.0,
          color: Colors.white,
          borderRadius: new BorderRadius.circular(5),
          child: new Stack(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: new Container(
                      color: Colors.grey[200],
                      padding: new EdgeInsets.only(left: 15,right: 15),
                      child: new Row(
                        children: <Widget>[
                          new Icon(Icons.local_hospital,color:AppColor.themeColor),
                          SizedBox(width: 5,),
                          setCommonText(AppTranslations.of(context).text(AppTitle.insurance), AppColor.themeColor, 18.0, FontWeight.w500, 1)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: new Container(
                      child: new Column(
                        children: <Widget>[
                          new Expanded(
                            child: new Container(
                              width: MediaQuery.of(context).size.width,
                              padding: new EdgeInsets.only(left: 15,right: 15),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  setCommonText(AppTranslations.of(context).text(AppTitle.createAccountFullName), Colors.grey[500], 18.0, FontWeight.w500, 1),
                                  SizedBox(height: 3,),
                                  setCommonText("Jems Anderson", Colors.black54, 18.0, FontWeight.w500, 1),
                                ],
                              ),
                            ),
                          ),
                          new Expanded(
                            flex: 2,
                            child: new Container(
                              padding: new EdgeInsets.all(15),
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                    flex: 2,
                                    child: new Container(
                                      child: new Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          _setCommonViewForList(AppTranslations.of(context).text(AppTitle.enrollId), "BHGYU6754"),
                                          SizedBox(height: 10,),
                                          _setCommonViewForList(AppTranslations.of(context).text(AppTitle.dateEffective), "07/2019"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  new Expanded(
                                    child: new Container(
                                      child: new Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          _setCommonViewForList(AppTranslations.of(context).text(AppTitle.group), "24-789"),
                                          SizedBox(height: 10,),
                                          _setCommonViewForList(AppTranslations.of(context).text(AppTitle.plan),AppTranslations.of(context).text(AppTitle.basic)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 20,
                top: 20,
                child: new Container(
                  height: 40,
                  width: 40,
                  child: new Material(
                    elevation: 4.0,
                    color: AppColor.themeColor,
                    borderRadius: new BorderRadius.circular(20),
                    child: new Center(
                      child: IconButton(
                        onPressed: (){},
                        icon:Icon(Icons.edit,color: Colors.white,size: 18,)
                        ),
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

_setCommonViewForList(String title, String subtitle){
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        setCommonText(title, Colors.grey[600], 14.0, FontWeight.w500, 1),
        SizedBox(height: 3,),
        setCommonText(subtitle, Colors.black54, 16.0, FontWeight.w500, 1),
      ],
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
        body: new Container(
          color: Colors.grey[100],
          child: _setInsuranceList(),
        ),
        appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.insurance),Colors.white),
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