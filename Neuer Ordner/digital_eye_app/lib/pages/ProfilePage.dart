/*



import 'package:digital_eye_app/models/user.dart';
import 'package:digital_eye_app/pages/EditProfilePage.dart';
import 'package:digital_eye_app/pages/HomePage.dart';
import 'package:digital_eye_app/widgets/HeaderWidget.dart';
import 'package:digital_eye_app/widgets/PostTileWidget.dart';
import 'package:digital_eye_app/widgets/PostWidget.dart';
import 'package:digital_eye_app/widgets/ProgressWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String userProfileId;
  ProfilePage({this.userProfileId});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String currentONline = currentUser?.id;
  bool loading = false;
  int countPost = 0;
  List<Post> postsList = [];
  String postOrientation = "grid";


  void initState(){
    getAllProfilePost();
  }

  createProfileTopView() {
    return FutureBuilder(
      future: usersReference.document(widget.userProfileId).get(),
      builder: (context,dataSnapshot){
        if(!dataSnapshot.hasData)
        {
          return circularProgress();
        }
        User user = User.fromDocument(dataSnapshot.data);
        return Padding(
          padding: EdgeInsets.all(17.0),
          child: Column(
            children:<Widget> [
              Row(
                children:<Widget>[
                  CircleAvatar(
                    radius: 45.0,
                    backgroundColor: Colors.grey,
                    //backgroundImage: CachedNetworkImageProvider(user.url),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children:<Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:<Widget>[
                            createColumns("posts",0),
                            createColumns("follower",0),
                            createColumns("postsss",0),
                          ],

                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:<Widget>[
                            createButton(),
                          ],
                        ),
                      ],

                    ),
                  )
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top:14.0),
                child: Text(
                  user.username, style: TextStyle(fontSize: 14.0,color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top:5.0),
                child: Text(
                  user.profileName, style: TextStyle(fontSize: 19.0,color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top:3.0),
                child: Text(
                  user.bio, style: TextStyle(fontSize: 18.0,color: Colors.white70),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  createButton() {
    bool ownprofile = currentONline == widget.userProfileId;
    if(ownprofile){
      return createButtonTitleAndFkt(title: "Edit Profile", performFunction:editUserProfile,);

    }
  }

  createButtonTitleAndFkt({String title, Function performFunction}){
    return Container(
      padding: EdgeInsets.only(top:3.0),
      child: FlatButton(
        onPressed: performFunction,
        child: Container(
          width: 245.0,
          height: 26.0,
          child: Text(title,style:TextStyle(color:Colors.grey,fontWeight: FontWeight.bold),),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color:Colors.grey),
            borderRadius: BorderRadius.circular(6.0),

          ),
        ),
      ),
    );

  }


  Column createColumns(String title,int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget>[
        Text(
          count.toString(),
          style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight:FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top:5.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 16.0,color: Colors.grey, fontWeight:FontWeight.w400),
          ),

        ),
      ],
    );
  }

 editUserProfile(){
    Navigator.push(context, MaterialPageRoute(builder:(context)=> EditProfilePage(currentONline:currentONline)));
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,strTitle: "Profile",),
      body: ListView(
          children:<Widget>[
            createProfileTopView(),
            Divider(),
            createListandGridPostOrient(),
            Divider(height:0.0),
            displayProfilePost(),
          ]
      ),
    );
  }

  displayProfilePost() {
    if (loading) {
      return circularProgress();
    }
    else if (postsList.isEmpty) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Icon(
                Icons.photo_library, color: Colors.grey, size: 200.0,),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("No Posts", style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold
              ),),
            ),
          ],
        ),
      );
    }

    else if (postOrientation == "grid") {
      List<GridTile> gridTiles = [];
      postsList.forEach((eachPost) {
        gridTiles.add(GridTile(child: PostTile(eachPost)));

      });
      return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1.5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: gridTiles,
      );
    }

    else if (postOrientation == "list") {
      return Column(
          children: postsList
      );
    }
  }
  getAllProfilePost() async {
    setState(() {
      loading = true;
    });
    QuerySnapshot querySnapshot = await postsReference.document(widget.userProfileId).collection("userPosts").orderBy("timestamp",descending:true ).getDocuments();

    setState(() {
      loading = false;
      countPost = querySnapshot.documents.length;
      postsList = querySnapshot.documents.map((documentSnapshot) => Post.fromDocument(documentSnapshot)).toList();
    });

  }
  createListandGridPostOrient(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            onPressed: ()=> setOrientation("grid"),
            icon: Icon(Icons.grid_on),
            color: postOrientation == "grid" ? Theme.of(context).primaryColor:Colors.grey,

          ),
          IconButton(
            onPressed: ()=> setOrientation("list"),
            icon: Icon(Icons.list),
            color: postOrientation == "list" ? Theme.of(context).primaryColor:Colors.grey,

          ),
        ],

    );
  }

  setOrientation(String orientation){
    setState(() {
      this.postOrientation= orientation;
    });
  }
}


 */