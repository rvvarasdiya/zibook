import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/base/BaseApiResp.dart';
import 'package:zaviato/app/base/BaseList.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/constant/constants.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/ServiceModule.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/app/utils/pref_utils.dart';
import 'package:zaviato/components/screens/Business/BusinessFullDetail.dart';
import 'package:zaviato/components/screens/Business/BusinessView.dart';
import 'package:zaviato/models/Home/HomeScreenResponse.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

class HomeScreen extends StatefulWidget {
  final _drawerKey;
  HomeScreen(this._drawerKey);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BaseList fashionBaseList;
  int page = DEFAULT_PAGE;
  int currentIndex = 1;
  List<ListData> cateName = List<ListData>();

  @override
  void initState() {
    super.initState();
    fashionBaseList = BaseList(BaseListState(
//      imagePath: noRideHistoryFound,
      noDataMsg: APPNAME,
      noDataDesc: "No data found",
      refreshBtn: "refresh",
      enablePullDown: true,
      enablePullUp: true,
      onPullToRefress: () {
        callApi(true);
      },
      onRefress: () {
        callApi(true);
      },
      onLoadMore: () {
        callApi(false, isLoading: true);
      },
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      callApi(false);
    });
    // fetchProducts();
  }

  callApi(bool isRefress, {bool isLoading = false}) {
    // cateName.clear();
    NetworkCall<HomeScreenResponse>()
        .makeCall(
      () => app.resolve<ServiceModule>().networkService().homeScreenApi(),
      context,
      isProgress: true,
    )
        .then((homeScreenResponse) async {
      cateName.addAll(homeScreenResponse.data.list);
      print("data scusedddd");

      fashionBaseList.state.listCount = homeScreenResponse.data.list.length;
      fashionBaseList.state.totalCount = homeScreenResponse.data.count;
      page = page + 1;
      fashionBaseList.state.setApiCalling(false);
      fillArrayList();
      setState(() {});
    }).catchError((onError) {
      // if (page == DEFAULT_PAGE) {
      //   cateName.clear();
      //   fashionBaseListstate.listCount = cateName.length;
      //   diamondList.state.totalCount = cateName.length;
      //   manageDiamondSelection();
      // }
      print("error");

      fashionBaseList.state.setApiCalling(false);
    });
  }

  fillArrayList() {
    fashionBaseList.state.listItems = Container(
      height: double.infinity,
      padding: EdgeInsets.only(
        top: getSize(20),
      ),
      // padding: EdgeInsets.all(30),
      width: double.infinity,
      // height: getSize(200),
      decoration: BoxDecoration(
          color: ColorConstants.backGroundColor,
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
        // physics: ,
        padding: EdgeInsets.only(
          bottom: 10,
          right: 30,
          left: 30,
          top: 10,
        ),
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 25,
        crossAxisSpacing: 23,
        children: List.generate(cateName.length, (index) {
          return getItemWidget(cateName[index]);
        }),
      ),
    );
  }

  getItemWidget(ListData listDataModel) {
    return GestureDetector(
      onTap: () {
            // NavigationUtilities.pushRoute(BusinessView.route);
        NavigationUtilities.push(BusinessFullDetail());
        NavigationUtilities.push(BusinessFullDetail());
      },
      child: Container(
        alignment: Alignment.center,
        // color: Colors.amber,
        padding: EdgeInsets.only(top: getSize(10)),
        width: getSize(90),
        height: getSize(100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: getSize(40),
              // width: getSize(40) ,
              child: Image.asset(
                "assets/common/cate${0 + 1}.png",
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              height: getSize(10),
            ),
            Text(
              listDataModel.name,
              textAlign: TextAlign.center,
              style: appTheme.black14RegularTextStyle,
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              new BoxShadow(
                // color: ColorConstants.getShadowColor,
                color: Colors.black12,
                // offset: Offset(0, -15),
                blurRadius: 5.0,
              ),
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.colorPrimary,
        // endDrawer: ClipRRect(
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(40),
        //     bottomLeft: Radius.circular(40),
        //   ),
        //   child: Drawer(
        //     child: Container(
        //       decoration: BoxDecoration(
        //           color: Colors.amber,
        //           borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(40),
        //             bottomLeft: Radius.circular(40),
        //           )),
        //     ),
        //   ),
        // ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(200.0),
          child: Container(
            // height: 100,

            // alignment: Alignment.topCenter,
            // color: Colors.red,
            padding: EdgeInsets.symmetric(
                horizontal: getSize(30), vertical: getSize(30)),
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
                    GestureDetector(
                      onTap: (){
                         widget._drawerKey.currentState.openEndDrawer();
                      },
                      child: Container(
                        width: getSize(40),
                        height: getSize(40),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(userIcon),
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
                    ),
                  ],
                ),
                SizedBox(
                  height: getSize(22),
                ),
                Text(
                  "Hello, "+app.resolve<PrefUtils>().getUserDetails().firstName,
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
        body: fashionBaseList,
      ),
    );
  }
}
