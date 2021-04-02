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

class BusinessView extends StatefulWidget {
  static const route = "BusinessView";
  @override
  _BusinessViewState createState() => _BusinessViewState();
}

class _BusinessViewState extends State<BusinessView> {
  BaseList fashionBaseList;
  int page = DEFAULT_PAGE;
  List<Business> arrList = [];

  TextEditingController searchController = new TextEditingController();

  bool _isShowSearchField = false;

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

      fashionBaseList.state.listCount = myBusinessRes.data.list.length;
      fashionBaseList.state.totalCount = myBusinessRes.data.count;
      page = page + 1;
      fashionBaseList.state.setApiCalling(false);
      fillArrayList();
      setState(() {});
    }).catchError((onError) {
      fashionBaseList.state.setApiCalling(false);
    });
  }

  fillArrayList() {
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
    return Padding(
      padding: EdgeInsets.all(getSize(10)),
      child: Container(
        // color: Colors.red,
        padding: EdgeInsets.all(getSize(15)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: getBoxShadow(context),
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
                                  padding: EdgeInsets.symmetric(horizontal: 5),
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
                    businessModel.getOwnerName(businessModel),
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
            Padding(
              padding: EdgeInsets.only(
                  top: getSize(15), left: getSize(28), right: getSize(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getSize(10)),
                    height: getSize(35),
                    width: getSize(130),
                    child: AppButton.flat(
                      onTap: () {
                        NavigationUtilities.pushRoute(BusinessEdit.route);
                      },
                      text: "Edit",
                      textSize: 12,
                      icon: OMIcons.edit,
                      iconSize: getSize(15),
                      backgroundColor: appTheme.colorPrimary,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getSize(10)),
                    height: getSize(35),
                    width: getSize(130),
                    child: AppButton.flat(
                      onTap: () {},
                      text: "Delete",
                      textSize: 12,
                      icon: Icons.delete_outline,
                      iconSize: getSize(15),
                      backgroundColor: appTheme.colorPrimary,
                    ),
                  )
                ],
              ),
            ),
          ],
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
      "My Business",
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
                          Icon(Icons.search),
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
                                  fontFamily: 'Segoe',
                                  fontSize: getFontSize(15),
                                  // hintSize(height),
                                  // AppStrings.hintTextsize,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                          Icon(Icons.clear),
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
