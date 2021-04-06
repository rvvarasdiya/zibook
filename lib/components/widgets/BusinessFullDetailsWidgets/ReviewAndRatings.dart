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
  

  @override
  void initState() {
    super.initState();

    
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
                
      ],
    );
  }

  }
