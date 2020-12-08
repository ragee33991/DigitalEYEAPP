import 'package:flutter/material.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/Screens/create_account_gender/create_account_gender_page.dart';
import 'package:digital_eye_app/utils/utils.dart';

import 'package:provider/provider.dart';

import 'create_account_fullname_page_model.dart';

class CreateAccountFullnamePage extends StatelessWidget {
  CreateAccountFullnamePage();

  // ignore: avoid_init_to_null
  static Widget ProviderPage() {
    return ChangeNotifierProvider<CreateAccountFullnamePageModel>(
      create: (context) => CreateAccountFullnamePageModel(),
      child: CreateAccountFullnamePage(),
    );
  }

  static CreateAccountFullnamePageModel of(BuildContext context) =>
      Provider.of<CreateAccountFullnamePageModel>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: ButtonBackGrey(context),
          centerTitle: true,
          title: TitleAppBarBlack(title:"Create An Account"),
          actions: <Widget>[
            ButtonSkip(
                context: context,
                onPressed: () {
                  //final data = CreateAccountFullnamePage.of(context).data;
                  Navigator.of(context).pushReplacementNamed(RouterName.CREATE_ACCOUNT_BIRTHDAY);
                })
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: 30, right: 30, top: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  "your name",
                  style: TextStyle(
                      color: R.color.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              TextFormField(
                autofocus: false,
                controller: TextEditingController(
                  /*text: CreateAccountFullnamePage.of(context).fullname*/
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                obscureText: false,
                style: inputTextStyle(),
                decoration: inputImageDecoration(
                  hintText: "Fullname",
                  image: R.image.ic_user,
                ),
                onFieldSubmitted: (value) {
                  CreateAccountFullnamePage.of(context).updateData(value);
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: button(
                    width: 250,
                    text: "next",
                    onPressed: () {
                      //final data = CreateAccountFullnamePage.of(context).data;
                      Navigator.of(context).pushReplacementNamed(RouterName.CREATE_ACCOUNT_BIRTHDAY);
                    }),
              )
            ],
          ),
        ));
  }
}
