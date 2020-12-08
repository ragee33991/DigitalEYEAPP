library my_prj.globals;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constant/sharedpreference_page.dart';


String text = "lightText";
final appColor = const Color(0xff015496); //blue
final appColorPink = const Color(0xffC72A61); //pink

class LightText extends StatelessWidget {
  final String text;
  final textColor;
  final textFontWeight;
  final textAlignment;

  LightText(
      {@required this.text,
      this.textColor,
      this.textFontWeight,
      this.textAlignment});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlignment,
      style:
          TextStyle(fontSize: 15, color: textColor, fontWeight: textFontWeight),
    );
  }
}

class MediumText extends StatelessWidget {
  final String text;
  final textColor;
  final textFontWeight;
  final textAlignment;

  MediumText(
      {@required this.text,
      this.textColor,
      this.textFontWeight,
      this.textAlignment});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlignment,
      style:
          TextStyle(fontSize: 20, color: textColor, fontWeight: textFontWeight),
    );
  }
}

class LargeText extends StatelessWidget {
  final String text;
  final textColor;
  final textFontWeight;
  final textAlignment;

  LargeText(
      {@required this.text,
      this.textColor,
      this.textFontWeight,
      this.textAlignment});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlignment,
      style: TextStyle(
        fontSize: 30,
        color: textColor,
        fontWeight: textFontWeight,
      ),
    );
  }
}

SharedPreferences prefrenceObjects;
String firebaseId = prefrenceObjects.getString(SharedPreferenceKey.FIREBASEID);
String userName = prefrenceObjects.getString(SharedPreferenceKey.USERLOGIN);
String peerId;
TextEditingController chatController = TextEditingController();
ScrollController listScrollController = ScrollController();
TextEditingController fileController = TextEditingController();
String peerName;
QuerySnapshot checkActiveStatus;

dynamic activeStatus() async {
  await FirebaseFirestore.instance
      .collection('activeUser')
      .doc(firebaseId)
      .collection(firebaseId)
      .doc(peerId)
      .set({
    'id': peerId,
    'Name': peerName,
  }).catchError((onError) {
    print(onError.toString());
  });
}

dynamic deleteActiveStatus() async {
  await FirebaseFirestore.instance
      .collection('activeUser')
      .doc(firebaseId)
      .collection(firebaseId)
      .doc(peerId)
      .delete()
      .catchError((onError) {
    print(onError.toString());
  });
}

dynamic checkPeerActiveStatus() async {
  checkActiveStatus = await FirebaseFirestore.instance
      .collection('activeUser')
      .doc(peerId)
      .collection(peerId)
      .where('id', isEqualTo: firebaseId)
      .get()
      .catchError((onError) {
    print(onError.toString());
  });
}

dynamic onlineStatus() async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(firebaseId)
      .update({'Online': 'true'});
}

dynamic offlineStatus() async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(firebaseId)
      .update({'Online': 'false'});
}
