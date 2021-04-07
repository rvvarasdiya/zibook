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
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/screens/Business/BusinessFullDetail.dart';
import 'package:zaviato/components/widgets/shared/start_rating.dart';
import 'package:zaviato/models/mybusiness/MyBusinessByCategoryRes.dart';

import '../../../../main.dart';

class BusinessViewByCategory extends StatefulWidget {
  static const route = "BusinessViewByCategory";
  // BusinessViewScree moduleType;
  String categoryId;
  TextEditingController searchbarcontroller = TextEditingController();

  BusinessViewByCategory({Map<String, dynamic> arguments}) {
    if (!isNullEmptyOrFalse(arguments)) {
      // if (!isNullEmptyOrFalse(arguments["moduleType"])) {
      //   moduleType = arguments["moduleType"];
      // }
      if (!isNullEmptyOrFalse(arguments["categoryId"])) {
        categoryId = arguments["categoryId"];
      }
    }
  }
  @override
  _BusinessViewByCategoryState createState() => _BusinessViewByCategoryState();
}

class _BusinessViewByCategoryState extends State<BusinessViewByCategory> {
  BaseList fashionBaseList;
  int page = DEFAULT_PAGE;
  List<Business> arrList = [];
  List<Business> duplicateArrayList = [];
  String appBarName = "";

  TextEditingController searchController = TextEditingController();

  bool _isShowSearchField = false;

  @override
  void initState() {
    super.initState();
    searchController.text = "";

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
  }

  callApi(bool isRefress, {bool isLoading = false}) {
    if (!isNullEmptyOrFalse(widget.categoryId)) {
      NetworkCall<MyBusinessByCategoryRes>()
          .makeCall(
        () => app
            .resolve<ServiceModule>()
            .networkService()
            .getBusinessListByCategory(widget.categoryId),
        context,
        isProgress: true,
      )
          .then((myBusinessRes) async {
        arrList.clear();
        duplicateArrayList.clear();
        arrList.addAll(myBusinessRes.data.list);
        duplicateArrayList.addAll(myBusinessRes.data.list);
        appBarName = myBusinessRes.data.list.first.categories.first.name;
        searchController.clear();
        page = page + 1;
        fashionBaseList.state.setApiCalling(false);

        fillArrayList();
        setState(() {});
      }).catchError((onError) {
        fashionBaseList.state.setApiCalling(false);
      });
    }
  }

  fillArrayList() {
    fashionBaseList.state.setApiCalling(false);
    fashionBaseList.state.listCount = arrList.length;
    fashionBaseList.state.totalCount = arrList.length;
    fashionBaseList.state.listItems = ListView.builder(
      cacheExtent: 1000,
      padding:
          EdgeInsets.symmetric(vertical: getSize(10), horizontal: getSize(15)),
      shrinkWrap: true,
      itemCount: fashionBaseList.state.listCount,
      itemBuilder: (BuildContext context, int index) {
        Business business = arrList[index];
        return getItemWidget(business, index);
      },
    );
  }

  getItemWidget(Business businessModel, int index) {
    return InkWell(
      onTap: () {
        Map<String, dynamic> arguments = {};
        arguments["model"] = businessModel;
        NavigationUtilities.pushRoute(BusinessFullDetail.route,
            args: arguments);
      },
      child: Padding(
        padding: EdgeInsets.all(getSize(10)),
        child: Container(
          // color: Colors.red,
          padding: EdgeInsets.all(getSize(15)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              new BoxShadow(
                  // color: ColorConstants.getShadowColor,
                  color: Colors.grey.withOpacity(0.2),
                  // offset: Offset(2, 6),
                  blurRadius: 7.0,
                  spreadRadius: 5.0),
            ],
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                  SizedBox(
                    width: getSize(10),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              businessModel.name,
                              style: appTheme.black16BoldTextStyle,
                            ),
                            SizedBox(
                              height: getSize(5),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                    decoration: getBoxDecoration(
                                        ColorConstants.getGreenColor, 3),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      "4.2",
                                      style: appTheme.white14RegularTextStyle,
                                    )),
                                SizedBox(width: getSize(4)),
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
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // print("----index $index");
                            // print(categoryListModel.isFavorite);
                            // print("favorite pressed ||| ");
                            // setState(() {
                            //   for (int i = 0; i < 10; i++) {
                            //     if (i == index) {
                            //       arrList[i].isFavorite = true;
                            //     }
                            //     // else{
                            //     //   arrList[i].isFavorite =false;
                            //     // }
                            //   }
                            //   // arrList[index].isFavorite = ! categoryListModel.isFavorite;
                            // });
                          },
                          // child: Icon(
                          //   (arrList[index].isFavorite)
                          //       ? Icons.favorite
                          //       : Icons.favorite_border,
                          //   size: getSize(20),
                          //   color: (arrList[index].isFavorite)
                          //       ? appTheme.colorPrimary
                          //       : null,
                          // ),
                          child: Icon(Icons.favorite),
                        )
                      ],
                    ),
                  ),
                ],
              ),
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
                      businessModel.owner.name,
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
                      businessModel.getMobileName(businessModel),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorPrimary,
      appBar: getLocalAppBar(),
      body: Container(
        height: double.infinity,
        margin: EdgeInsets.only(top: getSize(10)),
        padding: EdgeInsets.only(top: getSize(10)),
        decoration: BoxDecoration(
            color: ColorConstants.backGroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35))),
        child: fashionBaseList,
      ),
    );
  }

  getLocalAppBar() {
    return getAppBar(
      context,
      appBarName,
      textalign: TextAlign.left,
      centerTitle: false,
      leadingButton: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context)),
      backgroundColor: appTheme.colorPrimary,
      actionItems: [
        Padding(
          padding: EdgeInsets.only(right:getSize(15)),
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
                        width: getSize(350),
                        height: getSize(50),
                        padding: EdgeInsets.symmetric(horizontal: getSize(10)),
                        // padding: EdgeInsets.all(getSize(8)),
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
                              Icons.search_rounded,
                              color: Colors.black54,
                              size: getSize(20),
                            ),
                            Expanded(
                              child: TextFormField(
                                autofocus: true,
                                textAlignVertical: TextAlignVertical.center,
                                controller: searchController,
                                style: appTheme.black16RegularTextStyle,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  hintText: "Search Here",
                                  hintStyle: appTheme.black16RegularTextStyle,
                                ),
                                onChanged: (text) {
                                  searchBusiness(context, text);
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  searchController.clear();
                                  _isShowSearchField = false;
                                });
                              },
                              child: Icon(
                                Icons.clear,
                                color: Colors.black54,
                                size: getSize(20),
                              ),
                            ),
                          ],
                        ),
                      ),
            ],
          ),
        ),
      ],
    );
  }

  searchBusiness(BuildContext context, String text) {
    arrList.clear();
    if (text.length >= 0) {
      for (int i = 0; i < duplicateArrayList.length; i++) {
        if (duplicateArrayList[i]
            .name
            .toLowerCase()
            .startsWith(text.toLowerCase())) {
          arrList.add(duplicateArrayList[i]);
        }
      }
    } else {
      arrList = duplicateArrayList.map((element) => element).toList();
    }
    print(arrList.length);

    fillArrayList();
  }
}
