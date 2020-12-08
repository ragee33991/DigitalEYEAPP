import 'package:digital_eye_app/Screens/CartList/CartList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';

void main()=>runApp(new OrderDetails());


class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {


List cartList = [];

   List cardList = [
      CardDetail("COD", AppImage.paymentCod, true),
      CardDetail("Paypal", AppImage.paymentPaypal, false),
      CardDetail("Card", AppImage.paymentCard, false),
   ];

  var description = "There are many variations of passages of Lorem Ipsum available";

  _fillCartListData(){
    for (var i=1; i<=4;i++){
      final item =DrugItem("Automic one $i", description, 25.0+i,AppImage.drugImage, false,"$i",2);
      this.cartList.add(item);
    }
  }


  _setItemListView(){
  return Container(
    height: (4 * 80.0) + 30,
    padding: new EdgeInsets.all(15),
    child: new ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: cartList.length,
      itemBuilder: (context,index){
            return new Container(
            height: 80,
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            child: new Material(
              color:Colors.white,
              child: new Padding(
                padding: new EdgeInsets.only(left: 12,right: 12),
                  child: Column(
                    children: <Widget>[
                      new Row(
                      children: <Widget>[
                        new Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(cartList[index].image),
                              fit: BoxFit.cover
                            )
                          ),
                        ),
                        SizedBox(width: 5,),
                        new Expanded(
                          child: new Container(
                            padding: EdgeInsets.only(top:5,),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                setCommonText(cartList[index].title, Colors.black, 16.0, FontWeight.w500, 1),
                                setCommonText(cartList[index].description, Colors.grey, 14.0, FontWeight.w500, 1),
                                SizedBox(height: 2,),
                                new Row(
                                        children: <Widget>[
                                          setCommonText("\$${cartList[index].price}", Colors.grey, 14.0, FontWeight.w400, 2),
                                          SizedBox(width: 4,),
                                          setCommonText("x", Colors.grey, 14.0, FontWeight.w400, 2),
                                          SizedBox(width: 4,),
                                          setCommonText("${cartList[index].count}", Colors.grey, 14.0, FontWeight.w400, 2),
                                        ],
                                      )
                              ],
                            ),
                          ),
                        )
                      ],
                       ),
                       Divider()
                    ],
                  ),
              ),
            ),
          );
      },
    ),
  );
}

_setAddressView(){
  return new Container(
    height: 200,
    padding: new EdgeInsets.only(left: 15,right: 15),
    child: new Material(
      color: Colors.white,
      child: new Padding(
        padding: new EdgeInsets.all(15),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            setCommonText(AppTranslations.of(context).text(AppTitle.deliveryAddress), Colors.black, 16.0, FontWeight.w500, 1),
            SizedBox(height: 5,),
            setCommonText("220, Satyam Corporate, 10th Floor,Sciencity Road Agra - 3456543", Colors.grey, 14.0, FontWeight.w500, 3),
            SizedBox(height: 8,),
            setCommonText(AppTranslations.of(context).text(AppTitle.contact), Colors.black, 16.0, FontWeight.w500, 1),
            SizedBox(height: 5,),
            setCommonText("+91 9089967542", Colors.grey, 14.0, FontWeight.w500, 3),
            SizedBox(height: 8,),
            setCommonText(AppTranslations.of(context).text(AppTitle.deliveryArea), Colors.black, 16.0, FontWeight.w500, 1),
            SizedBox(height: 5,),
            setCommonText("Home", Colors.grey, 14.0, FontWeight.w500, 3),
          ],
        ),
      ),
    ),
  );
}

_setOrderDetailsView(){
  return new Container(
    height: 200,
    padding: new EdgeInsets.only(left: 15,right: 15),
    child: new Material(
      color: Colors.white,
      child: new Padding(
        padding: new EdgeInsets.all(15),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            setCommonText(AppTranslations.of(context).text(AppTitle.orderNumber), Colors.black, 16.0, FontWeight.w500, 1),
            SizedBox(height: 5,),
            setCommonText("GHJH789JTY", Colors.grey, 14.0, FontWeight.w500, 3),
            SizedBox(height: 8,),
            setCommonText(AppTranslations.of(context).text(AppTitle.orderDate), Colors.black, 16.0, FontWeight.w500, 1),
            SizedBox(height: 5,),
            setCommonText("July 19, 2019", Colors.grey, 14.0, FontWeight.w500, 3),
            SizedBox(height: 8,),
            setCommonText(AppTranslations.of(context).text(AppTitle.totlaAmountTopay), Colors.black, 16.0, FontWeight.w500, 1),
            SizedBox(height: 5,),
            setCommonText("\$350.90", Colors.grey, 14.0, FontWeight.w500, 3),
          ],
        ),
      ),
    ),
  );
}

_setCheckoutButton(){
  return new Container(
    height: 100,
    padding: new EdgeInsets.all(20),
    child: new InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CartList()));
      },
      child: new Material(
        color: AppColor.themeColor,
        borderRadius: BorderRadius.circular(30),
        child: new Center(
          child: setCommonText(AppTranslations.of(context).text(AppTitle.orderAgain), Colors.white, 18.0, FontWeight.w500,1),
        ),
      ),
    ),
  );
}

void initState() {
    super.initState();
    _fillCartListData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: new Scaffold(
        body: new Container(
          color: Colors.grey[200],
          child: new ListView(
            children: <Widget>[
              _setItemListView(),
              _setOrderDetailsView(),
              SizedBox(height: 20,),
              _setAddressView(),
              _setCheckoutButton()
            ],
          ),
        ),
        appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.orderDetails),Colors.white),
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

class CardDetail{
  String title;
  String image;
  bool isSelect;

  CardDetail(this.title,this.image,this.isSelect);
}