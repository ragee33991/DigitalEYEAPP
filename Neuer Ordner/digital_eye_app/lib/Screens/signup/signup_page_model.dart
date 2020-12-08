import 'package:flutter/material.dart';

class SignUpPageModel extends ChangeNotifier {
  FocusNode focusUsername = FocusNode();
  FocusNode focusPassword = FocusNode();
  FocusNode focusPasswordConfirm = FocusNode();
  FocusNode focusEmail = FocusNode();

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