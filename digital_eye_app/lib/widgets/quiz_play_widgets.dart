import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:flutter/material.dart';


class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;

  OptionTile(
      {this.description, this.correctAnswer, this.option, this.optionSelected});



  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.all(15.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 28,
            width: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.optionSelected == widget.description
                        ? Colors.blueAccent.withOpacity(0.7)
                        : Colors.grey,
                    width: 1.5),
                color: widget.optionSelected == widget.description
                    ? Colors.blueAccent.withOpacity(0.7)
                    : Colors.white,
                borderRadius: BorderRadius.circular(24)
            ),
            child: Text(
              widget.option,
              style: TextStyle(
                color: widget.optionSelected == widget.description
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
         // Text(widget.description, style: TextStyle(
           //   fontSize: 17,
             // color: Colors.black54

              //setCommonText(widget.description, Colors.black, 18.0, FontWeight.w500, 1),
          setCommonText(widget.description, Colors.black, 17.0, FontWeight.w300, 1),

          //   ),)
        ],
      ),
    );
  }
}






class NoOfQuestionTile extends StatefulWidget {
  final String text;
  final int number;

  NoOfQuestionTile({this.text, this.number});

  @override
  _NoOfQuestionTileState createState() => _NoOfQuestionTileState();
}


class _NoOfQuestionTileState extends State<NoOfQuestionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14)
                ),
                color: Colors.blueAccent.withOpacity(0.7)
            ),
            child: Text(
              "${widget.number}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                color: Colors.black54
            ),
            child: Text(
              widget.text,
              style: TextStyle(color: Colors.white),
            ),
          ),

        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}