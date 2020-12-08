import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Screens/TestIndicatorDetails/TestIndicatorDetails.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';



void main()=> runApp(new IndicatorList());

bool get isIos =>
    foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

class IndicatorList extends StatefulWidget {
  @override
  _IndicatorListState createState() => _IndicatorListState();
}


class _IndicatorListState extends State<IndicatorList> {



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
        home: DefaultTabController(
        length: 1,
        initialIndex: 0,
        child: Scaffold(
          appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle("Symptoms Overview",Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          leading: new IconButton(
                icon: Icon(Icons.arrow_back_ios,color:Colors.white),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              bottom: TabBar(
                indicatorColor: Colors.red,
                tabs: <Widget>[

                  Tab(
                    text: "",
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[IosSecondPage()],
            )),
      ),
      );
    }

  void onLocaleChange(Locale locale) {
      setState(() {



        _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
      });
    }
    }



List<PremiumIndicator> listPremium = [
    PremiumIndicator("Blurred vision:",
    "refers to a lack of sharpness of vision resulting in the inability to see fine detail.",Icon(Icons.visibility_off,color: Colors.red,)),
    PremiumIndicator("Double vision:",
    "occurs when a person sees a double image where there should only be one. The two images can be side by side, on top of one another, or both. The condition can affect balance, movement, and reading ability.",Icon(Icons.people,color: Colors.orange,)),
    PremiumIndicator("Dry, red eyes:",
     "are a common symptom of a dry eye (sicca syndrome). The normally white sclera is in this case coloured red and small veins clearly stand out.",Icon(Icons.format_color_reset,color: Colors.teal,)),
    PremiumIndicator("Eye irritation:",
     "Itchy, watery, swollen, and red eyes are signs of allergic conjunctivitis, an inflammation of the membrane that covers the whites of your eyes. Sometimes this happens along with nasal allergy symptoms.",Icon(Icons.invert_colors,color: Colors.green)),
    PremiumIndicator("Headaches:",
     "Headache is defined as a pain arising from the head or upper neck of the body. The pain originates from the tissues and structures that surround the skull or the brain because the brain itself has no nerves that give rise to the sensation of pain.",Icon(Icons.person,color: Colors.grey,)),
    PremiumIndicator("Neck or back pain:",
     ", back and neck pain may have many different causes.",Icon(Icons.airline_seat_legroom_extra,color: AppColor.themeColor))
];



class IosSecondPage extends StatelessWidget {
  const IosSecondPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: new Padding(
        padding: new EdgeInsets.only(top: 15),
        child: _setPremiumIndicatorList(listPremium),
      ),
    );
  }
}

double monVal;
double tueVal;
double WedVal;
double ThurVal;
double FriVal;
double SatVal;
double SunVal;
double total;
double today;
String minDate;
double minAmount;
String maxDate;
double maxAmount;
String title;
_setBasicIndicatorList(List<BasicIndicator> data){
  DatabaseService s = new DatabaseService();

  return new ListView.builder(
    itemCount: data.length,
    itemBuilder: (context,index){
      return new InkWell(
        onTap: (){

          if(index == 0){
            double monVal;
            double tueVal =RouterName.blurredT;
            double WedVal =RouterName.blurredW;
            double ThurVal =RouterName.blurredTH;
            double FriVal =RouterName.blurredFR;
            double SatVal =RouterName.blurredSA;
            double SunVal;
            s.getIntFromSharedPref("Mondayblurred").then((value) => monVal);
            print(" Hello indicator Mondayblurred" + monVal.toString());
            double today =RouterName.blurredToday;
            String minDate =RouterName.MinBlurrdate;
            double minAmount =RouterName.MinBlurr;
            String maxDate =RouterName.MaxBlurrdate;
            double maxAmount =RouterName.MaxBlurr;
            String title ="Blurred Vision Details";
            double total =monVal + tueVal + WedVal + ThurVal + FriVal +SatVal + SunVal;
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                TestIndicatorDetails(monVal,tueVal,WedVal,ThurVal,FriVal,SatVal,SunVal,total,today,minDate,minAmount,maxDate,maxAmount,title,RouterName.blurred)
            ));
          }

        },
          child: new Container(
          height: 80,
          padding: new EdgeInsets.all(8),
          child: new Material(
            color: Colors.white,
            elevation: 2.0,
            borderRadius: BorderRadius.circular(8),
            child: new Padding(
              padding: EdgeInsets.all(8),
              child: new Row(
                children: <Widget>[
                  data[index].icon,
                  SizedBox(width: 12,),
                  new Container(
                    height: 20,
                    width: 2,
                    color: AppColor.themeColor,
                  ),
                  SizedBox(width: 12,),
                  new Expanded(
                    child: setCommonText(data[index].title,Colors.black, 16.0, FontWeight.w500, 1),
                  ),
                  SizedBox(width: 12,),
                  (index % 2 == 0)?new Icon(Icons.check_circle,color:AppColor.themeColor):new Icon(Icons.check_circle_outline,color:AppColor.themeColor)
                ],
              )
            ),
          ),
        ),
      );
    },
  );
}

_setPremiumIndicatorList(List<PremiumIndicator>data){
  DatabaseService s = new DatabaseService();

  return new ListView.builder(
    itemCount: data.length,
    itemBuilder: (context,index){
      return new InkWell(
        onTap: () async {
        if(index == 0){




          double monVal =await s.getIntFromSharedPref("Mondayblurred");
          double tueVal =await s.getIntFromSharedPref("Tuesdayblurred");
          double WedVal =await s.getIntFromSharedPref("Wednesdayblurred");
          double ThurVal =await s.getIntFromSharedPref("Thursdayblurred");
          double FriVal =await s.getIntFromSharedPref("Fridayblurred");
          double SatVal =await s.getIntFromSharedPref("Saturdayblurred");
          double SunVal =await s.getIntFromSharedPref("Sundayblurred");
          double today =await s.getIntFromSharedPref("blurred");
          String minDate =RouterName.MinBlurrdate;
          double minAmount =await s.getIntFromSharedPref("minblurred");
          String maxDate =RouterName.MaxBlurrdate;
          double maxAmount =await s.getIntFromSharedPref("maxblurred");
          String title ="Blurred Vision Details";
          double total =monVal + tueVal + WedVal + ThurVal + FriVal +SatVal + SunVal;
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              TestIndicatorDetails(monVal,tueVal,WedVal,ThurVal,FriVal,SatVal,SunVal,total,today,minDate,minAmount,
                  maxDate,maxAmount,title,today.toString())
          ));
        }
        if(index == 1){
          double monVal =await s.getIntFromSharedPref("Mondaydouble");
          double tueVal =await s.getIntFromSharedPref("Tuesdaydouble");
          double WedVal =await s.getIntFromSharedPref("Wednesdaydouble");
          double ThurVal =await s.getIntFromSharedPref("Thursdaydouble");
          double FriVal =await s.getIntFromSharedPref("Fridaydouble");
          double SatVal =await s.getIntFromSharedPref("Saturdaydouble");
          double SunVal =await s.getIntFromSharedPref("Sundaydouble");
          double today =await s.getIntFromSharedPref("double");
          String minDate =RouterName.Mindoubledate;
          double minAmount =await s.getIntFromSharedPref("mindouble");
          String maxDate =RouterName.Maxdoubledate;
          double maxAmount =await s.getIntFromSharedPref("maxdouble");
          String title ="Double Vision Details";
          double total =monVal + tueVal + WedVal + ThurVal + FriVal +SatVal + SunVal;
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              TestIndicatorDetails(monVal,tueVal,WedVal,ThurVal,FriVal,SatVal,SunVal,
                  total,today,minDate,minAmount,maxDate,maxAmount,title,today.toString())
          ));
        }


        if(index == 2){
          double monVal =await s.getIntFromSharedPref("Mondaydry");
          double tueVal =await s.getIntFromSharedPref("Tuesdaydry");
          double WedVal =await s.getIntFromSharedPref("Wednesdaydry");
          double ThurVal =await s.getIntFromSharedPref("Thursdaydry");
          double FriVal =await s.getIntFromSharedPref("Fridaydry");
          double SatVal =await s.getIntFromSharedPref("Saturdaydry");
          double SunVal =await s.getIntFromSharedPref("Sundaydry");
          double today =await s.getIntFromSharedPref("dry");
          String minDate =RouterName.Maxdrydate;
          double minAmount =await s.getIntFromSharedPref("mindry");
          String maxDate =RouterName.Maxdrydate;
          double maxAmount =await s.getIntFromSharedPref("maxdry");
          String title ="Dry Eye Details";
          double total =monVal + tueVal + WedVal + ThurVal + FriVal +SatVal + SunVal;
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              TestIndicatorDetails(monVal,tueVal,WedVal,ThurVal,FriVal,SatVal,SunVal,total,
                  today,minDate,minAmount,maxDate,maxAmount,title,today.toString())
          ));
        }


        if(index == 3){
          double monVal =await s.getIntFromSharedPref("Mondayeye");
          double tueVal =await s.getIntFromSharedPref("Tuesdayeye");
          double WedVal =await s.getIntFromSharedPref("Wednesdayeye");
          double ThurVal =await s.getIntFromSharedPref("Thursdayeye");
          double FriVal =await s.getIntFromSharedPref("Fridayeye");
          double SatVal =await s.getIntFromSharedPref("Saturdayeye");
          double SunVal =await s.getIntFromSharedPref("Sundayeye");
          double today =await s.getIntFromSharedPref("eye");
          String minDate =RouterName.MaxBirrdate;
          double minAmount =await s.getIntFromSharedPref("mineye");
          String maxDate =RouterName.MaxBirrdate;
          double maxAmount =await s.getIntFromSharedPref("maxeye");
          String title =" Eye Irritation Details";
          double total =monVal + tueVal + WedVal + ThurVal + FriVal +SatVal + SunVal;
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              TestIndicatorDetails(monVal,tueVal,WedVal,ThurVal,FriVal,SatVal,SunVal,total,today,minDate,
                  minAmount,maxDate,maxAmount,title,today.toString())
          ));
        }

        if(index == 5){
          double monVal =await s.getIntFromSharedPref("Mondaypain");
          double tueVal =await s.getIntFromSharedPref("Tuesdaypain");
          double WedVal =await s.getIntFromSharedPref("Wednesdaypain");
          double ThurVal =await s.getIntFromSharedPref("Thursdaypain");
          double FriVal =await s.getIntFromSharedPref("Fridaypain");
          double SatVal =await s.getIntFromSharedPref("Saturdaypain");
          double SunVal =await s.getIntFromSharedPref("Sundaypain");
          double today =await s.getIntFromSharedPref("pain");
          String minDate =RouterName.Minneckdate;
          double minAmount =await s.getIntFromSharedPref("minpain");
          String maxDate =RouterName.Maxneckdate;
          double maxAmount =await s.getIntFromSharedPref("maxpain");
          String title =" Neck Pain Details";
          double total =monVal + tueVal + WedVal + ThurVal + FriVal +SatVal + SunVal;
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              TestIndicatorDetails(monVal,tueVal,WedVal,ThurVal,FriVal,SatVal,SunVal,total,today,minDate,
                  minAmount,maxDate,maxAmount,title,today.toString())
          ));
        }

        if(index == 4){
          double monVal =await s.getIntFromSharedPref("Mondayhead");
          double tueVal =await s.getIntFromSharedPref("Tuesdayhead");
          double WedVal =await s.getIntFromSharedPref("Wednesdayhead");
          double ThurVal =await s.getIntFromSharedPref("Thursdayhead");
          double FriVal =await s.getIntFromSharedPref("Fridayhead");
          double SatVal =await s.getIntFromSharedPref("Saturdayhead");
          double SunVal =await s.getIntFromSharedPref("Sundayhead");
          double today =await s.getIntFromSharedPref("head");
          String minDate =RouterName.Minheaddate;
          double minAmount =await s.getIntFromSharedPref("minhead");
          String maxDate =RouterName.Maxheaddate;
          double maxAmount =await s.getIntFromSharedPref("maxhead");
          String title =" Headaches Details";
          double total =monVal + tueVal + WedVal + ThurVal + FriVal +SatVal + SunVal;
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              TestIndicatorDetails(monVal,tueVal,WedVal,ThurVal,FriVal,
                  SatVal,SunVal,total,today,minDate,minAmount,maxDate,maxAmount,title,today.toString())
          ));
        }




      },

          child: new Container(
          // height:100,
          padding: new EdgeInsets.all(8),
          child: new Material(
            color: Colors.white,
            elevation: 2.0,
            borderRadius: BorderRadius.circular(8),
            child: new Padding(
              padding: EdgeInsets.all(8),
              child: new Row(
                children: <Widget>[
                  data[index].icon,
                  SizedBox(width: 12,),
                  new Container(
                    height: 40,
                    width: 1,
                    color: AppColor.themeColor,
                  ),
                  SizedBox(width: 12,),
                  new Expanded(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        setCommonText(data[index].title,Colors.black, 17.0, FontWeight.w500, 1),
                        SizedBox(height: 3,),
                        setCommonText(data[index].subTitle,Colors.grey, 16.0, FontWeight.w400, 3),
                      ],
                    )
                  ),
                  SizedBox(width: 12,),
                  new Icon(Icons.check_circle,color:AppColor.themeColor),
                ],
              )
            ),
          ),
        ),
      );
    },
  );
}


class BasicIndicator{
      String title;
      Icon icon;
      BasicIndicator(this.title,this.icon);
}

class PremiumIndicator{
    String title;
    String subTitle;
    Icon icon;

    PremiumIndicator(this.title,this.subTitle,this.icon);
}