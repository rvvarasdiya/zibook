import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/base/BaseList.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/constant/constants.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/ServiceModule.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/components/screens/Business/BusinessEdit.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';
import 'package:zaviato/components/widgets/shared/start_rating.dart';
import 'package:zaviato/models/categoryListModel.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:zaviato/models/mybusiness/MyBusinessRes.dart';

import '../../../main.dart';

class ChatScreen extends StatefulWidget {
  static const route = "BusinessView";
  final _drawerKey;
  ChatScreen(this._drawerKey);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  BaseList businessEnquiryBaseList;
  int page = DEFAULT_PAGE;
  List<Business> arrList = [];

  TextEditingController searchController = new TextEditingController();

  bool _isShowSearchField = false;

  @override
  void initState() {
    super.initState();
    businessEnquiryBaseList = BaseList(BaseListState(
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
  }

  callApi(bool isRefress, {bool isLoading = false}) {
    NetworkCall<MyBusinessRes>()
        .makeCall(
      () => app.resolve<ServiceModule>().networkService().getMyBusinesses(),
      context,
      isProgress: true,
    )
        .then((myBusinessRes) async {
      arrList.clear();
      arrList.addAll(myBusinessRes.data.list);
      // print("data scusedddd");

      businessEnquiryBaseList.state.listCount = myBusinessRes.data.list.length;
      businessEnquiryBaseList.state.totalCount = myBusinessRes.data.count;
      page = page + 1;
      businessEnquiryBaseList.state.setApiCalling(false);
      fillArrayList();
      setState(() {});
    }).catchError((onError) {
      businessEnquiryBaseList.state.setApiCalling(false);
    });
  }

  fillArrayList() {
    businessEnquiryBaseList.state.listItems = ListView.builder(
      padding:
          EdgeInsets.symmetric(vertical: getSize(10), horizontal: getSize(15)),
      shrinkWrap: true,
      itemCount: businessEnquiryBaseList.state.listCount,
      itemBuilder: (BuildContext context, int index) {
        Business business = arrList[index];
        return getItemWidget(business, index);
        // return Text("hello");
      },
    );
  }

  getItemWidget(Business businessModel, int index) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: getSize(10)),
      padding: EdgeInsets.all(getSize(10)),
      decoration: BoxDecoration(
        color: Colors.transparent,
        // borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: getSize(50),
            height: getSize(50),
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Image.asset(userIcon),
          ),
          SizedBox(
            height: getSize(20),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                bottom: getSize(20),
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: ColorConstants.notificationBorderColor,
                          width: getSize(0.5)))),
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
                        "3:20 pm",
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
                      style: appTheme.black14RegularTextStyle
                          .copyWith(fontSize: 12, color: Color(0xff6E7073)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

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
        // leading: IconButton(icon: Icon(Icons.arrow_back), on),
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
                    "Business Enquiry",
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
        margin: EdgeInsets.only(top: getSize(10)),
        padding: EdgeInsets.only(top: getSize(10)),
        decoration: BoxDecoration(
          color: ColorConstants.backGroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: businessEnquiryBaseList,
      ),
    );
  }
}
