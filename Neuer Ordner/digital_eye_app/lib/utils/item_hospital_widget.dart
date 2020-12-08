import 'package:digital_eye_app/model/hospital_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/generated/i18n.dart';
import 'package:digital_eye_app/model/doctor_model.dart';
import 'package:digital_eye_app/utils/utils.dart';

Widget ItemHospitalWidget(
        {BuildContext context, HospitalModel hospital, Function onTap}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  R.image.rectangle,
                  fit: BoxFit.fill,
                )),
            Expanded(
              child: Container(
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
                              hospital.name,
                              style: TextStyle(
                                  color: R.color.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              child: Text(
                                hospital.place,
                                style: TextStyle(
                                    color: R.color.gray, fontSize: 14),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                SvgPicture.asset(R.image.ic_location),
                                Text(
                                  S.of(context).lbl_distance(
                                      hospital.distance.toString()),
                                  style: TextStyle(
                                      color: R.color.gray, fontSize: 14),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SvgPicture.asset(R.image.ic_star_blue),
                              Container(
                                child: Text(
                                  hospital.rate.toString(),
                                  style: TextStyle(
                                      color: Color(0xFF3F67E6), fontSize: 16),
                                ),
                              )
                            ],
                          ),
                          SvgPicture.asset(R.image.ic_more)
                        ],
                      ),
                    ],
                  )),
            )
          ],
        ),
        decoration: ShadowDecorationWhite(),
      ),
    );
