import 'package:flutter/material.dart';

class SignInPageModel extends ChangeNotifier {
  bool isRemembered = false;
  FocusNode focusUsername = FocusNode();
  FocusNode focusPassword = FocusNode();

  void updateRemember() {
    isRemembered = !isRemembered;
    notifyListeners();
  }

  void nextFocus(BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
    notifyListeners();
  }

  void closeFocus(BuildContext context, FocusNode next) {
    next.unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
    notifyListeners();
  }
}
