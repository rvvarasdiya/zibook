import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/base/BaseList.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/constant/constants.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/components/screens/Business/BusinessFullDetail.dart';
import 'package:zaviato/models/categoryListModel.dart';

class BusinessDetailScreen extends StatefulWidget {
  static const route = "fashionScreen";
  @override
  _BusinessDetailScreenState createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
  BaseList fashionBaseList;
  int page = DEFAULT_PAGE;
  List<CategoryListModel> arrList = [];

  TextEditingController searchController = new TextEditingController();

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
    fashionBaseList.state.listItems = Container(
      height: double.infinity,
      margin: EdgeInsets.only(top: getSize(10)),
      padding: EdgeInsets.only(top: getSize(15)),
      decoration: BoxDecoration(
          color: ColorConstants.backGroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
            vertical: getSize(15), horizontal: getSize(15)),
        shrinkWrap: true,
        itemCount: fashionBaseList.state.listCount,
        itemBuilder: (BuildContext context, int index) {
          CategoryListModel savedSearchModel = arrList[index];
          return getItemWidget(savedSearchModel);
          // return Text("hello");
        },
      ),
    );
  }

  getItemWidget(CategoryListModel categoryListModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // color: Colors.red,
        padding: EdgeInsets.all(getSize(8)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getSize(15)),
          boxShadow: [
            BoxShadow(
              // color: Colors.red,
              spreadRadius: 3.0,
              color: ColorConstants.getBoxShdowColor2,
              blurRadius: 3.0
            )
          ],
          color: Colors.white
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
                      image: NetworkImage('https://via.placeholder.com/150'),
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
                          Row(
                            children: <Widget>[
                              Text("4.2"),
                              SizedBox(width: getSize(4)),
                              Text("#####"),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.favorite_border)
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_1),
        backgroundColor: appTheme.colorPrimary,
        onPressed: (){
          NavigationUtilities.pushRoute(BusinessFullDetail.route);  
        },
      ),
      backgroundColor: appTheme.colorPrimary,
      body: Column(
        children: <Widget>[
          Container(
            // height: getSize(200),
            width: double.infinity,
            padding: EdgeInsets.all(getSize(14)),
            decoration: BoxDecoration(
                color: appTheme.colorPrimary,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: appTheme.colorPrimary.withOpacity(1),
                  width: 0.5,
                )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: Container(
                    padding: EdgeInsets.all(getSize(8)),
                    margin: EdgeInsets.only(
                        top: getSize(30),
                        bottom: getSize(10),
                        left: getSize(30)),
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
                ),
                Flexible(
                  child: Container(
                    // alignment: Alignment.center,
                    margin: EdgeInsets.only(top: getSize(30)),
                    width: getSize(40),
                    height: getSize(40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage('https://via.placeholder.com/150'),
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
                ),
              ],
            ),
          ),
          Expanded(
            child: fashionBaseList,
          )
        ],
      ),
    );
  }
}

// Container(
//           // height: getSize(200),
//           width: double.infinity,
//           padding: EdgeInsets.all(getSize(14)),
//           decoration: BoxDecoration(
//               color: appTheme.colorPrimary,
//               borderRadius: BorderRadius.circular(5.0),
//               border: Border.all(
//                 color: appTheme.colorPrimary.withOpacity(1),
//                 width: 0.5,
//               )),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Flexible(
//                 flex: 5,
//                 fit: FlexFit.tight,
//                 child: Container(
//                   padding: EdgeInsets.all(getSize(8)),
//                   margin: EdgeInsets.only(
//                       top: getSize(30),
//                       bottom: getSize(10),
//                       left: getSize(30)),
//                   // height: getSize(10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(25.0),
//                     border: Border.all(
//                       color: Colors.black,
//                       width: 0.5,
//                     ),
//                   ),
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.search),
//                       Expanded(
//                         child: TextFormField(
//                           textAlignVertical: TextAlignVertical.center,
//                           // controller: searchbarcontroller,
//                           style: TextStyle(
//                             fontSize: getFontSize(15),
//                             // fontFamily: 'Segoe'
//                             // hintSize(height),
//                           ),
//                           maxLines: 1,
//                           decoration: InputDecoration(
//                             fillColor: Colors.transparent,
//                             border: InputBorder.none,
//                             isDense: true,
//                             contentPadding: const EdgeInsets.only(
//                               left: 10,
//                             ),
//                             hintText: "Search Here",
//                             hintStyle: TextStyle(
//                               fontFamily: 'Segoe',
//                               fontSize: getFontSize(11),
//                               // hintSize(height),
//                               // AppStrings.hintTextsize,
//                               color: Colors.white.withOpacity(0.8),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Icon(Icons.clear),
//                     ],
//                   ),
//                 ),
//               ),
//               Flexible(
//                 child: Container(
//                   // alignment: Alignment.center,
//                   margin: EdgeInsets.only(top: getSize(30)),
//                   width: getSize(40),
//                   height: getSize(40),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     image: DecorationImage(
//                       image: NetworkImage('https://via.placeholder.com/150'),
//                       fit: BoxFit.fill,
//                     ),
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       new BoxShadow(
//                         color: ColorConstants.getShadowColor,
//                         offset: Offset(0, 5),
//                         blurRadius: 5.0,
//                       ),
//                     ],
//                   ),

//                   // NetworkImage('https://via.placeholder.com/150'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // Expanded(child: fashionBaseList),

// Padding(
//               padding: EdgeInsets.symmetric(vertical: getSize(25),horizontal: getSize(30)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Flexible(child: Icon(Icons.search)),
//                       Flexible(
//                                               child: TextFormField(
//                           textAlignVertical: TextAlignVertical.center,
//                           // controller: searchbarcontroller,
//                           style: TextStyle(
//                             fontSize: getFontSize(10),
//                             // fontFamily: 'Segoe'
//                             // hintSize(height),
//                           ),
//                           maxLines: 1,
//                           decoration: InputDecoration(
//                             fillColor: Colors.transparent,
//                             border: InputBorder.none,
//                             isDense: true,
//                             contentPadding: const EdgeInsets.only(
//                               left: 0,
//                             ),
//                             hintText: "Search Here",
//                             hintStyle: TextStyle(
//                               fontFamily: 'Segoe',
//                               fontSize: getFontSize(11),
//                               // hintSize(height),
//                               // AppStrings.hintTextsize,
//                               color: Colors.white.withOpacity(0.8),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Flexible(child: Icon(Icons.clear))
//                     ],
//                   ),
//                   Icon(Icons.person)
//                 ],
//               ),
//             ),
