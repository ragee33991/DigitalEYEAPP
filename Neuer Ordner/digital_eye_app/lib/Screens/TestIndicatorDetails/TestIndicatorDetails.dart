import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


void main() => runApp(new TestIndicatorDetails("","","","","","","","","","","","","","",""));

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}



class TestIndicatorDetails extends StatefulWidget {
  final monVal;
  final tueVal;
  final WedVal;
  final ThurVal;
  final FriVal;
  final SatVal;
  final SunVal;
  final total;
  final today;
  final minDate;
  final minAmount;
  final maxDate;
  final maxAmount;
  final title;
  final OverallData;


  TestIndicatorDetails(this.monVal, this.tueVal, this.WedVal, this.ThurVal, this.FriVal, this.SatVal, this.SunVal, this.total, this.today, this.minDate, this.minAmount, this.maxDate, this.maxAmount,this.title,this.OverallData);


  @override
  _TestIndicatorDetailsState createState() => _TestIndicatorDetailsState();
}

class _TestIndicatorDetailsState extends State<TestIndicatorDetails> {

_setDetailsView(){
  return new Container(
    height: 120,
    color:Colors.grey[100],
    padding: new EdgeInsets.all(20),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            setCommonText(widget.OverallData.toString(), AppColor.themeColor, 25.0, FontWeight.w600, 1),
            SizedBox(width: 3,),
            setCommonText("%", Colors.grey, 18.0, FontWeight.w600, 1),
          ],
        ),
        SizedBox(height: 10,),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(Icons.watch_later,color:Colors.grey),
            SizedBox(width: 3,),
            setCommonText(new DateFormat.yMMMd().format(new DateTime.now()).toString(), Colors.grey, 17.0, FontWeight.w400, 1),
          ],
        )
      ],
    ),
  );
}
  _setChardIndicatorView(){
    return new Container(
      height: 200,
      child:new Stack(
                children: <Widget>[
                  SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Enable legend
                  legend: Legend(isVisible: false),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: false),
                  series: <LineSeries<SalesData, String>>[
                    LineSeries<SalesData, String>(
                      dataSource:  <SalesData>[
                        SalesData('Mon', widget.monVal),
                        SalesData('Tue', widget.tueVal),
                        SalesData('Wed', widget.WedVal),
                        SalesData('Thu', widget.ThurVal),
                        SalesData('Fri', widget.FriVal),
                        SalesData('Sat', widget.SatVal),
                        SalesData('Sun', widget.SunVal),
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true)
                    )
                  ]
                ),
             ],
      ),
    );
  }
  
  _setMainIndicatiorDescriptionView(){
    return new Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      padding: new EdgeInsets.all(15),
      child: new Material(
        color: Colors.white,
        elevation: 2.0,
        borderRadius: new BorderRadius.circular(5),
        child: new Padding(
          padding: new EdgeInsets.all(15),
          child: new Container(
            child: new Column(
              children: <Widget>[
                new Expanded(
                  child: new Container(
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: _setCommonViewForDescription("Total", new DateFormat.yMMMd().format(new DateTime.now()).toString(),widget.total.toString()),
                        ),
                        new Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(width: 8,),
                        new Expanded(
                          child: _setCommonViewForDescription("Today",  new DateFormat.yMMMd().format(new DateTime.now()).toString(),widget.today.toString()),
                        ),
                      ],
                    ),
                  ),
                ),
                new Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[300],
                ),
                new Expanded(
                  child: new Container(
                    child:new Row(
                      children: <Widget>[
                        new Expanded(
                          child: _setCommonViewForDescription(AppTranslations.of(context).text(AppTitle.min), widget.minDate.toString(),widget.minAmount.toString()),
                        ),
                        new Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(width: 8,),
                        new Expanded(
                          child: _setCommonViewForDescription(AppTranslations.of(context).text(AppTitle.max), widget.maxDate.toString(),widget.maxAmount.toString()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _setCommonViewForDescription(String title,String date,String bpm){
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          setCommonText(title, AppColor.themeColor, 20.0, FontWeight.w700, 1),
          SizedBox(height:3),
          setCommonText(date, Colors.grey, 16.0, FontWeight.w500, 1),
          SizedBox(height:10),
          new Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            setCommonText(bpm, Colors.black, 22.0, FontWeight.w600, 1),
            SizedBox(width: 3,),
            setCommonText("%", Colors.grey, 17.0, FontWeight.w600, 1),
          ],
        )
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: new Scaffold(
        body: new Container(
          color: Colors.grey[100],
          child: ListView(
            children: <Widget>[
              _setDetailsView(),
              _setChardIndicatorView(),
              _setMainIndicatiorDescriptionView()
            ],
          ),
        ),
        appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(widget.title,Colors.white),
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