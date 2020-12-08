import 'package:digital_eye_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;


class AuthService{

   auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

   User _userFromFirebaseUser(auth.User user) {

     auth.FirebaseAuth.instance
         .authStateChanges()
         .listen((user) {
       if (user == null) {
         print('User is currently signed out!');
       } else {
         print('User is signed in!');
       }
     });

     Future signInEmailAndPass(String email, String password) async{

       try {
         auth.UserCredential userCredential = await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
           email: email,
           password: password,
         );
       } on auth.FirebaseAuthException catch (e) {
         if (e.code == 'user-not-found') {
           print('No user found for that email.');
         } else if (e.code == 'wrong-password') {
           print('Wrong password provided for that user.');
         }
       }
     }

     Future signUpWithEmailAndPassword(String email, String password) async {

       try {
         auth.UserCredential userCredential = await auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
           email: email,
           password: password,
         );
       } on auth.FirebaseAuthException catch (e) {
         if (e.code == 'weak-password') {
           print('The password provided is too weak.');
         } else if (e.code == 'email-already-in-use') {
           print('The account already exists for that email.');
         }
       } catch (e) {
         print(e);
       }

     }

     Future signOut() async{

       await auth.FirebaseAuth.instance.signOut();

     }

     Future resetPass(String email) async{
       try{
         return await _auth.sendPasswordResetEmail(email: email);
       }catch(e){
         print(e.toString());
         return null;
       }
     }
   }}