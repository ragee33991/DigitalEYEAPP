import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_eye_app/Notifications/schedule_notifications.dart';
import 'package:digital_eye_app/Screens/Notifications/actions/actions.dart';
import 'package:digital_eye_app/Screens/Notifications/builder/ReminderAlertBuilder.dart';
import 'package:digital_eye_app/Screens/Notifications/store/store.dart';
import 'package:digital_eye_app/Screens/Notifications/utils/notificationHelper.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import '../main.dart';

class DatabaseService {
  final String uid;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  //DocumentReference documentReference = Firestore.instance.collection('product').document();

  DatabaseService({this.uid});
/*
  Future<void> addData(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e);
    });
  }
*/

  getData() async {
    return await FirebaseFirestore.instance.collection("users").snapshots();
  }

  Future<void> addQuizData(
      Map quizData, String quizId, String firebaseId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseId)
        .collection("Quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      //print(e.toString(addQuizData(quizData, quizId)));
    });
  }

  updateQuizData(
      String quizID, String value, String ide, String firebaseId) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseId)
        .collection("Quiz")
        .doc(quizID)
        .collection("QNA")
        .doc(ide)
        .update({'answer': value});
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(
      String firebaseId, String username, String dob, String gender) {
    return users
        .doc('$firebaseId')
        .set({
          'id': firebaseId,
          'name': username,
          'timestamp': DateTime.now(),
          'dob': dob,
          'gender': gender
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  configurePlayMusic(bool value) {
    getStore().dispatch(RemoveReminderAction(playMusic));
    if (value) {
      getStore().dispatch(SetReminderAction(
          time: new DateTime.now().toIso8601String(),
          name: "Daily Reminder",
          repeat: RepeatInterval.daily));

      scheduleNotificationPeriodically(flutterLocalNotificationsPlugin, '0',
          playMusic, RepeatInterval.daily);
    } else {
      turnOffNotificationById(flutterLocalNotificationsPlugin, 0);
      getStore().dispatch(RemoveReminderAction(playMusic));
    }
  }

  configureCustomReminder(
      bool value, TimeOfDay customNotificationTime, Duration duration) {
    getStore().dispatch(RemoveReminderAction("Questionnaire Reminder"));
    if (customNotificationTime != null) {
      if (value) {
        var now = new DateTime.now().add(duration);
        print(now);
        var notificationTime = new DateTime(now.year, now.month, now.day,
            customNotificationTime.hour, customNotificationTime.minute);

        getStore().dispatch(SetReminderAction(
            time: notificationTime.toIso8601String(),
            name: "Questionnaire Reminder",
            repeat: RepeatInterval.daily));

        scheduleNotification(
            flutterLocalNotificationsPlugin, '3', custom, notificationTime);
      } else {
        getStore().dispatch(RemoveReminderAction(custom));
        turnOffNotificationById(flutterLocalNotificationsPlugin, 4);
      }
    }
  }

  Future<void> setData(String value, double number) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble(value, number);
  }

  Future<void> setTodayData(String value, double number) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble(value, number);
  }

  Future<void> setMinMaxData(String value, double number) async {
    final prefs = await SharedPreferences.getInstance();
    double lastminupNumber = await getIntFromSharedPref("min" + value);
    double lastmaxupNumber = await getIntFromSharedPref("max" + value);

    if (lastminupNumber <= number) {
      await prefs.setDouble("min" + value, lastminupNumber);
    }
    if (lastmaxupNumber >= number) {
      await prefs.setDouble("max" + value, lastmaxupNumber);
    }
    if (number <= lastminupNumber) {
      await prefs.setDouble("min" + value, number);
    }
    if (number >= lastmaxupNumber) {
      await prefs.setDouble("max" + value, number);
    }

    await setTodayData(value, number);
  }

  Future<void> setTodayData1(String value, double number) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<void> setMinMaxData1(String value, double number) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<double> getIntFromSharedPref(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final startupNumber = prefs.getDouble(value) ?? 0.0;

    if (startupNumber == null) {
      return 0.0;
    }
    return startupNumber;
  }

  Future<void> uploadImage(var image) async {
    final String filename = basename(image.path);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child(RouterName.id)
          .child(filename)
          .putFile(image);
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  addSavedUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('usernamecheckbox', username);
  }

  removedSavedUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('usernamecheckbox');
  }

  getSavedUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('usernamecheckbox');
    return stringValue;
  }

  addSavedSEX(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('sex', 'sex');
  }

  removedSavedSEX() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('sex');
  }

  getSavedSEX() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('sex');
    return stringValue;
  }

  addSavedDOB(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('dob', username);
  }

  removedSavedDOB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('dob');
  }

  getSavedDOB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('dob');
    return stringValue;
  }

  Future<void> updateTime(String firebaseId) {
    return users
        .doc(firebaseId)
        .update({
          'timestamp':
              DateTime.now().add(Duration(days: 1, hours: 1, minutes: 00))
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  removeQuiz(String quizID, String firebaseId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseId)
        .collection("Quiz")
        .doc(quizID)
        .collection("QNA")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseId)
        .collection("Quiz")
        .doc(quizID)
        .get()
        .then((document) {
      if (document.exists) {
        document.reference.delete();
      }
    });
  }

  Future<void> addQuestionData(
      Map quizData, String quizId, String firebaseId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseId)
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .add(quizData)
        .catchError((e) {
      print(e);
    });
  }

  getQuizData(String firebaseId) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseId)
        .collection("Quiz")
        .snapshots();
  }

  final firestoreInstance = FirebaseFirestore.instance;

  getQuestionareID(String firebaseId) async {
    var result = await firestoreInstance
        .collection("users")
        .doc(firebaseId)
        .collection("Quiz")
        .where("quizImgUrl", isGreaterThan: "null")
        .get();
    result.docs.forEach((res) {
      print(res.data);
    });
  }

  Future<void> updateUser(String id, String dob, String gender) {
    return users
        .doc(id)
        .update({'dob': dob, 'gender': gender})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  getQuestionData(String quizId, String firebaseId) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseId)
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .get()
        .catchError((e) {
      print(e);
    });
  }

  getUser() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .get()
        .catchError((e) {
      print(e);
    });
  }
}
