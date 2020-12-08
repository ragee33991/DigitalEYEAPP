import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core ;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';


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

  Future<void> addQuizData(Map quizData, String quizId, String firebaseId) async {
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

  updateQuizData(String quizID,String value,String ide,String firebaseId) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseId)
        .collection("Quiz")
        .doc(quizID)
        .collection("QNA")
        .doc(ide)
        .update({
      'answer': value
    });
  }


  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(String firebaseId,String username,String dob,String gender) {
    return users
        .doc('$firebaseId')
        .set({
    'id': firebaseId,
    'name': username,
    'timestamp': DateTime.now(),
    'dob':dob,
    'gender':gender
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }


    Future<void> uploadImage(var image) async {
      final String filename =basename(image.path);
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


  removeQuiz(String quizID,String firebaseId) {
    FirebaseFirestore.instance
         .collection("users")
         .doc(firebaseId)
         .collection("Quiz")
        .doc(quizID)
        .collection("QNA")
        .get()
        .then((snapshot) {
          for (DocumentSnapshot doc in snapshot.documents) {
            doc.reference.delete();
          }
        });
    FirebaseFirestore.instance
            .collection("users")
            .doc(firebaseId)
            .collection("Quiz")
            .doc(quizID) .get()
        .then((document){
        if(document.exists)
    {
        document.reference.delete();
         }
    });


  }

  Future<void> addQuestionData(Map quizData, String quizId,String firebaseId ) async {
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
    return await FirebaseFirestore.instance.collection("users")
        .doc(firebaseId)
        .collection("Quiz").snapshots();
  }
  final firestoreInstance = FirebaseFirestore.instance;

  getQuestionareID(String firebaseId) async {
    var result = await firestoreInstance
        .collection("users").doc(firebaseId)
        .collection("Quiz")
        .where("quizImgUrl", isGreaterThan: "null")
        .get();
    result.docs.forEach((res) {
      print(res.data);
    });
  }

  getQuestionData(String quizId,String firebaseId) async{
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