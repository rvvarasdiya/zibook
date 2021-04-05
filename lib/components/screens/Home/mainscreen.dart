import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/components/screens/dashboard/HomeScreen/homescreen.dart';

class mainScreen extends StatefulWidget {
  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return 
            Scaffold(
              bottomNavigationBar:Container(
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
                             (currentIndex ==1 )? homeFillIcon  : homeIcon,
                              color: (currentIndex ==1 ) ?null : Color(0xffCBCBCB),
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
                              (currentIndex ==2 ) ? notifyFillIcon :notifyIcon,
                              //  color: (currentIndex ==2 ) ?appTheme.colorPrimary : Colors.grey,
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
                               (currentIndex ==3) ? chatFillIcon : chatIcon,
                              // color: (currentIndex ==3) ?appTheme.colorPrimary : Colors.grey,
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
                             (currentIndex ==4 ) ?  settingFillIcon :settingIcon,
                              //  color: (currentIndex ==4 ) ?appTheme.colorPrimary : Colors.grey,
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
              ),
            
              body: 
             Container() 
              // getScreen()
                       
            );
          
  }

//   getScreen(){
//     switch (currentIndex) {
//       case 1 :
//       return HomeScreen();
//       default:
//        return HomeScreen();
//     }
//   }
}