import 'package:digital_eye_app/Screens/CartList/CartList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';

void main() => runApp(new CheckoutScree());



class CheckoutScree extends StatefulWidget {
  @override
  _CheckoutScreeState createState() => _CheckoutScreeState();
}

class _CheckoutScreeState extends State<CheckoutScree> {

   List cartList = [];

   List cardList = [
      CardDetail("COD", AppImage.paymentCod, true),
      CardDetail("Paypal", AppImage.paymentPaypal, false),
      CardDetail("Card", AppImage.paymentCard, false),
   ];

  var description = "There are many variations of passages of Lorem Ipsum available";

  _fillCartListData(){
    for (var i=1; i<=SharedManager.shared.count;i++){
      final item =DrugItem("Automic one $i", description, 25.0+i,AppImage.drugImage, false,"$i",2);
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

_setItemListView(){
  return Container(
    height: (SharedManager.shared.count * 85.0) + 30,
    padding: new EdgeInsets.all(15),
    child: new ListView.builder(
      physics: NeverScrollableScrollPhysics(),
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
                      content: setCommonText(AppTranslations.of(context).text(AppTitle.itemDeleted), Colors.white, 18.0, FontWeight.w500, 1),
                    )
                  );
                },
          background: Container(color:AppColor.themeColor),
            child: new Container(
            height: 85,
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
          ),
        );
      },
    ),
  );
}

_setAddressView(){
  return new Container(
    // height: 200,
    padding: new EdgeInsets.only(left: 15,right: 15),
    child: new Material(
      color: Colors.white,
      child: new Padding(
        padding: new EdgeInsets.all(15),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            setCommonText(AppTranslations.of(context).text(AppTitle.deliveryAddress), Colors.black, 17.0, FontWeight.w500, 1),
            SizedBox(height: 5,),
            setCommonText("220, Satyam Corporate, 10th Floor,Sciencity Road Agra - 3456543", Colors.grey, 15.0, FontWeight.w500, 3),
            SizedBox(height: 8,),
            setCommonText(AppTranslations.of(context).text(AppTitle.contact), Colors.black, 17.0, FontWeight.w500, 1),
            SizedBox(height: 5,),
            setCommonText("+91 9089967542", Colors.grey, 15.0, FontWeight.w500, 3),
            SizedBox(height: 5,),
            SizedBox(height: 8,),
            setCommonText(AppTranslations.of(context).text(AppTitle.deliveryArea), Colors.black, 17.0, FontWeight.w500, 1),
            setCommonText("Home", Colors.grey, 15.0, FontWeight.w500, 3),
          ],
        ),
      ),
    ),
  );
}

_setPaymentType(){
  return new Container(
    height: 200,
    padding: new EdgeInsets.all(15),
    child: new Material(
      color: Colors.white,
      child: new Padding(
        padding: new EdgeInsets.all(15),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            setCommonText(AppTranslations.of(context).text(AppTitle.paymentType), Colors.black, 18.0, FontWeight.w500, 1),
            SizedBox(height: 5,),
            new Expanded(
              child: new Container(
                padding: new EdgeInsets.only(top: 5,bottom: 5),
                child: ListView.builder(
                  itemCount: cardList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return new Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width/3,
                        padding: new EdgeInsets.all(8),
                        child: new InkWell(
                          onTap: (){
                            setState(() {
                              for(int i=0;i<cardList.length;i++){
                              cardList[i].isSelect = false;
                            }
                              cardList[index].isSelect = true;
                            });
                          },
                          child: new Stack(
                            children: <Widget>[
                              new Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width/3,
                                  decoration: BoxDecoration(
                                  border: Border.all(width: 2,color: cardList[index].isSelect?AppColor.themeColor:Colors.grey),
                                  borderRadius: new BorderRadius.circular(5)
                                ),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(cardList[index].image),
                                          fit: BoxFit.fill
                                        )
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    setCommonText(cardList[index].title, AppColor.themeColor, 15.0, FontWeight.w500,1),
                                  ],
                                ),
                              ),
                              new Positioned(
                                right: 5,
                                top: 5,
                                child:cardList[index].isSelect?new Icon(Icons.check_circle_outline,color:Colors.green):new Text(''),
                              )
                            ],
                          ),
                        )
                      );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

_setTotalAmountView(){
  return new Container(
    padding: new EdgeInsets.all(15),
    child: Container(
      color: Colors.white,
      child: new Padding(
        padding: new EdgeInsets.all(10),
        child: new Column(
          children: <Widget>[
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                 setCommonText(AppTranslations.of(context).text(AppTitle.totalAmount), Colors.black, 18.0, FontWeight.w500, 1),
                 setCommonText("\$${_calculateTotalPrice(cartList)}", Colors.black, 18.0, FontWeight.w500, 1),
              ],
            ),
            SizedBox(height: 15,),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                 setCommonText(AppTranslations.of(context).text(AppTitle.discountAmount), Colors.black, 16.0, FontWeight.w500, 1),
                 setCommonText("\$${0.0}", Colors.black, 16.0, FontWeight.w500, 1),
              ],
            ),
            Divider(color: AppColor.themeColor,),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                 setCommonText(AppTranslations.of(context).text(AppTitle.grandTotal), Colors.green, 19.0, FontWeight.w500, 1),
                 setCommonText("\$${_calculateTotalPrice(cartList)}", Colors.green, 19.0, FontWeight.w500, 1),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

_setCheckoutButton(){
  return new Container(
    height: 100,
    padding: new EdgeInsets.all(25),
    child: new InkWell(
      onTap: (){
       // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PaymentSuccess()));
      },
      child: new Material(
        color: AppColor.themeColor,
        borderRadius: BorderRadius.circular(25),
        child: new Center(
          child: setCommonText(AppTranslations.of(context).text(AppTitle.proceedToCheckOut), Colors.white, 18.0, FontWeight.w500,1),
        ),
      ),
    ),
  );
}


@override
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
              _setAddressView(),
              _setPaymentType(),
              _setTotalAmountView(),
              _setCheckoutButton()
            ],
          ),
        ),
        appBar:new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.checkOut),Colors.white),
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