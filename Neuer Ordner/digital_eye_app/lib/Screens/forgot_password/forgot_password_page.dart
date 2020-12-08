import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/generated/i18n.dart';
import 'package:digital_eye_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';


import 'fortgot_password_page_model.dart';

class ForgotPasswordPage extends StatelessWidget {
  static Widget ProviderPage() {
    return ChangeNotifierProvider<ForgotPasswordPageModel>(
      create: (context) =>  ForgotPasswordPageModel(),
      child: ForgotPasswordPage(),
    );
  }

  static ForgotPasswordPageModel of(BuildContext context) =>
      Provider.of<ForgotPasswordPageModel>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: SvgPicture.asset(R.image.ic_back_grey),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 50,
              left: 36,
              right: 36,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Text(
                        S.of(context).title_forgot_password.toUpperCase(),
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700),
                      ),
                      margin: EdgeInsets.only(bottom: 40),
                    ),
                    Container(
                      child: Text(
                        S.of(context).des_forgot_password,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 16, color: R.color.grey),
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Container(
                      child: TextFormField(
                        autofocus: false,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        style: inputTextStyle(),
                        decoration: inputImageDecoration(
                          hintText: S.of(context).hint_input_email,
                          image: R.image.ic_email,
                        ),
                        onFieldSubmitted: (value) {
                          ForgotPasswordPage.of(context).closeFocus(context);
                        },
                      ),
                      margin: EdgeInsets.only(bottom: 40),
                    ),
                    button(
                        text: S.of(context).btn_send_email.toUpperCase(),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    S.of(context).lbl_dont_have_account,
                    style: TextStyle(fontSize: 16, color: R.color.gray),
                  ),
                  InkWell(
                    child: Text(
                      S.of(context).btn_sign_up.toUpperCase(),
                      style: TextStyle(fontSize: 16, color: R.color.blue),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(RouterName.SIGN_UP);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
