import 'package:digital_eye_app/Screens/DrugDetails/DrugDetails.dart';
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


void main()=>runApp(new DrugShop());

class DrugShop extends StatefulWidget {
  @override
  _DrugShopState createState() => _DrugShopState();
}

class _DrugShopState extends State<DrugShop> {

  List alphaNumaric = [
                        {"char":"A","isSelect":false},{"char":"B","isSelect":false},{"char":"C","isSelect":false},{"char":"D","isSelect":false},{"char":"E","isSelect":false},{"char":"F","isSelect":false},
                        {"char":"G","isSelect":false},{"char":"H","isSelect":false},{"char":"I","isSelect":false},{"char":"J","isSelect":false},{"char":"K","isSelect":false},
                        {"char":"L","isSelect":false},{"char":"M","isSelect":false},{"char":"N","isSelect":false},{"char":"O","isSelect":false},{"char":"P","isSelect":false},
                        {"char":"Q","isSelect":false},{"char":"R","isSelect":false},{"char":"S","isSelect":false},{"char":"T","isSelect":false},{"char":"U","isSelect":false},
                        {"char":"V","isSelect":false},{"char":"W","isSelect":false},{"char":"X","isSelect":false},{"char":"Y","isSelect":false},{"char":"Z","isSelect":false},
                        ];

  _setFilterView(){
    return new Container(
      height: 50,
      padding: new EdgeInsets.only(left:0,right: 0,top:0,bottom: 10),
        child: new Material(
          color: Colors.white,
          elevation: 8.0,
          child: ListView.builder(
            itemCount: alphaNumaric.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
              return new InkWell(
                onTap: (){
                  for(var i=0; i<alphaNumaric.length;i++){
                    this.alphaNumaric[i]['isSelect'] = false;
                  }
                  setState(() {
                    this.alphaNumaric[index]['isSelect'] = true;
                  });
                },
                  child: new Container(
                  height: 40,
                  width: 50,
                  child: new Center(
                    child: setCommonText(alphaNumaric[index]['char'],
                    alphaNumaric[index]['isSelect']?AppColor.themeColor:Colors.black,
                    16.0,
                    FontWeight.w600,1),
                  ),
                ),
              );
            },
          ),
        )
    );
  }

  _setGridViewList(){
    return new Container(
      padding: new EdgeInsets.all(10),
      child: new GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (3/4),
        children: new List<Widget>.generate(20, (index) {
          return new GridTile(
            child: new InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DrugDetails(
                    index: index,
                  )));
                },
                child: new Hero(
                  tag: index,
                  child: new Container(
                  padding: new EdgeInsets.all(5),
                  child: new Material(
                    color: Colors.grey[100],
                    elevation: 1.0,
                    borderRadius: BorderRadius.circular(5),
                    child: new Column(
                      children: <Widget>[
                        new Expanded(
                          flex: 3,
                          child: new Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImage.drugImage),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        new Expanded(
                          child: new Container(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                setCommonText("Atomic One",Colors.black, 16.0, FontWeight.w700,1),
                                SizedBox(height: 3,),
                                setCommonText("\$30.00",AppColor.themeColor, 18.0, FontWeight.w500,1),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
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
        body: new Container(
          color: Colors.white,
          child: new Column(
            children: <Widget>[
              _setFilterView(),
              new Expanded(
                child: new Container(
                  color: Colors.white,
                  child: _setGridViewList(),
                ),
              )
            ],
          ),
        ),
        appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.drugShop),Colors.white),
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
