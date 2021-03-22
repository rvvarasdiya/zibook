import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/utils/math_utils.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorPrimary,
      appBar: AppBar(
        actions: [Container()],
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        // toolbarHeight: getSize(80),
        backgroundColor: appTheme.colorPrimary,
        elevation: 0,
        // toolbarHeight: getSize(160),
        title: Container(
          alignment: Alignment.topCenter,
          color: appTheme.colorPrimary,
          padding: EdgeInsets.symmetric(horizontal: getSize(30)),
          // width: double.infinity,
          // height: getSize(150),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notification",
                    style: appTheme.white16BoldTextStyle,
                  ),
                  Container(
                    width: getSize(40),
                    height: getSize(40),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(userIcon),
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          new BoxShadow(
                            color: ColorConstants.getShadowColor,
                            offset: Offset(0, 5),
                            blurRadius: 5.0,
                          ),
                        ]),

                    // NetworkImage('https://via.placeholder.com/150'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              // color: Color(0xffFAFAFA),
              color: Colors.white,
              boxShadow: [
                new BoxShadow(
                  // color: appTheme.colorPrimary
                  color: Color(0xff0000001A),
                  offset: Offset(0, -6),
                  blurRadius: 10.0,
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              )),
          child:

              ///------ Empty Screen
              //  Center(
              //   child: Image.asset(
              //     emptyNotification,
              //     width: getSize(315),
              //     height: getSize(274),
              //   ),
              // ),

              ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: getSize(30),
                    vertical: getSize(25),
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: getSize(15)),
                      padding: EdgeInsets.all(getSize(10)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff6E6E6E33),
                            // spreadRadius: 5,
                            blurRadius: 5,
                            // offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: getSize(70),
                            height: getSize(70),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff6E6E6E33),
                                  // spreadRadius: 5,
                                  blurRadius: 1,
                                  // offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Image.asset(userIcon),
                          ),
                          SizedBox(
                            height: getSize(20),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment:  MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5,left: 10),
                                      child: Text(
                                        "Business Name",
                                        style: appTheme.black16BoldTextStyle,
                                      ),
                                    ),
                                    Text(
                                      "Show",
                                      style: TextStyle(
                                          color: appTheme.colorPrimary,
                                            fontWeight: FontWeight.bold,
                                          fontFamily: 'Karla',
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,top: 5),
                                  child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                  style: appTheme.black14RegularTextStyle.copyWith(
                                    fontSize: 12,
                                    color: Color(0xff6E7073)
                                  ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  })),
    );
  }
}
