import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/components/widgets/bottomnavigation/bottomNavigation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        bottomNavigationBar: bottomNavigator(),
        body: Stack(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Color(0xffFAFAFA),
              height: double.infinity,
            ),
            Container(
              color: appTheme.colorPrimary,
              padding: EdgeInsets.symmetric(horizontal: getSize(30)),
              width: double.infinity,
              height: getSize(250),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getSize(25),
                  ),
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
            Padding(
              padding: EdgeInsets.only(top: getSize(160)),
              child: Container(
                width: double.infinity,
                // height: getSize(200),
                decoration: BoxDecoration(
                    color: Color(0xffFAFAFA),
                    boxShadow: getBoxShadow(context),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    children: List.generate(12, (index) {
                      return Container(
                        width: getSize(90),
                        height: getSize(50),
                      );
                    })),
              ),
            )
          ],
        ),
      ),
    );
  }
}
