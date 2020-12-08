import 'package:flutter/material.dart';

class ForgotPasswordPageModel extends ChangeNotifier {
  void closeFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    notifyListeners();
  }
}
