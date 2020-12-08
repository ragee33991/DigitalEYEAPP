import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Screens/OrderDetails/OrderDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';


void main() => runApp(new OrderList());


class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  _setOrderList(){
    return new ListView.builder(
      itemCount: 5,
      itemBuilder: (context,count){
        return new Container(
          padding: new EdgeInsets.all(20),
          child: new Material(
            color: Colors.white,
            child: new Padding(
              padding: new EdgeInsets.all(15),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _setCommonView(AppTranslations.of(context).text(AppTitle.orderNumber), "HJKL678GHF"),
                  SizedBox(height: 8,),
                  _setCommonView(AppTranslations.of(context).text(AppTitle.orderDate), "July, 10, 2019"),
                  SizedBox(height: 8,),
                  _setCommonView(AppTranslations.of(context).text(AppTitle.paymentType), "Card"),
                  SizedBox(height: 8,),
                  _setCommonView(AppTranslations.of(context).text(AppTitle.shippingAdress), "220,Satyam Corporate 4th floor,D Block Shindhubhavan Road, Bhavanagar 380060"),
                  SizedBox(height: 8,),
                  Divider(color: AppColor.themeColor,),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          height: 45,
                          child: new Center(
                            child: setCommonText(AppTranslations.of(context).text(AppTitle.pending), AppColor.themeColor, 16.0, FontWeight.w500, 1),
                          ),
                        ),
                      ),
                      new Container(
                        width: 2,
                        height: 20,
                        color: AppColor.themeColor,
                      ),
                      new Expanded(
                        child: new InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OrderDetails()));
                          },
                          child: new Container(
                            height: 45,
                            child: new Center(
                              child: setCommonText(AppTranslations.of(context).text(AppTitle.details), Colors.grey, 16.0, FontWeight.w500, 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  _setCommonView(String title,String subtitle){
        return new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            setCommonText(title, Colors.black, 16.0, FontWeight.w500, 1),
            SizedBox(height: 3,),
            setCommonText(subtitle, Colors.grey, 14.0, FontWeight.w500, 5),
          ],
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
      home: new Scaffold(
        body: new Container(
          color: Colors.grey[100],
          child: _setOrderList(),
        ),
        appBar:new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.orderList),Colors.white),
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