import 'package:digital_eye_app/Screens/CartList/CartList.dart';
import 'package:flutter/material.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Screens/DoctorProfileScreen/DoctorProfileScreen.dart';


void main()=>runApp(new DrugDetails());


class DrugDetails extends StatefulWidget {

  final index;
  DrugDetails({Key key,this.index}):super(key:key);

  @override
  _DrugDetailsState createState() => _DrugDetailsState();
}

class _DrugDetailsState extends State<DrugDetails> {
  bool isLike = false;
  bool isPurchased = false;
  static final sampleText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";

  var listDrugDetails = [];

_setHeroAnimation(){
  return  new Stack(
    children: <Widget>[
       new Hero(
                tag:widget.index,
                child: new DecoratedBox(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new AssetImage(AppImage.drugImage),
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 350.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: <Color>[
                            new Color(0x00FFFFFF),
                            new Color(0xFFFFFFFF),
                          ],
                          stops: [
                            0.0,
                            1.0
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(0.0, 1.0)),
                    ),
                  ),
                ),
              ),
              new Positioned(
                    left: 0,
                    top: 100,
                    child: new Container(
                    height: 40,
                    width: 120,
                    color: Colors.white.withAlpha(0),
                    child: new Center(
                      child: setCommonText("\$30.00",AppColor.themeColor, 20.0, FontWeight.w700,1),
                    ),
                  ),
          ),
          new Positioned(
                    left: 0,
                    bottom: 20,
                    child: new Container(
                    height: 40,
                    width: 80,
                    child:new IconButton(
                      icon: Icon(isLike?Icons.favorite:Icons.favorite_border,color: AppColor.themeColor,size: 30,),
                      onPressed: (){
                        setState(() {
                          isLike = !isLike;
                        });
                      },
                    )
                  ),
          ),
          new Positioned(
                    right: 0,
                    top: 60,
                    child: new Container(
                    padding: new EdgeInsets.only(right: 15),
                    height: 40,
                    child:new Stack(
                      children: <Widget>[
                        new IconButton(
                          icon: Icon(Icons.shopping_cart,color: AppColor.themeColor,size: 30,),
                          onPressed: (){
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CartList()));
                            });
                          },
                        ),
                        Positioned(
                          top: 0,
                          right: 4,
                          child: Container(
                            height: 18,
                            width: 18,
                            child: new Material(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(12),
                              child: new Center(
                                child: setCommonText(SharedManager.shared.count.toString(),Colors.black54, 14.0, FontWeight.w500, 1),
                              )
                            ),
                          )
                        )
                      ],
                    )
                  ),
          )
        ],
  );
}


_setDrugDetailsView(){
  return Container(
    height: 800,
    child:new ListView.builder(
      itemCount: listDrugDetails.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder:(context,index){
        return new Container(
          padding: new EdgeInsets.all(8),
          child: _setCommonViewForDrugDetails(listDrugDetails[index]['title'], listDrugDetails[index]['description']),
        );
      },
    )
  );
}

_setCommonViewForDrugDetails(String title,String subtitle){
        return Container(
          // height: 120,
          width: MediaQuery.of(context).size.width,
          child: new Material(
            elevation: 2.0,
            color: Colors.white,
            borderRadius: new BorderRadius.circular(5),
            child: new Padding(
              padding: new EdgeInsets.all(15),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  setCommonText(title,Colors.black, 17.0, FontWeight.w600,1),
                  SizedBox(height: 8,),
                  setCommonText(subtitle,
                  Colors.grey, 15.0, FontWeight.w600,10),
                ],
              ),
            ),
          ),
        );
}

  @override
  Widget build(BuildContext context) {
    this.listDrugDetails = [ 
      {"title":AppTranslations.of(context).text(AppTitle.whatIsAtomic),"description":sampleText},
      {"title":AppTranslations.of(context).text(AppTitle.importantInfo),"description":sampleText},
      {"title":AppTranslations.of(context).text(AppTitle.sideEffets),"description":sampleText}
  ];

    return new Scaffold(
      body: Column(
        children: <Widget>[
          new Expanded(
            child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            expandedHeight: 380,
            elevation: 0.1,
            pinned: true,
            flexibleSpace: new FlexibleSpaceBar(
              centerTitle: true,
              title: setCommonText("Atomic One", Colors.black, 18.0, FontWeight.w500, 1),
              background: _setHeroAnimation(),
            ),
          ),
          SliverToBoxAdapter(
            child: new Column(
              children: <Widget>[
                _setDrugDetailsView()
              ],
            )
          )
        ],
      ),
          ),
          new Container(
            height: 80,
            padding: new EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 25),
            child: new InkWell(
                onTap: (){
                      if(!isPurchased){
                        setState(() {
                          isPurchased = true;
                          SharedManager.shared.count = SharedManager.shared.count+ 1; 
                        });
                      }
                },
                child: new Material(
                color: AppColor.themeColor,
                elevation: 3.0,
                borderRadius: new BorderRadius.circular(25),
                child: new Center(
                  child: setCommonText(AppTranslations.of(context).text(AppTitle.buyNow), Colors.white, 16.0, FontWeight.w400,1)
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}