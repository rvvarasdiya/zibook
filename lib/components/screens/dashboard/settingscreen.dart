import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/components/screens/editDetail/editprofile.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool private = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: appTheme.colorPrimary,
          appBar: AppBar(
              actions: [Container()],
              leading: Icon(
                // Icons.arrow_back_outlined,
                Icons.add,
                color: Colors.white,
              ),
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              // toolbarHeight: getSize(160),
              backgroundColor: appTheme.colorPrimary,
              elevation: 0,
              // toolbarHeight: getSize(160),
              title: Text(
                "Setting",
                style: appTheme.white18RegularTextStyle,
              )),
          // backgroundColor: Color(0xffFAFAFA),
          // bottomNavigationBar: bottomNavigator(),
          body: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: getSize(50)),
                height: double.infinity,
                padding: EdgeInsets.only(top: getSize(50), left: 30, right: 30),
                // padding: EdgeInsets.all(30),
                width: double.infinity,
                // height: getSize(200),
                decoration: BoxDecoration(
                    color: Color(0xffFAFAFA),
                    boxShadow: [
                      new BoxShadow(
                        // color: Colors.white,
                        color: Color(0xff0000001A),
                        offset: Offset(0, -6),
                        blurRadius: 10.0,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    )),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Tome Letham",
                              textAlign: TextAlign.center,
                              style: appTheme.black22BoldTextStyle,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              editName,
                              width: getSize(20),
                              height: getSize(20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getSize(40),
                        ),
                        
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                profile,
                                width: getSize(25),
                                height: getSize(25),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Profile Edit",
                                        style: appTheme.black16BoldTextStyle),
                                    IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black,
                                        ),
                                        iconSize: getSize(18),
                                        onPressed: (){
                                          NavigationUtilities.pushRoute(EditProfileScreen.route);
                                        })
                                  ],
                                ),
                              )
                            ]),
                      
                        SizedBox(
                          height: getSize(10),
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                business,
                                width: getSize(25),
                                height: getSize(25),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("My Business",
                                        style: appTheme.black16BoldTextStyle),
                                    IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black,
                                        ),
                                        iconSize: getSize(18),
                                        onPressed: null)
                                  ],
                                ),
                              )
                            ]),
                      
                        SizedBox(
                          height: getSize(10),
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                helpIcon,
                                width: getSize(23),
                                height: getSize(23),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Help",
                                        style: appTheme.black16BoldTextStyle),
                                    IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black,
                                        ),
                                        iconSize: getSize(18),
                                        onPressed: null)
                                  ],
                                ),
                              )
                            ]),
                      
                        SizedBox(
                          height: getSize(10),
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                share,
                                width: getSize(23),
                                height: getSize(23),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Share App",
                                        style: appTheme.black16BoldTextStyle),
                                    IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black,
                                        ),
                                        iconSize: getSize(18),
                                        onPressed: null)
                                  ],
                                ),
                              )
                            ]),
                      
                      
                      ],
                    ),
                   
                    Column(
                      children: [
                        Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    logoutIcon,
                                    width: getSize(23),
                                    height: getSize(23),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Logout",
                                          style: appTheme.black16BoldTextStyle),
                                     
                                    ],
                                  )
                                ]),
                     SizedBox(
                    height: getSize(20),
                  )
                      ],
                    ),
                      
                  // SizedBox(
                  //   height: getSize(1),
                  // )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    CircleAvatar(
                        radius: getSize(
                          50,
                        ),
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(getSize(100)),
                          child: Image.asset(
                            userIcon,
                            height: getSize(100),
                            width: getSize(100),
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          alignment: Alignment.center,
                          width: getSize(100),
                          height: getSize(20),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(editImage))),
                          child: Text(
                            "Edit",
                            style: appTheme.white14RegularTextStyle,
                          )),
                    )
                  ],
                ),
              ),
            ],
          )),
    );

    // Padding(
    //   padding: EdgeInsets.only(top: getSize(160)),
    //   child: Container(
    //     width: double.infinity,
    //     // height: getSize(200),
    //     decoration: BoxDecoration(
    //         color: Color(0xffFAFAFA),
    //         boxShadow: getBoxShadow(context),
    //         borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(25),
    //           topRight: Radius.circular(25),
    //         )),
    //     child: GridView.count(
    //         shrinkWrap: true,
    //         crossAxisCount: 3,
    //         children: List.generate(12, (index) {
    //           return Container(
    //             width: getSize(90),
    //             height: getSize(50),
    //           );
    //         })),
    //   ),
    // )
  }
}
