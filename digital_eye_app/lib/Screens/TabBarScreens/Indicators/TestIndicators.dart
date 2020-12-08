import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Screens/IndicatorList/IndicatorList.dart';
import 'package:digital_eye_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


void main()=>runApp(new TestIndicators());


class TestIndicators extends StatefulWidget {
  @override

  _TestIndicatorsState createState() => _TestIndicatorsState();
}


String days;
double values;

class _TestIndicatorsState extends State<TestIndicators> {
  bool isLoading = true;
  double value1 = 0;
  double value2 = 0;
  double value3 = 0;
  double value4 = 0;
  double value5 = 0;
  double value6 = 0;
  double value7 = 0;



  DatabaseService s = new DatabaseService();

  getData() async {

    double value11 = await s.getIntFromSharedPref("MondayAverage");
    double value21 = await s.getIntFromSharedPref("TuesdayAverage");
    double value31 = await s.getIntFromSharedPref("WednesdayAverage");
    double value41 = await s.getIntFromSharedPref("ThursdayAverage");
    double value51 = await s.getIntFromSharedPref("FridayAverage");
    double value61 = await s.getIntFromSharedPref("SaturdayAverage");
    double value71 =await s.getIntFromSharedPref("SundayAverage");


    setState(()  {
      value1 = value11;
      value2 = value21;
      value3 = value31;
      value4 = value41;
      value5 = value51;
      value6 = value61;
      value7 = value71;

    });

  }



    _setChardIndicatorView()  {
      TimeOfDay roomBooked2 = TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours:20,minutes: 0))); // 4:30pm

    print(roomBooked2);
    getData();


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
                  SalesData('Mon', value1),
                  SalesData('Tue', value2),
                  SalesData('Wed', value3),
                  SalesData('Thu', value4),
                  SalesData('Fri', value5),
                  SalesData('Sat', value6),
                  SalesData('Sun', value7),
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
    children: List<Widget>.generate(1,(index){

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
                  child:isLoading
                      ? Container(
                    child: Center(child: CircularProgressIndicator()),
                  )
                      : _setChardIndicatorView(),
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
  isLoading = false;

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