import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/utils/utils.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

import '../../main.dart';
import 'create_account_page_model.dart';

class CreateAccountPage extends StatelessWidget {
  static Widget ProviderPage() {
    return ChangeNotifierProvider<CreateAccountPageModel>(
      create: (context) =>  CreateAccountPageModel(),
      child: CreateAccountPage(),
    );
  }

  static CreateAccountPageModel of(BuildContext context) =>
      Provider.of<CreateAccountPageModel>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: ButtonBackGrey(context),
        centerTitle: true,
        title: Text("Create An Account"),
        actions: <Widget>[ButtonSkip(context: context, onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (contextTrans) => MyHomePage()),
            ModalRoute.withName(RouterName.MAIN),
          );
        })],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          children: <Widget>[
            InkWell(
              child: InputWidget(
                hint: "Birthday",
                text: CreateAccountPage.of(context).birthday,
                bottom: 20,
                top: 50,
              ),
              onTap: () {
                //final data = CreateAccountPage.of(context).data;
                Navigator.of(context).pushNamed(RouterName.CREATE_ACCOUNT_BIRTHDAY);
              },
            ),

            InkWell(
              child: InputWidget(
                  hint: "Gender",
                  text: CreateAccountPage.of(context).gender,
                  bottom: 20),
              onTap: () {
                //final data = CreateAccountPage.of(context).data;
                Navigator.of(context).pushNamed(RouterName.CREATE_ACCOUNT_GENDER);
              },
            ),
            Container(
              child: button(
                  width: 250,
                  text: "submit",
                  onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}
