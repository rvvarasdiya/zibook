import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/base/BaseList.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/constant/constants.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/screens/contactus/contactusScreen.dart';
import 'package:zaviato/components/widgets/BusinessFullDetailsWidgets/ReviewAndRatings.dart';
import 'package:zaviato/models/ReviewAndRatingsModel.dart';
import 'package:zaviato/models/TabModel.dart';
import 'package:zaviato/models/categoryListModel.dart';

class BusinessFullDetail extends StatefulWidget {
  static const route = "BusinessFullDetail";
  @override
  _BusinessFullDetailState createState() => _BusinessFullDetailState();
}

class _BusinessFullDetailState extends State<BusinessFullDetail> {
  BaseList businessFullDetailBaseList;
  int page = DEFAULT_PAGE;
  List<CategoryListModel> arrList = [];
  bool _isShowSearchField = false;

  // PageController controller = PageController();
  // List<TabModel> arrTab = [];
  // int segmentedControlValue = 0;

  @override
  void initState() {
    for (int i = 0; i < 10; i++) {
      CategoryListModel categoryListModel = CategoryListModel(
          "Bhavani Fashion",
          "Harshil Soni",
          "9999999999",
          "305, krishna texttiles, surat, Gujarat");
      arrList.add(categoryListModel);
    }

    // setTabData();

    super.initState();
    businessFullDetailBaseList = BaseList(BaseListState(
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

  // setTabData() {
  //   arrTab.add(TabModel(title: "Map"));
  //   arrTab.add(TabModel(title: "SMS/Email"));
  //   arrTab.add(TabModel(title: "Write a review"));
  //   arrTab.add(TabModel(title: "Manage Campaign"));
  // }

  callApi(bool isRefress, {bool isLoading = false}) {
    businessFullDetailBaseList.state.listCount = arrList.length;
    businessFullDetailBaseList.state.totalCount = arrList.length;
    // arrList.addAll(savedSearchResp.data.list);
    fillArrayList();
    page = page + 1;
    businessFullDetailBaseList.state.setApiCalling(false);
    setState(() {});
  }

  fillArrayList() {
    businessFullDetailBaseList.state.listItems = Container(
        // height: double.infinity,
        // margin: EdgeInsets.only(top: getSize(250)),
        decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35), topRight: Radius.circular(35))),
        // child: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     // Padding(
        //     //   padding: EdgeInsets.only(top: getSize(30)),
        //     //   child: Container(
        //     //     height: getSize(50),
        //     //     // color: Colors.red,
        //     //     child: ListView(
        //     //       padding: EdgeInsets.only(left: getSize(20), right: getSize(20)),
        //     //       scrollDirection: Axis.horizontal,
        //     //       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     //       children: [
        //     //         for (int i = 0; i < arrTab.length; i++)
        //     //           setTitleOfSegment(arrTab[i].title, i)
        //     //       ],
        //     //     ),
        //     //   ),
        //     // ),
        //     // isNullEmptyOrFalse(arrTab)
        //     //     ? SizedBox()
        //     //     : SizedBox(height: getSize(16)),
        //     // isNullEmptyOrFalse(arrTab) ? SizedBox() : _segmentedControl(),
        //     // Expanded(
        //     //   child: Container(
        //     //     color: Colors.transparent,
        //     //     child: isNullEmptyOrFalse(arrList) ? SizedBox() : getPageView(),
        //     //   ),
        //     // ),

        //     // ListView.builder(
        //     //   padding: EdgeInsets.symmetric(
        //     //       vertical: getSize(15), horizontal: getSize(15)),
        //     //   shrinkWrap: true,
        //     //   itemCount: businessFullDetailBaseList.state.listCount,
        //     //   itemBuilder: (BuildContext context, int index) {
        //     //     CategoryListModel categoryListModel = arrList[index];
        //     //     return getItemWidget(categoryListModel);
        //     //     // return Text("hello");
        //     //   },
        //     // ),
        //   ],
        // ),
        child: ReviewAndRatings(),
      );
  }

  // getItemWidget(CategoryListModel categoryListModel) {
  //   return Text(categoryListModel.ownerName);
  // }

  // getPageView() {
  //   return PageView.builder(
  //     controller: controller,
  //     itemCount: isNullEmptyOrFalse(arrTab) ? 1 : arrTab.length,
  //     physics: NeverScrollableScrollPhysics(),
  //     itemBuilder: (context, position) {
  //       if (position == 0)
  //         return ReviewAndRatings();
  //       else if (position == 1)
  //         return Text("show sms/email data");
  //       else if (position == 2)
  //         return Text("write a review");
  //       else if (position == 3) return Text("Manage Campaign");

  //       // if (isNullEmptyOrFalse(arrTab)) {
  //       //   return FilterItem(arrList);
  //       // }
  //       // return FilterItem(arrList
  //       //     .where((element) => element.tab == arrTab[position].tab)
  //       //     .toList());
  //     },
  //   );
  // }

  // setTitleOfSegment(String title, int index) {
  //   return InkWell(
  //     onTap: () {
  //       setState(() {
  //         segmentedControlValue = index;
  //         controller.animateToPage(segmentedControlValue,
  //             duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  //       });
  //     },
  //     child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Container(
  //           padding: const EdgeInsets.all(4.0),
  //           decoration: BoxDecoration(
  //               border: Border.all(color: Colors.black),
  //               borderRadius: BorderRadius.circular(4)),
  //           child: Text(title),
  //         )

  //         // Column(
  //         //   children: [

  //         //     Text(
  //         //       title,
  //         //       style: segmentedControlValue == index
  //         //           ? appTheme.blackSemiBold18TitleColorblack
  //         //           : appTheme.greySemibold18TitleColor,
  //         //     ),
  //         //     Padding(
  //         //       padding: EdgeInsets.only(top: getSize(8)),
  //         //       child: Container(
  //         //           height: getSize(3),
  //         //           width: getSize(50),
  //         //           color: segmentedControlValue == index
  //         //               ? appTheme.colorPrimary
  //         //               : Colors.transparent),
  //         //     ),
  //         //   ],
  //         // ),
  //         ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.colorPrimary,
        body: Column(
          children: <Widget>[
            Container(
              // height: getSize(150),
              width: double.infinity,
              // color: appTheme.colorPrimary,
              // color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  getLocalAppBar(context),
                  Padding(
                    padding: EdgeInsets.only(
                        top: getSize(15),
                        left: getSize(15),
                        right: getSize(15),
                        bottom: getSize(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            print("Enquiry pressed ........ ");
                            NavigationUtilities.push(ContactUsScreen());
                          },
                          child: Container(
                            decoration:
                                getBoxDecoration(appTheme.colorPrimary, 5),
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Image.asset(chatIcon,
                                    width: getSize(16),
                                    height: getSize(16),
                                    color: Colors.white),
                                Text(
                                  "  Enquiry",
                                  style: appTheme.white14RegularTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: getSize(25),
                          height: getSize(25),
                          child: Image.asset(
                            whatsapp,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ) /* add child content here */,
            ),
            Expanded(child:businessFullDetailBaseList)
          ],
        ),
        // businessFullDetailBaseList,
      ),
    );
  }

  getLocalAppBar(BuildContext context) {
    return getAppBar(
      context,
      "My Business",
      textalign: TextAlign.left,
      centerTitle: false,
      leadingButton: !_isShowSearchField
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            )
          : SizedBox(),
      backgroundColor: appTheme.colorPrimary,
      actionItems: [
        Padding(
          padding: EdgeInsets.all(getSize(8)),
          child: Row(
            children: <Widget>[
              !_isShowSearchField
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          _isShowSearchField = true;
                        });
                      },
                      child: Icon(
                        Icons.search,
                        size: getSize(25),
                      ),
                    )
                  : Container(
                      width: getSize(300),
                      height: getSize(50),
                      padding: EdgeInsets.all(getSize(8)),
                      // margin: EdgeInsets.only(
                      //     top: getSize(30),
                      //     bottom: getSize(10),
                      //     left: getSize(30)),
                      // height: getSize(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: appTheme.colorPrimary,
                            size: getSize(20),
                          ),
                          Expanded(
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              // controller: searchbarcontroller,
                              style: TextStyle(
                                fontSize: getFontSize(15),
                                // fontFamily: 'Segoe'
                                // hintSize(height),
                              ),
                              maxLines: 1,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                hintText: "Search Here",
                                hintStyle: TextStyle(
                                  fontSize: getFontSize(15),
                                  // hintSize(height),
                                  // AppStrings.hintTextsize,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  _isShowSearchField = false;
                                });
                              },
                              child: Icon(
                                Icons.clear,
                                color: appTheme.colorPrimary,
                                size: getSize(20),
                              )),
                        ],
                      ),
                    ),
              SizedBox(
                width: getSize(12),
              ),
              Container(
                // alignment: Alignment.center,
                // margin: EdgeInsets.only(top: getSize(30)),
                width: getSize(40),
                height: getSize(40),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  ],
                ),

                // NetworkImage('https://via.placeholder.com/150'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
