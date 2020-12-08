import 'package:digital_eye_app/Screens/TabBarScreens/Tabbar/Tabbar.dart';
import 'package:digital_eye_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/Screens/create_account_gender/create_account_gender_page.dart';
import 'package:digital_eye_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:provider/provider.dart';

import '../../main.dart';
import 'create_account_height_page_model.dart';

class CreateAccountHeightPage extends StatelessWidget {

  GlobalKey _keyList = GlobalKey();

  // ignore: avoid_init_to_null
   Widget ProviderPage() {
    return ChangeNotifierProvider<CreateAccountHeightPageModel>(
      create: (context) => CreateAccountHeightPageModel(),
      child: CreateAccountHeightPage(),
    );
  }

  static CreateAccountHeightPageModel of(BuildContext context) =>
      Provider.of<CreateAccountHeightPageModel>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: ButtonBackGrey(context),
          centerTitle: true,
          title: TitleAppBarBlack(title: "Create An Account"),
          actions: <Widget>[
            ButtonSkip(
                context: context,
                onPressed: () {
                  //final data = CreateAccountHeightPage.of(context).data;
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (contextTrans) => MyHomePage()),
                    ModalRoute.withName(RouterName.MAIN),
                  );
                })
          ],
        ),
        body: Container(
            padding: EdgeInsets.only(top: 35),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
                    child: Text(
                      "Your Height",
                      style: TextStyle(
                          color: R.color.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    key: _keyList,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: R.color.light_blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: R.color.dark_black.withAlpha(75),
                                    blurRadius: 20.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(
                                      1.0,
                                      1.0,
                                    ),
                                  )
                                ],
                              )),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: CupertinoPicker(
                                useMagnifier: false,
                                magnification: 0.7,
                                backgroundColor: Colors.transparent,
                                diameterRatio: 20.0,
                                children: CreateAccountHeightPage.of(context)
                                    .lstHeight
                                    .map((w) {
                                  return _ItemPicker(
                                      w.toString().padLeft(2, '0'),
                                      selected:
                                          CreateAccountHeightPage.of(context)
                                                  .height ==
                                              w);
                                }).toList(),
                                itemExtent: 70,
                                onSelectedItemChanged: (int value) {
                                  CreateAccountHeightPage.of(context)
                                      .updateWeight(value);
                                },
                              )),
                              Container(
                                width: 60,
                                child: CupertinoPicker(
                                  magnification: 0.7,
                                  backgroundColor: Colors.transparent,
                                  diameterRatio: 20.0,
                                  children: [
                                    _ItemPicker("CM",
                                        selected:
                                            CreateAccountHeightPage.of(context)
                                                    .unitSelected ==
                                                0),
                                    _ItemPicker("INCH",
                                        selected:
                                            CreateAccountHeightPage.of(context)
                                                    .unitSelected ==
                                                1),
                                  ],
                                  itemExtent: 70,
                                  onSelectedItemChanged: (int value) {
                                    CreateAccountHeightPage.of(context)
                                        .updateUnit(value);
                                  },
                                ),
                              )
                            ],
                          ),
                          margin: EdgeInsets.only(left: 30, right: 30),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 20, bottom: 30, left: 30, right: 30),
                    child: button(
                        width: 250,
                        text: "NEXT",
                        onPressed: () {

                          var uid;
                          void inputData() async {
                            FirebaseAuth.instance
                                .authStateChanges()
                                .listen((auth.User user) {
                              if (user == null) {
                                print('User is currently signed out!');
                              } else {
                                uid = user.uid;
                                print('User is signed in!');
                              }
                            });

                            // here you write the codes to input the data into firestore

                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TabBarScreen()));
                            Navigator.of(context).
                            pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context)=>TabBarScreen(uid)),
                                ModalRoute.withName('/TabBar')

                            );
                          }
                        }),
                  )
                ])));
  }
}

Widget _ItemPicker(String mss,
        {TextAlign textAlign = TextAlign.left, bool selected = false}) =>
    Container(
      alignment: Alignment.centerLeft,
      child: Text(
        mss,
        textAlign: textAlign,
        style: TextStyle(
            color: selected ? Colors.white : R.color.gray, fontSize: 24),
      ),
    );
