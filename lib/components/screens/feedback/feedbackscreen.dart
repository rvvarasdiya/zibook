import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/base/BaseApiResp.dart';
import 'package:zaviato/app/base/ErrorResp.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/localization/app_locales.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/ServiceModule.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/CustomDialog.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';
import 'package:zaviato/components/widgets/shared/start_rating.dart';
import 'package:zaviato/models/mybusiness/MyBusinessByCategoryRes.dart';

import '../../../main.dart';

class FeedbackScreen extends StatefulWidget {
  static const route = "FeedbackScreen";

  Business businessModel;

  FeedbackScreen({Map<String, dynamic> arguments}) {
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
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController feedbackController = TextEditingController();
  double rating;

  @override
  void initState() {
    super.initState();
    rating = 0;
    feedbackController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: true,
      // resizeToAvoidBottomInset: false,
      // backgroundColor: appTheme.colorPrimary,
      appBar: AppBar(
        // toolbarHeight: getSize(80),
        elevation: 0,
        backgroundColor: appTheme.colorPrimary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          "Feedbak",
          style: appTheme.white18RegularTextStyle,
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: getSize(50),
            color: appTheme.colorPrimary,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: getSize(30)),
            height: double.infinity,
            decoration: BoxDecoration(
                // color: Color(0xffFAFAFA),
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                    // color: appTheme.colorPrimary
                    color: Color(0xff0000001A),
                    offset: Offset(0, -6),
                    blurRadius: 10.0,
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                )),
            child: ListView(
              cacheExtent: 1000,
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: getSize(40),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                      radius: getSize(
                        40,
                      ),
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(getSize(100)),
                        child: Image.asset(
                          userIcon,
                          height: getSize(80),
                          width: getSize(80),
                        ),
                      )),
                ),
                SizedBox(
                  height: getSize(25),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(60)),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "How was your experience with ",
                            style: appTheme.black18RegularTextStyle),
                        TextSpan(
                            text: "Bhavani Fashion ?",
                            style: appTheme.black18BoldTextStyle),
                      ])),
                ),
                SizedBox(
                  height: getSize(10),
                ),
                Text(
                  "Your feedback matters",
                  textAlign: TextAlign.center,
                  style: appTheme.black16RegularTextStyle
                      .copyWith(color: Color(0xff6E7073)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: getSize(30)),
                  child: Align(
                    alignment: Alignment.center,
                    child: SmoothStarRating(
                        onRatingChanged: (value) {
                          // print("------------$rating   --------- $value");
                          setState(() {
                            rating = value;
                          });
                        },
                        rating: rating,
                        allowHalfRating: false,
                        starCount: 5,
                        size: 30.0,
                        color: appTheme.colorPrimary,
                        borderColor: appTheme.dividerColor,
                        spacing: 0.0),
                  ),
                ),
                Text(
                  "Write a Comment",
                  style: appTheme.black14BoldTextStyle,
                ),
                SizedBox(
                  height: getSize(10),
                ),
                Container(
                  padding: EdgeInsets.all(getSize(14)),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Color(0xffCBCBCB),
                        width: 2,
                      )),
                  child: Center(
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      controller: feedbackController,
                      style: appTheme.black14RegularTextStyle
                          .copyWith(color: Colors.black),
                      maxLines: 6,
                      maxLength: 750,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.only(
                          left: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getSize(40),
                ),
                AppButton.flat(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    callApiToAddReviewAndRatings(context);
                  },
                  backgroundColor: appTheme.colorPrimary,
                  text: "Submit",
                  textSize: 18,
                  textColor: Colors.white,
                  fitWidth: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  callApiToAddReviewAndRatings(BuildContext context) {
    Map<String, dynamic> req = {};
    req["id"] = widget.businessModel;
    req["rating"] = rating.toString();
    req["review"] = feedbackController.text.toString();

    NetworkCall<BaseApiResp>()
        .makeCall(
            () => app
                .resolve<ServiceModule>()
                .networkService()
                .addReviewRating(req),
            context,
            isProgress: true)
        .then((baseApiResp) async {
      print("Review added successfully");
      showToast(baseApiResp.message, context: context);
      Navigator.of(context).pop();
    }).catchError((onError) {
      if (onError is ErrorResp) {
        app.resolve<CustomDialogs>().confirmDialog(
              context,
              title: R.string().commonString.error,
              desc: onError.message,
              positiveBtnTitle: R.string().commonString.ok,
            );
      }
    });
  }
}
