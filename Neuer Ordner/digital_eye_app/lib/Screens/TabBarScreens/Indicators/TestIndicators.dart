import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Screens/IndicatorList/IndicatorList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';


void main()=>runApp(new TestIndicators());


class TestIndicators extends StatefulWidget {
  @override

  _TestIndicatorsState createState() => _TestIndicatorsState();
}

double value1 = 0;
double value2 = 0;
double value3 = 0;
double value4 = 0;
double value5 = 0;
double value6 = 0;
double value7 = 0;
String days;
double values;

class _TestIndicatorsState extends State<TestIndicators> {


  static _setChardIndicatorView(){


    return new Container(
      height: 200,
      child:SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Enable legend
            legend: Legend(isVisible: false),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: false),
            series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                dataSource:  <SalesData>[
                  SalesData('Mon', RouterName.value1),
                  SalesData('Tue', RouterName.value2),
                  SalesData('Wed', RouterName.value3),
                  SalesData('Thu', RouterName.value4),
                  SalesData('Fri', RouterName.value5),
                  SalesData('Sat', RouterName.value6),
                  SalesData('Sun', RouterName.value7),
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true)
              )
            ]
          ),
    );
  }

_setTestIndicatorView(){


  return new GridView.count(

    crossAxisCount: 1,
    children: List<Widget>.generate(2,(index){

      return new Container(
        height: 350,
        padding: new EdgeInsets.all(15),
        child: new Material(
          elevation: 2.0,
          color: Colors.white,
          borderRadius: new BorderRadius.circular(8),
          child: new Column(
            children: <Widget>[
              new Expanded(
                child: new Container(
                  child: Padding(
                    padding: new EdgeInsets.all(8),
                    child: new Row(
                      children: <Widget>[
                        new Icon(Icons.pin_drop,color: AppColor.themeColor,size: 20,),
                        SizedBox(width: 3,),
                        setCommonText("Symptoms Overwiew", AppColor.themeColor, 16.0, FontWeight.w600,1)
                      ],
                    ),
                  ),
                ),
              ),
              new Expanded(
                flex: 5,
                child: new Container(
                  child: _setChardIndicatorView(),
                ),
              ),
              Divider(color: Colors.grey,),
              new Expanded(
                child: new Container(
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new InkWell(
                        onTap: (){
                          Navigator.of(context,rootNavigator: false).push(MaterialPageRoute(builder: (context)=>IndicatorList()));
                        },
                         child: new Row(
                          children: <Widget>[
                            new Icon(Icons.add_box,color:AppColor.themeColor,size: 20,),
                            SizedBox(width: 3,),
                            setCommonText(AppTranslations.of(context).text(AppTitle.indicatorDetails), AppColor.themeColor, 16.0, FontWeight.w500, 1),
                          ],
                        ),
                      ),
                      new Container(
                        color: AppColor.themeColor,
                        height: 20,
                        width: 2,
                      ),
                      new Row(
                        children: <Widget>[
                          new Icon(Icons.blur_circular,color:AppColor.themeColor,size: 20,),
                          SizedBox(width: 3,),
                          setCommonText("Symptoms", AppColor.themeColor, 16.0, FontWeight.w500, 1),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }),
  );
}

AppTranslationsDelegate _newLocaleDelegate;
@override
  void initState() {
    super.initState();
    SharedManager.shared.isOnboarding = true;
    _newLocaleDelegate = AppTranslationsDelegate(newLocale:null);
      application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        body: _setTestIndicatorView(),
         appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.drawerIndicators),Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          actions: setCommonCartNitificationView(context),
        ),
        drawer: SharedManager.shared.setDrawer(context, PersonalInfo.name,PersonalInfo.email),
    ),
    routes: {
        '/TestIndicator': (BuildContext context) => TestIndicators()
      },
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

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}