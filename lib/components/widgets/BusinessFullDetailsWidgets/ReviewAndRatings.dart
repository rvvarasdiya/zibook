import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/components/screens/Business/HelpScreen.dart';
import 'package:zaviato/models/ReviewAndRatingsModel.dart';

class ReviewAndRatings extends StatefulWidget {
  @override
  _ReviewAndRatingsState createState() => _ReviewAndRatingsState();
}

class _ReviewAndRatingsState extends State<ReviewAndRatings> {
  List<ReviewAndRatingsModel> reviewAndRatingsModelList = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 10; i++) {
      ReviewAndRatingsModel reviewAndRatingsModel = ReviewAndRatingsModel();
      reviewAndRatingsModel.profilePhoto = splashBgImage;
      reviewAndRatingsModel.name = "Virang Gandhi";
      reviewAndRatingsModel.ratings = 4;
      reviewAndRatingsModel.comment =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";

      reviewAndRatingsModelList.add(reviewAndRatingsModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: getSize(30), top: getSize(15)),
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
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
                vertical: getSize(30), horizontal: getSize(30)),
            shrinkWrap: true,
            itemCount: reviewAndRatingsModelList.length,
            itemBuilder: (BuildContext context, int index) {
              ReviewAndRatingsModel reviewAndRatingsModel =
                  reviewAndRatingsModelList[index];
              return getItemWidget(reviewAndRatingsModel);
              // return Text("hello");
            },
          ),
        ),
      ],
    );
  }

  getItemWidget(ReviewAndRatingsModel reviewAndRatingsModel) {
    return InkWell(
      onTap: () {
        NavigationUtilities.pushRoute(HelpScreen.route);
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
                        Text("#####"),
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
                              Icon(Icons.message),
                              SizedBox(
                                height: getSize(5),
                              ),
                              Text(
                                "Like",
                                style: appTheme.gray16RegularTextStyle,
                              )
                            ],
                          ),
                          SizedBox(width: getSize(50)),
                          Row(
                            children: <Widget>[
                              Icon(Icons.favorite_border),
                              SizedBox(
                                height: getSize(5),
                              ),
                              Text(
                                "Comment",
                                style: appTheme.gray16RegularTextStyle,
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
}
