import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/Screens/create_account_gender/create_account_gender_page.dart';
import 'package:digital_eye_app/utils/utils.dart';

import 'package:provider/provider.dart';

import 'create_account_gender_page_model.dart';

class CreateAccountGenderPage extends StatelessWidget {
  CreateAccountGenderPage();

  GlobalKey _keyList = GlobalKey();
  String gender = "" ;

  // ignore: avoid_init_to_null
  static Widget ProviderPage() {
    return ChangeNotifierProvider<CreateAccountGenderPageModel>(
      create: (context) =>  CreateAccountGenderPageModel(),
      child: CreateAccountGenderPage(),
    );
  }

  static CreateAccountGenderPageModel of(BuildContext context) =>
      Provider.of<CreateAccountGenderPageModel>(context,listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: ButtonBackGrey(context),
          centerTitle: true,
          title: Text("Create An Account"),
          actions: <Widget>[
            ButtonSkip(
                context: context,
                onPressed: () {
                  //final data = CreateAccountGenderPage.of(context).data;
                  Navigator.of(context)
                      .pushReplacementNamed(RouterName.CREATE_ACCOUNT_WEIGHT);
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
                      "Your Gender",
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
                          child: CupertinoPicker(
                            useMagnifier: false,
                            magnification: 0.7,
                            backgroundColor: Colors.transparent,
                            diameterRatio: 20.0,
                            children: <Widget>[
                              _ItemPicker("Male",
                                  selected: CreateAccountGenderPage.of(context)
                                          .genderSelected ==
                                      0),
                              _ItemPicker("Female",
                                  selected: CreateAccountGenderPage.of(context)
                                          .genderSelected ==
                                      1),
                              _ItemPicker("Non-Binary",
                                  selected: CreateAccountGenderPage.of(context)
                                          .genderSelected ==
                                      2),
                              _ItemPicker("Other",
                                  selected: CreateAccountGenderPage.of(context)
                                          .genderSelected ==
                                      3),
                            ],
                            itemExtent: 70,
                            onSelectedItemChanged: (int value) {
                              CreateAccountGenderPage.of(context)
                                  .updateGender(value);
                            },
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
                        text: "Next",
                        onPressed: () {

                          RouterName.gender =CreateAccountGenderPage.of(context)
                              .genderSelected.toString();

                          print( CreateAccountGenderPage.of(context)
                              .genderSelected);
                          //final data = CreateAccountGenderPage.of(context).data;
                          Navigator.of(context).pushReplacementNamed(
                              RouterName.CREATE_ACCOUNT_WEIGHT);
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
