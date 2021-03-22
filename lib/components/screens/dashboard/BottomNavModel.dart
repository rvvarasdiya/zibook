

import 'package:zaviato/app/constant/ImageConstant.dart';

class BottomNavModel {
  String title;
  String image;
  bool  isSelected = false;
  int type;

  BottomNavModel({this.image, this.title, this.isSelected, this.type});

  static List<BottomNavModel> getBottomBar() {
    return <BottomNavModel>[
      BottomNavModel(
        image: homeIcon,
        title: "",
        isSelected: true,
        type: 1,
      ),
      BottomNavModel(
        image: notifyIcon,
        title: "",
        isSelected: false,
        type: 2,
      ),
      BottomNavModel(
        image: chatIcon,
        title: "",
        isSelected: false,
        type: 3,
      ),
      BottomNavModel(
        image: settingIcon,
        title: "",
        isSelected: false,
        type: 4,
      ),
    ];
  }
}
