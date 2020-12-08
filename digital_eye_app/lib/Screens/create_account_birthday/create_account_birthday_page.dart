import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/Screens/create_account_gender/create_account_gender_page.dart';
import 'package:digital_eye_app/services/database.dart';
import 'package:digital_eye_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'create_account_birthday_page_model.dart';

class CreateAccountBirthdayPage extends StatelessWidget {
  CreateAccountBirthdayPage();

  GlobalKey _keyList = GlobalKey();

  // ignore: avoid_init_to_null
  static Widget ProviderPage() {
    return ChangeNotifierProvider<CreateAccountBirthdayPageModel>(
      create: (context) => CreateAccountBirthdayPageModel(),
      child: CreateAccountBirthdayPage(),
    );
  }

  static CreateAccountBirthdayPageModel of(BuildContext context) =>
      Provider.of<CreateAccountBirthdayPageModel>(context, listen: false);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: TitleAppBarBlack(title: "Create An Account"),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            //if (scrollNotification is ScrollStartNotification) {
            print(notification);
            print('Scrolling has started');
            //} else if (scrollNotification is ScrollEndNotification) {
            print("Scrolling has ended");
            //  }
            // Return true to cancel the notification bubbling.
            return true;
          },
          child: Container(
              padding: EdgeInsets.only(top: 35),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
                      child: Text(
                        "Enter your Birthday:",
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
                                  color: AppColor.themeColor,
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
                                  children: <Widget>[
                                    _ItemPicker("January",
                                        selected: CreateAccountBirthdayPage.of(
                                                    context)
                                                .monthSelected ==
                                            0),
                                    _ItemPicker("February",
                                        selected: CreateAccountBirthdayPage.of(
                                                    context)
                                                .monthSelected ==
                                            1),
                                    _ItemPicker("March",
                                        selected: CreateAccountBirthdayPage.of(
                                                    context)
                                                .monthSelected ==
                                            2),
                                    _ItemPicker("April",
                                        selected: CreateAccountBirthdayPage.of(
                                                    context)
                                                .monthSelected ==
                                            3),
                                    _ItemPicker("May",
                                        selected: CreateAccountBirthdayPage.of(
                                                    context)
                                                .monthSelected ==
                                            4),
                                    _ItemPicker("June",
                                        selected: CreateAccountBirthdayPage.of(
                                                    context)
                                                .monthSelected ==
                                            5),
                                    _ItemPicker("July",
                                        selected: CreateAccountBirthdayPage.of(
                                                    context)
                                                .monthSelected ==
                                            6),
                                    _ItemPicker("August",
                                        selected: CreateAccountBirthdayPage.of(
                                                    context)
                                                .monthSelected ==
                                            7),
                                    _ItemPicker("September",
                                        selected: CreateAccountBirthdayPage.of(
                                                    context)
                                                .monthSelected ==
                                            8),
                                    _ItemPicker("October",
                                        selected: CreateAccountBirthdayPage.of(
                                                    context)
                                                .monthSelected ==
                                            9),
                                    _ItemPicker("November",
                                        selected: CreateAccountBirthdayPage.of(
                                                    context)
                                                .monthSelected ==
                                            10),
                                    _ItemPicker("December",
                                        selected: CreateAccountBirthdayPage.of(
                                                    context)
                                                .monthSelected ==
                                            11),
                                  ],
                                  itemExtent: 70,
                                  onSelectedItemChanged: (int value) {
                                    CreateAccountBirthdayPage.of(context)
                                        .updateMonth(value);
                                  },
                                )),
                                Container(
                                  width: 50,
                                  child: CupertinoPicker(
                                    useMagnifier: false,
                                    magnification: 0.7,
                                    backgroundColor: Colors.transparent,
                                    diameterRatio: 20.0,
                                    children:
                                        CreateAccountBirthdayPage.of(context)
                                            .lstDay
                                            .map((d) {
                                      return _ItemPicker(
                                          d.toString().padLeft(2, '0'),
                                          selected: d ==
                                              CreateAccountBirthdayPage.of(
                                                      context)
                                                  .daySelected);
                                    }).toList(),
                                    itemExtent: 70,
                                    onSelectedItemChanged: (int value) {
                                      CreateAccountBirthdayPage.of(context)
                                          .updateDay(value);
                                    },
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  child: CupertinoPicker(
                                    magnification: 0.7,
                                    backgroundColor: Colors.transparent,
                                    diameterRatio: 20.0,
                                    children:
                                        CreateAccountBirthdayPage.of(context)
                                            .lstYear
                                            .map((y) {
                                      return _ItemPicker(y.toString(),
                                          selected: y ==
                                              CreateAccountBirthdayPage.of(
                                                      context)
                                                  .yearSelected);
                                    }).toList(),
                                    itemExtent: 70,
                                    onSelectedItemChanged: (int value) {
                                      CreateAccountBirthdayPage.of(context)
                                          .updateYear(value);
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
                          text: "Next",
                          onPressed: () {
                            RouterName.dob =
                                CreateAccountBirthdayPage.of(context)
                                        .yearSelected
                                        .toString() +
                                    "-" +
                                    CreateAccountBirthdayPage.of(context)
                                        .monthSelected
                                        .toString() +
                                    "-" +
                                    CreateAccountBirthdayPage.of(context)
                                        .daySelected
                                        .toString();

                            DatabaseService databaseService =
                                new DatabaseService();
                            databaseService.addSavedDOB(RouterName.dob);

                            /*
                        print( CreateAccountBirthdayPage.of(context)
                            .daySelected);
                        print( CreateAccountBirthdayPage.of(context)
                            .monthSelected);
                        print( CreateAccountBirthdayPage.of(context)
                            .yearSelected);

                         */

                            //final data = CreateAccountBirthdayPage.of(context).data;
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (contextTrans) =>
                                        CreateAccountGenderPage
                                            .ProviderPage()));
                          }),
                    )
                  ])),
        ));
  }
}
