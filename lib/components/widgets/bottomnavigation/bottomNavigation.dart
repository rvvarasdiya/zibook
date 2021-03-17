import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';

class bottomNavigator extends StatefulWidget {
  @override
  _bottomNavigatorState createState() => _bottomNavigatorState();
}

class _bottomNavigatorState extends State<bottomNavigator> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return 
            Container(
              width: double.infinity,
              height: getSize(60),
              decoration: BoxDecoration(
                color: Colors.white,
                     boxShadow: [new BoxShadow(
                              color: Color(0xff0000001A),
                              offset: Offset(0,-3),
                              blurRadius: 10.0,
                            ),],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    GestureDetector(
                      onTap: (){
                       setState(() {
                           currentIndex =1;
                         });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: getSize(24),
                            width: getSize(24),
                            child: Image.asset(
                            homeIcon,
                            color: (currentIndex ==1 ) ?appTheme.colorPrimary : Colors.grey,
                            fit: BoxFit.fill,
                  ),
                          ),
                          (currentIndex ==1 ) ?CircleAvatar(
                            radius: getSize(3), 
                            backgroundColor:  appTheme.colorPrimary ,
                          ):Container()
                        ],
                      ),
                    ),
                    GestureDetector(
                       onTap: (){
                        setState(() {
                           currentIndex =2;
                         });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: getSize(24),
                            width: getSize(24),
                            child: Image.asset(
                            notifyIcon,
                             color: (currentIndex ==2 ) ?appTheme.colorPrimary : Colors.grey,
                            fit: BoxFit.fill,
                  ),
                          ),
                          (currentIndex ==2 ) ?CircleAvatar(
                            radius: getSize(3), 
                            backgroundColor:  appTheme.colorPrimary ,
                          ):Container()
                        ],
                      ),
                    ),
                    GestureDetector(
                       onTap: (){
                         setState(() {
                           currentIndex =3;
                         });
                      },
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Container(
                            height: getSize(24),
                            width: getSize(24),
                            child: Image.asset(
                            chatIcon,
                            color: (currentIndex ==3) ?appTheme.colorPrimary : Colors.grey,
                            fit: BoxFit.fill,
                  ),
                      ),
                      (currentIndex ==3 ) ?CircleAvatar(
                            radius: getSize(3), 
                            backgroundColor:  appTheme.colorPrimary ,
                          ):Container()
                         ],
                       ),
                    ),
                    GestureDetector(
                       onTap: (){
                         setState(() {
                           currentIndex =4;
                         });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: getSize(24),
                            width: getSize(24),
                            child: Image.asset(
                            settingIcon,
                             color: (currentIndex ==4 ) ?appTheme.colorPrimary : Colors.grey,
                            fit: BoxFit.fill,
                  ),
                          ),
                          (currentIndex ==4 ) ?CircleAvatar(
                            radius: getSize(3), 
                            backgroundColor:  appTheme.colorPrimary ,
                          ):Container()
                        ],
                      ),
                    ),
                ],
              ),
            );
          
  }
}