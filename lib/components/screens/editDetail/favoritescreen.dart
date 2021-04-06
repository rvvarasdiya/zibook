import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/base/BaseList.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/constant/constants.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/components/screens/Business/BusinessEdit.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';
import 'package:zaviato/components/widgets/shared/start_rating.dart';
import 'package:zaviato/models/categoryListModel.dart';

class FavoriteScreen extends StatefulWidget {
  static const route = "FavoriteScreen";
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  BaseList fashionBaseList;
  int page = DEFAULT_PAGE;
  List<CategoryListModel> arrList = [];

  TextEditingController searchController = new TextEditingController();

  bool _isShowSearchField = false;

  @override
  void initState() {
    for (int i = 0; i < 10; i++) {
      CategoryListModel categoryListModel = CategoryListModel(
          "Bhavani Fashion",
          "Harshil Soni",
          "9999999999",
          "305, krishna texttiles, surat, Gujarat",
          true);
      arrList.add(categoryListModel);
    }

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
    fashionBaseList.state.listCount = arrList.length;
    fashionBaseList.state.totalCount = arrList.length;
    // arrList.addAll(savedSearchResp.data.list);
    fillArrayList();
    page = page + 1;
    fashionBaseList.state.setApiCalling(false);
    setState(() {});
  }

  fillArrayList() {
    fashionBaseList.state.listItems = ListView.builder(
      padding:
          EdgeInsets.symmetric(vertical: getSize(10), horizontal: getSize(15)),
      shrinkWrap: true,
      itemCount: fashionBaseList.state.listCount,
      itemBuilder: (BuildContext context, int index) {
        CategoryListModel savedSearchModel = arrList[index];
        return getItemWidget(savedSearchModel);
        // return Text("hello");
      },
    );
  }

  getItemWidget(CategoryListModel categoryListModel) {
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
                            categoryListModel.shopeName,
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
                          print(categoryListModel.isFavorite);
                          print("favorite pressed ||| ");
                          setState(() {
                            categoryListModel.isFavorite =
                                !categoryListModel.isFavorite;
                          });
                        },
                        child: Icon(
                          (categoryListModel.isFavorite)
                              ? OMIcons.favoriteBorder
                              : OMIcons.favorite,
                          size: getSize(20),
                          color: (categoryListModel.isFavorite)
                              ? appTheme.colorPrimary
                              : null,
                        ),
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
                    categoryListModel.ownerName,
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
                    categoryListModel.phoneNumber,
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
                      categoryListModel.address,
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
          child: fashionBaseList),
    );
  }

  getLocalAppBar() {
    return getAppBar(
      context,
      "My Favorite",
      textalign: TextAlign.left,
      centerTitle: false,
      leadingButton: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context)),
      backgroundColor: appTheme.colorPrimary,
    );
  }
}
