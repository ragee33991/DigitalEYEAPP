import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_eye_app/Screens/TabBarScreens/Tabbar/Tabbar.dart';
import 'package:digital_eye_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/Screens/create_account_gender/create_account_gender_page.dart';
import 'package:digital_eye_app/utils/utils.dart';

import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

import 'create_account_weight_page_model.dart';

class CreateAccountWeightPage extends StatelessWidget {
  CreateAccountWeightPage();


  DatabaseService databaseService = new DatabaseService();


  GlobalKey _keyList = GlobalKey();

  // ignore: avoid_init_to_null
  static Widget ProviderPage() {
    return ChangeNotifierProvider<CreateAccountWeightPageModel>(
      create: (context) =>  CreateAccountWeightPageModel(),
      child: CreateAccountWeightPage(),
    );
  }

  static CreateAccountWeightPageModel of(BuildContext context) =>
      Provider.of<CreateAccountWeightPageModel>(context);
  String uid = RouterName.id.toString();


    // if (_submit()) {




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
                  // here you write the codes to input the data into firestor
                  print(uid);
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TabBarScreen()));
                    Navigator.of(context).
                    pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context)=>TabBarScreen(uid)),
                        ModalRoute.withName('/TabBar')

                    );

                }),
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
                      "Your Username: " + RouterName.usern,
                      style: TextStyle(
                          color: R.color.grey,
                          fontSize: 26,
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
                              decoration: new BoxDecoration(
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
                              )
                          ),

                        ),
                        Center(
                            child: Text(RouterName.usern, style: TextStyle(fontSize: 20))
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 20, bottom: 30, left: 30, right: 30),
                    child: button(
                        width: 250,
                        text: "Next",
                        onPressed: () {
                          //databaseService.addUser(uid, RouterName.usern, RouterName.dob, RouterName.gender);
                          databaseService.addUser(uid, RouterName.usern, RouterName.dob, RouterName.gender);
                           print("hello " + uid);
                            Navigator.of(context).
                            pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context)=>TabBarScreen(uid)),
                                ModalRoute.withName('/TabBar')

                            );
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
