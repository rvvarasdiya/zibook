import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
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
import 'package:zaviato/components/screens/feedback/feedbackscreen.dart';
import 'package:zaviato/components/widgets/BusinessFullDetailsWidgets/ReviewAndRatings.dart';
import 'package:zaviato/components/widgets/shared/start_rating.dart';
import 'package:zaviato/models/ReviewAndRatingsModel.dart';
import 'package:zaviato/models/TabModel.dart';
import 'package:zaviato/models/categoryListModel.dart';
import 'package:zaviato/models/mybusiness/MyBusinessByCategoryRes.dart';

class BusinessFullDetail extends StatefulWidget {
  static const route = "BusinessFullDetail";
  Business businessModel;

  BusinessFullDetail({Map<String, dynamic> arguments}) {
    if (!isNullEmptyOrFalse(arguments)) {
      // if (!isNullEmptyOrFalse(arguments["moduleType"])) {
      //   moduleType = arguments["moduleType"];
      // }
      if (!isNullEmptyOrFalse(arguments["model"])) {
        businessModel = arguments["model"];
      }
    }
  }

  @override
  _BusinessFullDetailState createState() => _BusinessFullDetailState();
}

class _BusinessFullDetailState extends State<BusinessFullDetail> {
  BaseList businessFullDetailBaseList;
  int page = DEFAULT_PAGE;
  // List<CategoryListModel> arrList = [];
  bool _isShowSearchField = false;
  List<ReviewAndRatingsModel> reviewAndRatingsModelList = [];

  // PageController controller = PageController();
  // List<TabModel> arrTab = [];
  // int segmentedControlValue = 0;

  @override
  void initState() {
    super.initState();
    // for (int i = 0; i < 10; i++) {
    //   CategoryListModel categoryListModel = CategoryListModel(
    //       "Bhavani Fashion",
    //       "Harshil Soni",
    //       "9999999999",
    //       "305, krishna texttiles, surat, Gujarat",
    //       false);
    //   arrList.add(categoryListModel);
    // }
    for (int i = 0; i < 10; i++) {
      ReviewAndRatingsModel reviewAndRatingsModel = ReviewAndRatingsModel();
      reviewAndRatingsModel.profilePhoto = splashBgImage;
      reviewAndRatingsModel.name = "Virang Gandhi";
      reviewAndRatingsModel.ratings = 4;
      reviewAndRatingsModel.comment =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";

      reviewAndRatingsModelList.add(reviewAndRatingsModel);
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

  callApi(bool isRefress, {bool isLoading = false}) {
    businessFullDetailBaseList.state.listCount =
        reviewAndRatingsModelList.length;
    businessFullDetailBaseList.state.totalCount =
        reviewAndRatingsModelList.length;
    // arrList.addAll(savedSearchResp.data.list);
    fillArrayList();
    page = page + 1;
    businessFullDetailBaseList.state.setApiCalling(false);
    setState(() {});
  }

  fillArrayList() {
    businessFullDetailBaseList.state.listItems = ListView.builder(
      padding: EdgeInsets.symmetric(
        // vertical: getSize(30),
        horizontal: getSize(30),
      ),
      shrinkWrap: true,
      itemCount: reviewAndRatingsModelList.length,
      itemBuilder: (BuildContext context, int index) {
        ReviewAndRatingsModel reviewAndRatingsModel =
            reviewAndRatingsModelList[index];
        return getItemWidget(reviewAndRatingsModel);
        // return Text("hello");
      },
    );
  }

  getItemWidget(ReviewAndRatingsModel reviewAndRatingsModel) {
    return InkWell(
      onTap: () {
        // NavigationUtilities.pushRoute(HelpScreen.route);
      },
      child: Container(
        padding: EdgeInsets.all(getSize(10)),
        width: double.infinity,
        // height: getSize(200),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: appTheme.textGreyColor)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: getSize(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(reviewAndRatingsModel.name,
                            style: appTheme.black16BoldTextStyle),
                        SizedBox(
                          width: getSize(8),
                        ),
                        SmoothStarRating(
                            onRatingChanged: (value) {
                              // print("------------$rating   --------- $value");
                              // setState(() {
                              //   rating = value;
                              // });
                            },
                            rating: 4.2,
                            allowHalfRating: false,
                            starCount: 5,
                            size: getSize(15),
                            color: appTheme.colorPrimary,
                            borderColor: appTheme.dividerColor,
                            spacing: 0.0),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: getSize(5)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            reviewAndRatingsModel.comment,
                            style: appTheme.gray14RegularTextStyle,
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: getSize(20)),
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset(
                                chatIcon,
                                height: getSize(14),
                                width: getSize(14),
                              ),
                              SizedBox(
                                width: getSize(7),
                              ),
                              Text(
                                "Like",
                                style: appTheme.gray14RegularTextStyle,
                              )
                            ],
                          ),
                          SizedBox(width: getSize(50)),
                          Row(
                            children: <Widget>[
                              Icon(Icons.favorite_border,
                                  size: getSize(15), color: appTheme.grayColor),
                              SizedBox(
                                width: getSize(7),
                              ),
                              Text(
                                "Comment",
                                style: appTheme.gray14RegularTextStyle,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.colorPrimary,
        body: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("Enquiry pressed ........ ");
                                NavigationUtilities.pushRoute(
                                    ContactUsScreen.route);
                              },
                              child: Container(
                                decoration: getBoxDecoration(
                                    appTheme.whiteColor.withOpacity(0.2), 5),
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
                            SizedBox(
                              width: getSize(10),
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Rating pressed ........ ");
                                Map<String, dynamic> arguments = {};
                                arguments["model"] = widget.businessModel;
                                NavigationUtilities.pushRoute(
                                    FeedbackScreen.route,args: arguments);
                              },
                              child: Container(
                                decoration: getBoxDecoration(
                                    appTheme.whiteColor.withOpacity(0.2), 5),
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Icon(Icons.star_half,
                                        size: getSize(16),
                                        color: appTheme.whiteColor),
                                    // Image.asset(chatIcon,
                                    //     width: getSize(16),
                                    //     height: getSize(16),
                                    //     color: Colors.white),
                                    Text(
                                      "  Add Rating",
                                      style: appTheme.white14RegularTextStyle,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            launchWhatsApp();
                          },
                          child: Container(
                            width: getSize(25),
                            height: getSize(25),
                            child: Image.asset(
                              whatsapp,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ) /* add child content here */,
            ),
            Expanded(
              child: Container(
                // height: double.infinity,
                // margin: EdgeInsets.only(top: getSize(250)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35))),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getSize(30)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: getSize(15)),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.person,
                                  size: getSize(18),
                                ),
                                SizedBox(
                                  width: getSize(10),
                                ),
                                Text(
                                  widget.businessModel.owner.name,
                                  style: appTheme.black14RegularTextStyle,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: getSize(15)),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.call,
                                  size: getSize(18),
                                ),
                                SizedBox(
                                  width: getSize(10),
                                ),
                                Text(
                                  widget.businessModel
                                      .getMobileName(widget.businessModel),
                                  style: appTheme.black14RegularTextStyle,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: getSize(15)),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: getSize(18),
                                ),
                                SizedBox(
                                  width: getSize(10),
                                ),
                                Expanded(
                                  child: Text(
                                    "hello it's a dummy address...",
                                    style: appTheme.black14RegularTextStyle,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: getSize(30),
                          top: getSize(20),
                          bottom: getSize(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Reviews & Ratings",
                            style: appTheme.black18BoldTextStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getSize(8),
                    ),
                    Expanded(
                      child: Container(
                        child: businessFullDetailBaseList,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(
            //   child: Container(
            //     child: businessFullDetailBaseList,
            //   ),
            // ),
          ],
        ),
        // businessFullDetailBaseList,
      ),
    );
  }

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+917572996471',
      text: "Hey! I'm inquiring about your business...",
    );
    await launch('$link');
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
    );
  }
}
