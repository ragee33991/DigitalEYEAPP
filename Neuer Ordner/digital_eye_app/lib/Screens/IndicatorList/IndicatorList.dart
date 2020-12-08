import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Notifications/schedule_notifications.dart';
import 'package:digital_eye_app/Screens/TestIndicatorDetails/TestIndicatorDetails.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';



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
  return new ListView.builder(
    itemCount: data.length,
    itemBuilder: (context,index){
      return new InkWell(
        onTap: (){

          if(index == 0){
            double monVal =RouterName.blurredMe;
            double tueVal =RouterName.blurredT;
            double WedVal =RouterName.blurredW;
            double ThurVal =RouterName.blurredTH;
            double FriVal =RouterName.blurredFR;
            double SatVal =RouterName.blurredSA;
            double SunVal =RouterName.blurredSU;
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
  return new ListView.builder(
    itemCount: data.length,
    itemBuilder: (context,index){
      return new InkWell(
        onTap: (){
        if(index == 0){
          double monVal =RouterName.blurredMe;
          double tueVal =RouterName.blurredT;
          double WedVal =RouterName.blurredW;
          double ThurVal =RouterName.blurredTH;
          double FriVal =RouterName.blurredFR;
          double SatVal =RouterName.blurredSA;
          double SunVal =RouterName.blurredSU;
          double today =RouterName.blurredToday;
          String minDate =RouterName.MinBlurrdate;
          double minAmount =RouterName.MinBlurr;
          String maxDate =RouterName.MaxBlurrdate;
          double maxAmount =RouterName.MaxBlurr;
          String title ="Blurred Vision Details";
          double total =monVal + tueVal + WedVal + ThurVal + FriVal +SatVal + SunVal;
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              TestIndicatorDetails(monVal,tueVal,WedVal,ThurVal,FriVal,SatVal,SunVal,total,today,minDate,minAmount,maxDate,maxAmount,title,RouterName.blurred.toString())
          ));
        }
        if(index == 1){
          double monVal =RouterName.doublevMe;
          double tueVal =RouterName.doublevT;
          double WedVal =RouterName.doublevW;
          double ThurVal =RouterName.doublevTH;
          double FriVal =RouterName.doublevFR;
          double SatVal =RouterName.doublevSA;
          double SunVal =RouterName.doublevSU;
          double today =RouterName.doublevToday;
          String minDate =RouterName.Mindoubledate;
          double minAmount =RouterName.Mindouble;
          String maxDate =RouterName.Maxdoubledate;
          double maxAmount =RouterName.Maxdouble;
          String title ="Double Vision Details";
          double total =monVal + tueVal + WedVal + ThurVal + FriVal +SatVal + SunVal;
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              TestIndicatorDetails(monVal,tueVal,WedVal,ThurVal,FriVal,SatVal,SunVal,total,today,minDate,minAmount,maxDate,maxAmount,title,RouterName.doublev)
          ));
        }


        if(index == 2){
          double monVal =RouterName.dryMe;
          double tueVal =RouterName.dryT;
          double WedVal =RouterName.dryW;
          double ThurVal =RouterName.dryTH;
          double FriVal =RouterName.dryFR;
          double SatVal =RouterName.drySA;
          double SunVal =RouterName.drySU;
          double today =RouterName.dryToday;
          String minDate =RouterName.Maxdrydate;
          double minAmount =RouterName.Mindry;
          String maxDate =RouterName.Maxdrydate;
          double maxAmount =RouterName.Maxdry;
          String title ="Dry Eye Details";
          double total =monVal + tueVal + WedVal + ThurVal + FriVal +SatVal + SunVal;
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              TestIndicatorDetails(monVal,tueVal,WedVal,ThurVal,FriVal,SatVal,SunVal,total,today,minDate,minAmount,maxDate,maxAmount,title,RouterName.dry)
          ));
        }


        if(index == 3){
          double monVal =RouterName.irritationMe;
          double tueVal =RouterName.irritationT;
          double WedVal =RouterName.irritationW;
          double ThurVal =RouterName.irritationTH;
          double FriVal =RouterName.irritationFR;
          double SatVal =RouterName.irritationSA;
          double SunVal =RouterName.irritationSU;
          double today =RouterName.irritationToday;
          String minDate =RouterName.MaxBirrdate;
          double minAmount =RouterName.MinBirr;
          String maxDate =RouterName.MaxBirrdate;
          double maxAmount =RouterName.MaxBirr;
          String title =" Eye Irritation Details";
          double total =monVal + tueVal + WedVal + ThurVal + FriVal +SatVal + SunVal;
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              TestIndicatorDetails(monVal,tueVal,WedVal,ThurVal,FriVal,SatVal,SunVal,total,today,minDate,minAmount,maxDate,maxAmount,title,RouterName.irritation)
          ));
        }

        if(index == 5){
          double monVal =RouterName.neckMe;
          double tueVal =RouterName.neckT;
          double WedVal =RouterName.neckW;
          double ThurVal =RouterName.neckTH;
          double FriVal =RouterName.neckFR;
          double SatVal =RouterName.neckSA;
          double SunVal =RouterName.neckSU;
          double today =RouterName.neckToday;
          String minDate =RouterName.Minneckdate;
          double minAmount =RouterName.Minneck;
          String maxDate =RouterName.Maxneckdate;
          double maxAmount =RouterName.Maxneck;
          String title =" Neck Pain Details";
          double total =monVal + tueVal + WedVal + ThurVal + FriVal +SatVal + SunVal;
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              TestIndicatorDetails(monVal,tueVal,WedVal,ThurVal,FriVal,SatVal,SunVal,total,today,minDate,minAmount,maxDate,maxAmount,title,RouterName.neck)
          ));
        }

        if(index == 4){
          double monVal =RouterName.headachesMe;
          double tueVal =RouterName.headachesT;
          double WedVal =RouterName.headachesW;
          double ThurVal =RouterName.headachesTH;
          double FriVal =RouterName.headachesFR;
          double SatVal =RouterName.headachesSA;
          double SunVal =RouterName.headachesSU;
          double today =RouterName.headachesToday;
          String minDate =RouterName.Minheaddate;
          double minAmount =RouterName.Minhead;
          String maxDate =RouterName.Maxheaddate;
          double maxAmount =RouterName.Maxhead;
          String title =" Headaches Details";
          double total =monVal + tueVal + WedVal + ThurVal + FriVal +SatVal + SunVal;
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              TestIndicatorDetails(monVal,tueVal,WedVal,ThurVal,FriVal,SatVal,SunVal,total,today,minDate,minAmount,maxDate,maxAmount,title,RouterName.headaches)
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