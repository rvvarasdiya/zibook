import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/components/widgets/bottomNavigation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;
  List<String> cateName = ["Fashion","Insurance","Repairings","Jewellery","Hotels","Electronics","Photography",
  "Education","IT Services","Digital Marketing","Event Management","Electronics"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        backgroundColor: appTheme.colorPrimary,
        endDrawer: ClipRRect(
           borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
                        bottomLeft : Radius.circular(40),
             ),
                  child: Drawer(child: Container(
                   
            decoration: BoxDecoration(
               color: Colors.amber,
              borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomLeft : Radius.circular(40),
                      )
            ),
          ),),
        ),
        appBar: AppBar(
          actions: [Container()],
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          // toolbarHeight: getSize(160),
            backgroundColor: appTheme.colorPrimary,
            elevation: 0,
            // toolbarHeight: getSize(160),
            title:  Container(
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
            "Suratmart",
            style: appTheme.white16BoldTextStyle,
          ),
          Container(
            width: getSize(40),
            height: getSize(40),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://via.placeholder.com/150'),
                  fit: BoxFit.fill,
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
                SizedBox(
        height: getSize(22),
                ),
                Text(
        "Hello, Annie",
        style: appTheme.white22BoldTextStyle,
                ),
                SizedBox(
        height: getSize(5),
                ),
                Text(
        "Good evening, what are you up to?",
        style: appTheme.white14RegularTextStyle
            .copyWith(color: Color(0xffCFE4FF)),
                ),
              ],
            ),
          ),
      
          ),
        // backgroundColor: Color(0xffFAFAFA),
        // bottomNavigationBar: bottomNavigator(),
        body: Container(
          height: double.infinity,
          padding: EdgeInsets.only(top:30,left: 30,right: 30),
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
                child: GridView.count(
                  padding: EdgeInsets.only(bottom: 10),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 23,
                    children: List.generate(12, (index) {
                      return Container(
                        alignment: Alignment.center,
                        // color: Colors.amber,
                        padding: EdgeInsets.only(top:getSize(10)),
                        width: getSize(90),
                        height: getSize(100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                               height: getSize(40) ,
                              // width: getSize(40) ,
                              child: Image.asset("assets/common/cate${index+1}.png",
                              fit: BoxFit.fitHeight,
                             
                              ),
                            ),

                            SizedBox(height: getSize(10),),

                            Text(cateName[index],
                            textAlign: TextAlign.center,
                            style: appTheme.black14RegularTextStyle ,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                           boxShadow: [
                  new BoxShadow(
                    color: Colors.black12,
                    // offset: Offset(0, 5),
                    blurRadius: 5.0,
                  ),
                ]
                        ),
                        
                      );
                    })),
              ),
      
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
         
   
   ),
    );
  }
}
