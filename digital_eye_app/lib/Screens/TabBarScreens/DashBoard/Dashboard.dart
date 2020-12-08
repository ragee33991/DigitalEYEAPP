
import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';

import 'package:digital_eye_app/Screens/AppointMentList/AppointmentList.dart';
import 'package:digital_eye_app/Screens/FindDoctorScreen/FindDoctorScreen.dart';
import 'package:digital_eye_app/Screens/IndicatorList/IndicatorList.dart';
import 'package:digital_eye_app/Screens/LoginPage/ComonLoginWidgets.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';


import '../../../globals.dart';


void main() => runApp(new DashboardScreen(firebaseId));
bool notifi = false;

class DashboardScreen extends StatefulWidget {
  final String firebaseId;
  DashboardScreen(this.firebaseId);


  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {




  @override
  void dispose() {
    super.dispose();
  }


  List listData = [
      {"title":"dashbFindHospital","icon":Icon(Icons.query_builder,color:Colors.white,size: 40,),"availability":"hospitalAvaliability","isSelect":false},
         {"title":"dashbAppointment","icon":Icon(Icons.insert_invitation,color:Colors.white,size: 40,),"availability":"appointmentAvaliability","isSelect":false},
        {"title":"dashbPriceServices","icon":Icon(Icons.local_hospital,color:Colors.white,size: 40,),"availability":"priceServicesAvaliability","isSelect":false},

  ];

_setMainInformationView(){

  return new Container(
    // height: 185,
    padding: new EdgeInsets.all(20),
    // color: Colors.red,
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Row(
          children: <Widget>[

            //
            setCommonText(AppTranslations.of(context).text(AppTitle.dashbHello)+ RouterName.usern,Colors.black,25.0,FontWeight.w500,1),
            setCommonText(CreateAccountString.fullName+" ,",Colors.black,25.0,FontWeight.w500,1),
          ],
        ),
        SizedBox(height: 5,),
        setCommonText(AppTranslations.of(context).text(AppTitle.dashbTitleNote),Colors.grey,25.0,FontWeight.w500,2),
        SizedBox(height: 5,),
      ],
    ),
  );
}

_setGridViewListing(){
  return new Container(
    height: 520,
    // color: Colors.yellow,
    padding: new EdgeInsets.all(20),
    child: new GridView.count(
      physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: (3/2.5),
        children: new List<Widget>.generate(listData.length, (index) {
          return new GridTile(
            child: new InkWell(
                onTap: (){
                  setState(() {
                    for(var i = 0; i < listData.length; i++){
                       listData[i]['isSelect'] = false;
                    }
                    listData[index]['isSelect'] = true;
                  });
                  // FindDoctorScreen
                  switch (index) {
                    case 0:
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FindDoctorScreen(widget.firebaseId)));
                      break;
                      case 1:
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AppointMentList()));
                      break;
                      case 2:
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>IndicatorList()));
                      break;
                    default:
                  }
                },
                child: new Container(
                padding: new EdgeInsets.all(5),
                child: new Material(
                 color: (listData[index]['isSelect'])?AppColor.themeColor:Colors.black54,
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(5),
                    child: new Container(
                    padding: new EdgeInsets.all(12),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                         listData[index]['icon'],
                         new Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[
                             setCommonText(AppTranslations.of(context).text(listData[index]['title']), Colors.white,16.0, FontWeight.w700,2),
                             SizedBox(height: 3,),
                             setCommonText(AppTranslations.of(context).text(listData[index]['availability']), Colors.white,12.0, FontWeight.w500,2),
                           ],
                         )
                      ],
                    ),
                  ),
                )
              ),
            ),
          );
        }),
      ),
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
        appBar: new AppBar(
          centerTitle: true,
          title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          actions: setCommonCartNitificationView(context),
        ),
        drawer: SharedManager.shared.setDrawer(context, "Digital Eye", ""),
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              _setMainInformationView(),
              _setGridViewListing()
            ],
          ),
        ),
      ),
      routes: {
        '/Dashboard': (BuildContext context) => DashboardScreen(widget.firebaseId)
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

  //This is for localization
  void onLocaleChange(Locale locale) {
      setState(() {

        _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
      });
    }
}