import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/components/widgets/shared/start_rating.dart';
import 'package:zaviato/models/ReviewAndRatingsModel.dart';
import 'package:zaviato/models/mybusiness/MyBusinessByCategoryRes.dart';

class ReviewAndRatings extends StatefulWidget {
  static const route = "ReviewAndRatings";
  Business businessModel;

  ReviewAndRatings(this.businessModel);

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
          padding:  EdgeInsets.symmetric(horizontal:getSize(30)),
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
                  widget.businessModel.getMobileName(widget.businessModel),
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
              left: getSize(30), top: getSize(20), bottom: getSize(10)),
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
          ),
        ),
      ],
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
}
