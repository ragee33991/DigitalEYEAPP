import 'package:digital_eye_app/Screens/CheckoutScreen/CheckoutScree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';

void main() => runApp(new CartList());

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {

  List cartList = [];

  var description = "There are many variations of passages of Lorem Ipsum available";

  _fillCartListData(){
    for (var i=1; i<=SharedManager.shared.count;i++){
      final item =DrugItem("Automic one $i", description, 25.0+i,AppImage.drugImage, false,"$i",1);
      this.cartList.add(item);
    }
  }


double _calculateTotalPrice(List listItem){
    var total = 0.0;
    for (int i=0;i<listItem.length;i++){
      total = total + (listItem[i].price * listItem[i].count);
    }
    return total;
}

_increastItemCount(int index){
    setState(() {
      cartList[index].count  = cartList[index].count + 1;
    });
}

_decrementItemCount(int index){
  if(cartList[index].count > 1){
    setState(() {
      cartList[index].count  = cartList[index].count - 1;
    });
  }
}


_setCartList(){
  return new ListView.builder(
    itemCount: cartList.length,
    itemBuilder: (context,index){
      final itemID = cartList[index].id;
      return new Dismissible(
          key:Key(itemID),
          onDismissed: (direction){
            setState(() {
              cartList.removeAt(index);
              SharedManager.shared.count = SharedManager.shared.count - 1 ;
            });

            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: setCommonText(AppTranslations.of(context).text(AppTitle.itemDeleted), Colors.white, 16.0, FontWeight.w500, 1),
              )
            );
          },
          background: Container(color:AppColor.themeColor),
          child: new Container(
          height: 150,
          padding: new EdgeInsets.all(10),
          child: new Material(
            elevation: 2.0,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: new Padding(
                    padding: new EdgeInsets.only(top: 5,bottom: 5),
                    child: new Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImage.drugImage),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                  ),
                ),
                new Expanded(
                  flex: 2,
                  child: new Container(
                    padding: new EdgeInsets.only(top: 20,bottom: 20),
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: new Container(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                setCommonText(cartList[index].title, AppColor.themeColor, 17.0, FontWeight.w600, 2),
                                SizedBox(height: 5,),
                                setCommonText(cartList[index].description,Colors.grey, 15.0, FontWeight.w400, 2),
                                SizedBox(height: 5,),
                                new Row(
                                  children: <Widget>[
                                    setCommonText("\$${cartList[index].price}", Colors.black, 17.0, FontWeight.w600, 2),
                                    SizedBox(width: 4,),
                                    setCommonText("x", Colors.black, 17.0, FontWeight.w600, 2),
                                    SizedBox(width: 4,),
                                    setCommonText("${cartList[index].count}", Colors.black, 17.0, FontWeight.w600, 2),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: new Container(
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                new InkWell(
                                    onTap: (){
                                      _increastItemCount(index);
                                    },
                                    child: new Container(
                                    height: 25,
                                    width: 28,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2,color: AppColor.themeColor),
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: new Center(
                                      child: setCommonText("+", AppColor.themeColor, 15.0, FontWeight.w600, 1),
                                    ),
                                  ),
                                ),
                                new Container(
                                  height: 25,
                                  width: 28,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2,color: AppColor.themeColor.withOpacity(0)),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: new Center(
                                    child: setCommonText("1", AppColor.themeColor, 16.0, FontWeight.w600, 1),
                                  ),
                                ),
                                new InkWell(
                                  onTap: (){
                                    _decrementItemCount(index);
                                    },
                                  child: new Container(
                                    height: 27,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2,color: AppColor.themeColor),
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: new Center(
                                      child: setCommonText("-", AppColor.themeColor, 18.0, FontWeight.w600, 1),
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
          ),
        ),
      );
    },
  );
}

AppTranslationsDelegate _newLocaleDelegate;

 @override
  void initState() {

    _fillCartListData();
    SharedManager.shared.isOnboarding = true;
    _newLocaleDelegate = AppTranslationsDelegate(newLocale:null);
      application.onLocaleChanged = onLocaleChange;

      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: new Scaffold(
        body: new Container(
          color: Colors.grey[100],
          child:SharedManager.shared.count>0?new Column(
            children: <Widget>[
              new Expanded(
                child: _setCartList(),
              ),
              new Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                padding: new EdgeInsets.only(left: 25,right: 25,bottom: 20),
                child: new InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckoutScree()));
                  },
                    child: new Material(
                    elevation: 2.0,
                    color: AppColor.themeColor,
                    borderRadius: new BorderRadius.circular(25),
                    child: new Padding(
                      padding: new EdgeInsets.only(left: 20,right: 20),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              setCommonText("${AppTranslations.of(context).text(AppTitle.total)}:", Colors.white, 17.0, FontWeight.w600, 1),
                              SizedBox(width: 2,),
                              setCommonText("\$${_calculateTotalPrice(cartList)}", Colors.white, 17.0, FontWeight.w600, 1),
                            ],
                          ),
                          new Row(
                            children: <Widget>[
                              setCommonText(AppTranslations.of(context).text(AppTitle.checkOut), Colors.white, 18.0, FontWeight.w600, 1),
                              SizedBox(width: 2,),
                              Icon(Icons.arrow_forward,size:20,color:Colors.white)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ):
          new Center(
            child: new Padding(
              padding: new EdgeInsets.only(left: 15,right: 15),
              child: setCommonText(AppTranslations.of(context).text(AppTitle.itemNotFound), AppColor.themeColor, 20.0, FontWeight.w500, 2),
            ),
          ),
        ),
        appBar:new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.cartList),Colors.white),
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
  void onLocaleChange(Locale locale) {
      setState(() {
        _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
      });
    }
}


class DrugItem{
  String id;
  String title;
  String description;
  double price;
  String image;
  bool isSelect;
  int count;
  DrugItem(this.title,this.description,this.price,this.image,this.isSelect,this.id,this.count);
}
