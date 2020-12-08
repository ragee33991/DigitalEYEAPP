import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/generated/i18n.dart';
import 'package:digital_eye_app/utils/utils.dart';

import 'signup_page_model.dart';

class SignUpPage extends StatelessWidget {
  static Widget ProviderPage() {
    return ChangeNotifierProvider<SignUpPageModel>(
      create: (context) =>  SignUpPageModel(),
      child: SignUpPage(),
    );
  }

  static SignUpPageModel of(BuildContext context) =>
      Provider.of<SignUpPageModel>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 36, right: 36, bottom: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "sign up",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w700),
                      ),
                      margin: EdgeInsets.only(bottom: 30),
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: SignUpPage.of(context).focusUsername,
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        style: inputTextStyle(),
                        decoration: inputImageDecoration(
                          hintText: "Username",
                          image: R.image.ic_user,
                        ),
                        onFieldSubmitted: (value) {
                          SignUpPage.of(context).nextFocus(
                              context,
                              SignUpPage.of(context).focusUsername,
                              SignUpPage.of(context).focusPassword);
                        },
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: SignUpPage.of(context).focusPassword,
                        style: inputTextStyle(),
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        decoration: inputImageDecoration(
                          hintText: "Password",
                          image: R.image.ic_password,
                        ),
                        onFieldSubmitted: (value) {
                          SignUpPage.of(context).nextFocus(
                              context,
                              SignUpPage.of(context).focusPassword,
                              SignUpPage.of(context).focusPasswordConfirm);
                        },
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: SignUpPage.of(context).focusPasswordConfirm,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        style: inputTextStyle(),
                        decoration: inputImageDecoration(
                          hintText: "Password",
                          image: R.image.ic_password,
                        ),
                        onFieldSubmitted: (value) {
                          SignUpPage.of(context).nextFocus(
                              context,
                              SignUpPage.of(context).focusPasswordConfirm,
                              SignUpPage.of(context).focusEmail);
                        },
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: SignUpPage.of(context).focusEmail,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        style: inputTextStyle(),
                        decoration: inputImageDecoration(
                          hintText: "E-Mail",
                          image: R.image.ic_email,
                        ),
                        onFieldSubmitted: (value) {
                          SignUpPage.of(context).closeFocus(
                              context, SignUpPage.of(context).focusEmail);
                        },
                      ),
                      margin: EdgeInsets.only(bottom: 0),
                    ),
                    Container(
                      child: button(
                          text: "sign up",
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(RouterName.CREATE_ACCOUNT);
                          }),
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                    ),
                    button(
                        text: "sign in with facebook",
                        onPressed: () {}),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Have an account?",
                    style: TextStyle(fontSize: 16, color: R.color.gray),
                  ),
                  InkWell(
                    child: Text(
                        "sign in",
                      style: TextStyle(fontSize: 16, color: R.color.blue),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
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
