import 'package:digital_eye_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DrugsBlog.dart';

class MovieList {

  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
   static List<Movie> users = new List<Movie>() ;

  Future<Widget> quizList2() async {
    return Container(
      child: Column(
        children: [
          StreamBuilder(
            stream: quizStream,
            builder: (context, snapshot) {
              if(snapshot.connectionState != ConnectionState.done) {
                // return: show loading widget
              }
              if(snapshot.hasError) {
                // return: show error widget
              }
               users = snapshot.data ?? [];
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  Movie user = users[index];
                  return new ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("https://i.pinimg.com/564x/a6/22/55/a6225503c05cebb2b3763ab9583ecdf5.jpg"),
                    ),
                    trailing: snapshot.data.documents[index].data["quizId"],
                    title: new Text(snapshot
                        .data.documents[index].data['quizTitle'],),
                      subtitle:snapshot
                          .data.documents[index].data['quizDesc'],
                  );
                  });
            },
          )
        ],
      ),
    );
  }


  Widget quizList() {
    return Container(
      child: Column(
        children: [
          StreamBuilder(
            stream: quizStream,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data.documents[index];
                    final itemID =
                    snapshot.data.documents[index].data["quizId"];
                    print("hello" + itemID);
                    final list = snapshot.data.documents;
                    return Column(
                      children: [
                        QuizTile(
                          noOfQuestions: snapshot.data.documents.length,
                          imageUrl: snapshot.data.documents[index]
                              .data['quizImgUrl'] ??
                              "https://i.pinimg.com/564x/a6/22/55/a6225503c05cebb2b3763ab9583ecdf5.jpg",
                          title: snapshot
                              .data.documents[index].data['quizTitle'],
                          description: snapshot
                              .data.documents[index].data['quizDesc'],
                          quizId:
                          snapshot.data.documents[index].data["quizId"],
                        ),
                      ],
                    );
                  });
            },
          )
        ],
      ),
    );
  }

}




class MovieCard extends StatelessWidget {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();




  final Movie movie;

  MovieCard({this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(movie.imageUrl),
            ),
            title: Text(movie.title),
            subtitle: Text(movie.genre),
            trailing: Text(movie.year),
          ),
        ],
      ),
    );
  }
}

class MovieContainer extends StatelessWidget {
  final Movie movieContain;











  MovieContainer({this.movieContain});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150.0,
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(movieContain.imageUrl),
              ),
              Text("200"),
              Text(movieContain.year),
            ],
          ),
        ),
        SizedBox(
          width: 10.0,
        )
      ],
    );
  }
}
