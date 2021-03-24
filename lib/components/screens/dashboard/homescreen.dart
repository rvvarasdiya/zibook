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
import 'package:zaviato/components/screens/Business/BusinessFullDetail.dart';
import 'package:zaviato/models/Home/HomeScreenResponse.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BaseList fashionBaseList;
  int page = DEFAULT_PAGE;
  int currentIndex = 1;
  List<ListData> cateName = List<ListData>();
  // List<String> cateName = [
  //   "Fashion",
  //   "Insurance",
  //   "Repairings",
  //   "Jewellery",
  //   "Hotels",
  //   "Electronics",
  //   "Photography",
  //   "Education",
  //   "IT Services",
  //   "Digital Marketing",
  //   "Event Management",
  //   "Electronics"
  // ];

  @override
  void initState() {
    super.initState();
//     fashionBaseList = BaseList(BaseListState(
// //      imagePath: noRideHistoryFound,
//       noDataMsg: APPNAME,
//       noDataDesc: "No data found",
//       refreshBtn: "refresh",
//       enablePullDown: false,
//       enablePullUp: false,
//       onPullToRefress: () {
//         callApi(true);
//       },
//       onRefress: () {
//         callApi(true);
//       },
//       onLoadMore: () {
//         callApi(false, isLoading: true);
//       },
//     ));

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       callApi(false);
//     });
    fetchProducts();
  }

  Future fetchProducts() async {
    final response = await http.get(
        'https://secret-citadel-73539.herokuapp.com/api/v1/customer/category/paginate');
    if (response.statusCode == 200) {
      print(response.toString());
      return response;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  callApi(bool isRefress, {bool isLoading = false}) {
    NetworkCall<BaseApiResp>()
        .makeCall(
      () => app.resolve<ServiceModule>().networkService().homeScreenApi(),
      context,
      isProgress: false,
    )
        .then((homeScreenResponse) async {
      // cateName.addAll(homeScreenResponse.data.list);
      print("data scusedddd");
      // switch (moduleType) {
      //   case DiamondModuleConstant.MODULE_TYPE_MY_CART:
      //   case DiamondModuleConstant.MODULE_TYPE_MY_WATCH_LIST:
      //   case DiamondModuleConstant.MODULE_TYPE_MY_ENQUIRY:
      //   case DiamondModuleConstant.MODULE_TYPE_MY_OFFER:
      //   case DiamondModuleConstant.MODULE_TYPE_MY_REMINDER:
      //   case DiamondModuleConstant.MODULE_TYPE_MY_COMMENT:
      //   case DiamondModuleConstant.MODULE_TYPE_MY_OFFICE:
      //   case DiamondModuleConstant.MODULE_TYPE_MY_BID:
      //     // case DiamondModuleConstant.MODULE_TYPE_MY_DEMAND:
      //     List<DiamondModel> list = [];
      //     DiamondModel diamondModel;
      //     TrackDiamonds trackDiamonds;
      //     diamondListResp.data.list.forEach((element) {
      //       if (element.diamonds != null) {
      //         element.diamonds.forEach((diamonds) {
      //           switch (moduleType) {
      //             case DiamondModuleConstant.MODULE_TYPE_MY_OFFICE:
      //               diamonds.memoNo = element.id;
      //               diamonds.date = element.date;
      //               diamonds.purpose = element.purpose;
      //               break;
      //           }
      //           list.add(diamonds);
      //         });
      //       } else {
      //         diamondModel = element.diamond;
      //         trackDiamonds = TrackDiamonds(
      //             id: diamondModel.id,
      //             trackId: element.id,
      //             remarks: element.remarks,
      //             reminderDate: element.reminderDate);
      //         switch (moduleType) {
      //           case DiamondModuleConstant.MODULE_TYPE_MY_CART:
      //             diamondModel.trackItemCart = trackDiamonds;
      //             break;
      //           case DiamondModuleConstant.MODULE_TYPE_MY_WATCH_LIST:
      //             diamondModel.trackItemWatchList = trackDiamonds;
      //             diamondModel.newDiscount = element.newDiscount;
      //             break;
      //           case DiamondModuleConstant.MODULE_TYPE_MY_ENQUIRY:
      //             diamondModel.trackItemEnquiry = trackDiamonds;
      //             break;
      //           case DiamondModuleConstant.MODULE_TYPE_MY_OFFER:
      //             diamondModel.createdAt = element.createdAt;
      //             diamondModel.trackItemOffer = trackDiamonds;
      //             diamondModel.memoNo = element.memoNo;
      //             diamondModel.offerValidDate = element.offerValidDate;
      //             diamondModel.offerStatus = element.offerStatus;
      //             diamondModel.newAmount = element.newAmount;
      //             diamondModel.newDiscount = element.newDiscount;
      //             diamondModel.newPricePerCarat = element.newPricePerCarat;
      //             diamondModel.remarks = element.remarks;
      //             break;
      //           case DiamondModuleConstant.MODULE_TYPE_MY_REMINDER:
      //             diamondModel.trackItemReminder = trackDiamonds;
      //             break;
      //           case DiamondModuleConstant.MODULE_TYPE_MY_COMMENT:
      //             diamondModel.trackItemComment = trackDiamonds;
      //             break;

      //           case DiamondModuleConstant.MODULE_TYPE_MY_BID:
      //             diamondModel.trackItemBid = trackDiamonds;
      //             break;
      //         }
      //         list.add(diamondModel);
      //       }
      //     });
      //     arraDiamond.addAll(list);
      //     break;

      //   default:
      //     arraDiamond.addAll(diamondListResp.data.diamonds);
      //     break;
      // }
      // diamondConfig.setMatchPairItem(arraDiamond);

      // fashionBaseList.state.listCount = homeScreenResponse.data.list.length;
      // fashionBaseList.state.totalCount = homeScreenResponse.data.count;

      fashionBaseList.state.listCount = 10;
      fashionBaseList.state.totalCount = 10;
      // manageDiamondSelection();
      //callBlockApi(isProgress: true);
      page = page + 1;
      fashionBaseList.state.setApiCalling(false);
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
        top: 20,
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
          getItemWidget(cateName[index]);
        }),
      ),
    );
  }

  getItemWidget(ListData listDataModel) {
    return GestureDetector(
      onTap: () {
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
                color: ColorConstants.getShadowColor,
                // offset: Offset(0, 5),
                blurRadius: 3.0,
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
        endDrawer: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            bottomLeft: Radius.circular(40),
          ),
          child: Drawer(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  )),
            ),
          ),
        ),
        appBar: AppBar(
          actions: [Container()],
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          // toolbarHeight: getSize(160),
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
                      "Suratmart",
                      style: appTheme.white16BoldTextStyle,
                    ),
                    Container(
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
        body: fashionBaseList,
      ),
    );
  }
}
