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
import 'package:zaviato/components/screens/dashboard/HomeScreen/BusinessByCategoryScreen.dart';

import '../../../main.dart';

class NotificationScreen extends StatefulWidget {
  final _drawerKey;
  NotificationScreen(this._drawerKey);
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

    BaseList fashionBaseList;
  int page = DEFAULT_PAGE;
  List<String> notificationList = [];
    @override
  void initState() {
    super.initState();
    for(int i=0; i<10;i++ ){
      Notification notification = Notification(businessName: "BusinessName",content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.");

    }
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
    NetworkCall<BaseApiResp>()
        .makeCall(
      () => app.resolve<ServiceModule>().networkService().notificationScreenApi(),
      context,
      isProgress: true,
    )
        .then((apiResponse) async {
      
      print("data scusedddd");

      // fashionBaseList.state.listCount = apiResponse.data.list.length;
      // fashionBaseList.state.totalCount = apiResponse.data.count;
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
    fashionBaseList.state.listItems = ListView.builder(
          cacheExtent: 1000,
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
                  new BoxShadow(
                    // color: ColorConstants.getShadowColor,
                    color: Colors.grey.withOpacity(0.2),
                    // offset: Offset(2, 6),
                    blurRadius: 7.0,
                    spreadRadius: 5.0,
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
                        new BoxShadow(
                          // color: ColorConstants.getShadowColor,
                          color: Colors.grey.withOpacity(0.2),
                          // offset: Offset(2, 6),
                          blurRadius: 3.0,
                          spreadRadius: 2.0,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 10),
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
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                            style: appTheme.black14RegularTextStyle.copyWith(
                                fontSize: 12, color: Color(0xff6E7073)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
     
  }

  // getItemWidget(Notification notification) {
  //   return GestureDetector(
  //     onTap: () {
  //       // NavigationUtilities.pushRoute(BusinessView.route);
  //       // NavigationUtilities.push(BusinessFullDetail());
  //       // NavigationUtilities.pushRoute(BusinessFullDetail.route);
  //       Map<String, dynamic> arguments = {};
  //       // arguments["moduleType"] = BusinessViewScree.HomeScreen;
  //       arguments["categoryId"] = listDataModel.sId;
  //       NavigationUtilities.pushRoute(BusinessViewByCategory.route,
  //           args: arguments);
  //     },
  //     child:
  //      Container(
  //       alignment: Alignment.center,
  //       // color: Colors.amber,
  //       padding: EdgeInsets.only(top: getSize(10)),
  //       width: getSize(90),
  //       height: getSize(100),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Container(
  //             height: getSize(40),
  //             // width: getSize(40) ,
  //             child: Image.asset(
  //               "assets/common/cate${0 + 1}.png",
  //               fit: BoxFit.fitHeight,
  //             ),
  //           ),
  //           SizedBox(
  //             height: getSize(10),
  //           ),
  //           Text(
  //             listDataModel.name,
  //             textAlign: TextAlign.center,
  //             style: appTheme.black14RegularTextStyle,
  //           )
  //         ],
  //       ),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(5),
  //         boxShadow: [
  //           new BoxShadow(
  //             // color: ColorConstants.getShadowColor,
  //             color: Colors.grey.withOpacity(0.2),
  //             // offset: Offset(2, 6),
  //             blurRadius: 7.0,
  //             spreadRadius: 5.0,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
                  GestureDetector(
                    onTap: () {
                      widget._drawerKey.currentState.openEndDrawer();
                    },
                    child: Container(
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
                        ],
                      ),

                      // NetworkImage('https://via.placeholder.com/150'),
                    ),
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
          ),
        ),
        child: fashionBaseList
             ),
    );
  }
}


class Notification{
  String businessName;
  String content;

  Notification({this.businessName,this.content});
}