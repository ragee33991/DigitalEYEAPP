

/*
import 'package:digital_eye_app/models/user.dart';
import 'package:digital_eye_app/pages/HomePage.dart';
import 'package:digital_eye_app/widgets/ProgressWidget.dart';
import "package:flutter/material.dart";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class EditProfilePage extends StatefulWidget {
  final String currentONline;
  EditProfilePage({
    this.currentONline
});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  TextEditingController profileNameTxtController = TextEditingController();
  TextEditingController bioTextController = TextEditingController();
  final _scaffolgKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  User user;
  bool _profileNameValid = true;
  bool _biovalid = true;

  void initState(){
    super.initState();
    getAndDisplayUserInfor();
  }


  getAndDisplayUserInfor() async{
    setState(() {
      loading= true;
    });
    DocumentSnapshot documentSnapshot = await usersReference.document(widget.currentONline).get();
    user = User.fromDocument(documentSnapshot);

    profileNameTxtController.text = user.profileName;
    bioTextController.text = user.bio;
    setState(() {
      loading = false;
    });

  }

  updatedata(){
    setState(() {
      profileNameTxtController.text.trim().length < 3|| profileNameTxtController.text.isEmpty? _profileNameValid = false :_profileNameValid= true;
      bioTextController.text.trim().length> 110? _biovalid = false :_biovalid= true;


    });
    if(_biovalid&& _profileNameValid){
      usersReference.document(widget.currentONline).updateData({
        "profileName": profileNameTxtController.text,
        "bio":bioTextController.text,
      });
      SnackBar successsnackbar = SnackBar(content: Text("Profile upgrade success"),);
      _scaffolgKey.currentState.showSnackBar(successsnackbar);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolgKey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Edit Profile",style: TextStyle(color: Colors.white),),
          actions:<Widget> [
            IconButton(icon: Icon(Icons.done,color: Colors.white,size:30.0,), onPressed: ()=> Navigator.pop(context),),

          ],
        ),
      body: loading? circularProgress():ListView(
        children:<Widget>[
          Container(
            child:Column(
              children:<Widget> [
                Padding(
                  padding: EdgeInsets.only(top: 15.0,bottom: 7.0),
                  child: CircleAvatar(
                    radius: 52.0,
                    backgroundImage: CachedNetworkImageProvider(user.url),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(children:<Widget> [createProfileNametext(),createBioText()],)
                ),
                Padding(
                  padding: EdgeInsets.only(top: 29.0,left: 50.0,right:50.0),
                  child: RaisedButton(
                     onPressed:updatedata,
                    child: Text(
                    "Update",
                     style: TextStyle(color: Colors.black,fontSize: 16.0),
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(top: 10.0,left: 50.0,right:50.0),
                child: RaisedButton(
                 color: Colors.red,
                  onPressed:LogoutUser,
                  child: Text(
                     "logout",
                    style: TextStyle(color: Colors.white,fontSize: 14.0),
                  ),
                ),
              ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  LogoutUser() async {
    await gSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

  }


Column createProfileNametext() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 13.0),
        child: Text(
          "Profile Name", style: TextStyle(color: Colors.grey),
        ),
      ),
      TextField(
        style: TextStyle(color: Colors.white),
        controller: profileNameTxtController,
        decoration: InputDecoration(
          hintText: "Write profile name here",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintStyle: TextStyle(color: Colors.grey),
          errorText: _profileNameValid ? null : "Profile name is very short",
        ),
      )
    ],
  );
}

  Column createBioText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 13.0),
          child: Text(
            "Bio", style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.white),
          controller: bioTextController,
          decoration: InputDecoration(
            hintText: "Write bio here",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintStyle: TextStyle(color: Colors.grey),
            errorText: _biovalid ? null : "Bio is very long",
          ),
        )
      ],
    );
  }



}

*/
