import 'package:digital_eye_app/Screens/BookAppointment/BookAppointment.dart';
import 'package:digital_eye_app/Screens/CallingScreen/CallingScreen.dart';
import 'package:digital_eye_app/Screens/MessageScreen/MessageScreen.dart';
import 'package:digital_eye_app/Screens/PersonalInformations/PersonalInformations.dart';
import 'package:digital_eye_app/Screens/ReviewScreen/ReviewScreen.dart';
import 'package:digital_eye_app/Screens/WorkingAddress/WorkingAddress.dart';
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


void main() => runApp(new DoctorProfileScreen());


class DoctorProfileScreen extends StatefulWidget {

    final DoctorInfo doctorInfo;
    DoctorProfileScreen({Key key,this.doctorInfo}):super(key:key);

  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {

  List driverInfoList = [];

_setProfileImageDetailsView(){
  return new Container(
    height: 400,
    child: new Column(
      children: <Widget>[
        new Expanded(
          child: new Container(
            color: Colors.white,
            child: new Row(
              children: <Widget>[
                 new Expanded(
                  child: new InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CallingScreen(
                      )));
                    },
                    child: new Container(
                      child: new Center(
                        child: new Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(30),
                          child: new Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(AppImage.doctorProfilePhone),
                              fit: BoxFit.cover
                            )
                          ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                 new Expanded(
                   flex: 2,
                  child: new Container(
                    padding: new EdgeInsets.all(20),
                    child: new Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // border: Border.all(width:2,color:Colors.black),
                        image: DecorationImage(
                          image: AssetImage(widget.doctorInfo.image),
                          fit: BoxFit.contain
                        )
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                 new Expanded(
                  child: new InkWell(
                    onTap: (){
                      Navigator.of(context,rootNavigator: false).push(MaterialPageRoute(builder: (context)=>MessageScreen(
                      )));
                    },
                      child: new Container(
                      child: new Center(
                        child: new Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(30),
                          child: new Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(AppImage.doctorProfileMessage),
                              fit: BoxFit.cover
                            )
                          ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        new Expanded(
          child: new Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                setCommonText(widget.doctorInfo.name, Colors.black, 18.0, FontWeight.w600, 1),
                SizedBox(height: 5,),
                setCommonText(widget.doctorInfo.role, Colors.grey, 16.0, FontWeight.w500, 1),
                SizedBox(height: 5,),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(Icons.star_border,color:AppColor.themeColor,size: 18,),
                    SizedBox(width: 3,),
                    setCommonText(widget.doctorInfo.review, AppColor.themeColor, 16.0, FontWeight.w500, 1),
                    SizedBox(width: 8,),
                    setCommonText("(40 ${AppTranslations.of(context).text(AppTitle.reviews)})",Colors.grey, 15.0, FontWeight.w500, 1),
                  ],
                ),
                new Padding(
                  padding: new EdgeInsets.all(30),
                  child: new InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookAppointment()));
                    },
                    child: new Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: new Material(
                      color: AppColor.themeColor,
                      borderRadius: BorderRadius.circular(25),
                      elevation: 5.0,
                      child: new Center(
                        child: new Text(AppTranslations.of(context).text(AppTitle.bookAppointment),
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        ),
                        ),
                      ),
                    ),
              ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
      ],
    ),
  );
}

_setPersonalInformationsView(){
  return new Container(
    height: 260,
    // color: Colors.red,
    padding: new EdgeInsets.all(10),
    child: new ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context,index){
        return new InkWell(
            onTap: (){
              //GoogleMapScreen
              if(index == 0){
                Navigator.of(context,rootNavigator: false).push(MaterialPageRoute(builder: (context)=>PersonalInformations()));
              }
              else if(index == 1){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WorkingAddress()));
              }
              else{
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ReviewScreen()));
              }
            },
            child: new Container(
            height: 80,
            padding: new EdgeInsets.all(8),
            child: new Material(
              color: Colors.grey[100],
              borderRadius: new BorderRadius.circular(5),
              elevation: 3.0,
              child: new Padding(
                padding: new EdgeInsets.only(left: 15,right: 15),
                  child: new Row(
                  children: <Widget>[
                    driverInfoList[index]['icons'],
                    SizedBox(width: 5,),
                    new Container(
                      width: 2,
                      height: 17,
                      color: AppColor.themeColor,
                    ),
                    SizedBox(width: 10,),
                    new Expanded(
                      child: new Container(
                        child: setCommonText(driverInfoList[index]["title"], Colors.black54, 16.0, FontWeight.w600,2),
                      ),
                    ),
                    SizedBox(width: 5,),
                    new Icon(Icons.arrow_forward_ios,color:AppColor.themeColor,size: 18,),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
    this.driverInfoList = [
    {'title':AppTranslations.of(context).text(AppTitle.personalInfo),'icons':Icon(Icons.person,color:AppColor.themeColor,size: 18,),},
    {'title':AppTranslations.of(context).text(AppTitle.workAddress),'icons':Icon(Icons.location_city,color:AppColor.themeColor,size: 18,)},
    {'title':AppTranslations.of(context).text(AppTitle.reviewer),'icons':Icon(Icons.star_border,color:AppColor.themeColor,size: 18,)}
  ];

    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              SizedBox(height: 50,),
              _setProfileImageDetailsView(),
              _setPersonalInformationsView()
            ],
          ),
        ),
        appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.doctorsProfile),Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios,color:Colors.white),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[

          ],
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