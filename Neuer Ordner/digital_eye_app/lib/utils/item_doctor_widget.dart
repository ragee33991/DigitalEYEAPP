import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/generated/i18n.dart';
import 'package:digital_eye_app/model/doctor_model.dart';
import 'package:digital_eye_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ItemDoctorWidget extends StatefulWidget {
  final DoctorModel doctor;
  bool showBoard = false;
  Function onTap;
  Function onDelete;

  ItemDoctorWidget({this.doctor, this.showBoard, this.onTap, this.onDelete});

  @override
  _ItemDoctorWidgetState createState() {
    return _ItemDoctorWidgetState();
  }
}

class _ItemDoctorWidgetState extends State<ItemDoctorWidget> {
  bool showBoard = false;
  GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 25),
      child: Container(
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                CustomCircleAvatar(child: Image.asset(R.image.avatar)),
                Positioned(
                  child: SizedBox(
                    width: 10,
                    height: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        color: Color(0xFFFF2323),
                      ),
                    ),
                  ),
                  right: 0,
                )
              ],
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.doctor.name,
                                  style: TextStyle(
                                      color: R.color.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  child: Text(
                                    widget.doctor.place,
                                    style: TextStyle(
                                        color: R.color.gray, fontSize: 14),
                                  ),
                                ),
                                InkWell(
                                  child: Row(
                                    children: <Widget>[
                                      SvgPicture.asset(R.image.ic_location),
                                      Text(
                                        S.of(context).lbl_distance(
                                            widget.doctor.distance.toString()),
                                        style: TextStyle(
                                            color: R.color.gray, fontSize: 14),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(RouterName.MAP_DOCTORS);
                                  },
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SvgPicture.asset(R.image.ic_star_blue),
                                  Container(
                                    child: Text(
                                      widget.doctor.rate.toString(),
                                      style: TextStyle(
                                          color: Color(0xFF3F67E6), fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                              InkWell(
                                child: Container(
                                    width: 30,
                                    margin: EdgeInsets.only(top: 16),
                                    child: SvgPicture.asset(R.image.ic_more)),
                                onTap: () {
                                  setState(() {
                                    showBoard = true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      )),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: Visibility(
                        visible: showBoard,
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(RouterName.CALLING_DOCTOR);
                                },
                                icon:
                                SvgPicture.asset(R.image.ic_phone_call_grey),
                              ),
                              Container(
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(RouterName.CHAT_DOCTOR);
                                  },
                                  icon: SvgPicture.asset(R.image.ic_chat_white),
                                ),
                                decoration:
                                BoxDecoration(gradient: BlueGradient()),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(R.image.ic_clipboard_grey),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    showBoard = false;
                                  });
                                },
                                icon: SvgPicture.asset(R.image.ic_exit_white),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: R.color.grey,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
      decoration: ShadowDecorationWhite(),
    );

    if (widget.onDelete == null) {
      return InkWell(
        child: child,
        onTap: widget.onTap,
      );
    }

    return InkWell(
      onTap: widget.onTap,
      child: Dismissible(
          key: _key,
          confirmDismiss: (value) async {
            switch (value) {
              case DismissDirection.endToStart:
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialogDelete(
                        context: context,
                        doctor: widget.doctor,
                        onDone: widget.onDelete));
                return false;
              default:
                return false;
            }
          },
          background: Container(
            color: R.color.white,
          ),
          secondaryBackground: Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: <Widget>[
                Expanded(child: Container()),
                Container(
                  height: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(R.image.ic_remove),
                      Text(
                        S.of(context).btn_delete,
                        style: TextStyle(fontSize: 18, color: R.color.white),
                      )
                    ],
                  ),
                  padding: EdgeInsets.only(left: 30, right: 30),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color(0xFFFF6F6F),
                    Color(0xFFFF2323),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                )
              ],
            ),
          ),
          child: child),
    );
  }
}

Widget AlertDialogDelete(
        {BuildContext context, DoctorModel doctor, Function onDone}) =>
    AlertDialog(
      contentPadding: EdgeInsets.zero,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 24, bottom: 12),
              child: Text(
                S.of(context).title_delete_doctor,
                style: TextStyle(
                  color: R.color.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(12),
              width: double.infinity,
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: S.of(context).content_delete_doctor_first,
                        style: TextStyle(color: R.color.grey, fontSize: 14)),
                    TextSpan(
                        text: doctor.name,
                        style: TextStyle(
                            color: R.color.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: S.of(context).content_delete_doctor_second,
                        style: TextStyle(color: R.color.grey, fontSize: 14))
                  ])),
            ),
            Container(
              height: 1,
              decoration: BoxDecoration(
                color: R.color.dark_black.withOpacity(0.1),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Center(
                        child: Text(
                          S.of(context).btn_cancel,
                          style: TextStyle(color: R.color.white, fontSize: 18),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12)),
                          gradient: BlueGradient()),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )),
                  Expanded(
                      child: InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Center(
                        child: Text(
                          S.of(context).btn_done,
                          style: TextStyle(color: R.color.black, fontSize: 18),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(12)),
                      ),
                    ),
                    onTap: () {
                      onDone();
                      Navigator.of(context).pop();
                    },
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
