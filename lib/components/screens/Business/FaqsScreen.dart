import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/models/HelpScreenModel.dart';

class FaqsScreen extends StatefulWidget {
  static const route = "HelpScreen";
  @override
  _FaqsScreenState createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  List<HelpScreenModel> helpScreenModelList = [];
  // bool showMoreLess = false;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 10; i++) {
      HelpScreenModel helpScreenModel = HelpScreenModel();
      helpScreenModel.question = "Lorem Ipsum is simply dummy text of the?";
      helpScreenModel.answer =
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ";
      helpScreenModel.isShowMoreLess = false;
      helpScreenModelList.add(helpScreenModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorPrimary,
      appBar: getAppBar(context, "How can we help you?",
          centerTitle: false,
          backgroundColor: appTheme.colorPrimary,
          leadingButton: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: ()=>Navigator.pop(context)),
        
          ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35)
            ), color: Colors.white),
        child: ListView.builder(
          cacheExtent: 1000,
          padding: EdgeInsets.symmetric(
              horizontal: getSize(30), vertical: getSize(30)),
          itemCount: helpScreenModelList.length,
          itemBuilder: (BuildContext context, int index) {
            HelpScreenModel helpScreenModel = helpScreenModelList[index];
            return getQuestionAnswer(helpScreenModel, index);
          },
        ),
      ),
    );
  }

  getQuestionAnswer(HelpScreenModel helpScreenModel, int index) {
    return InkWell(
      onTap: () {
        // NavigationUtilities.pushRoute(BusinessView.route);
        setState(() {
                      helpScreenModel.isShowMoreLess =
                          !helpScreenModel.isShowMoreLess;
                    });
      },
      child: Container(
        padding: EdgeInsets.all(getSize(10)),
        decoration: BoxDecoration(
          border: index > 0
              ? Border(
                  top: BorderSide(color: appTheme.textGreyColor),
                  // bottom: BorderSide(color: appTheme.textGreyColor),
                )
              : null,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    helpScreenModel.question,
                    style: appTheme.black14RegularTextStyle,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      helpScreenModel.isShowMoreLess =
                          !helpScreenModel.isShowMoreLess;
                    });
                  },
                  child: !helpScreenModel.isShowMoreLess
                      ? Icon(Icons.keyboard_arrow_down)
                      : Icon(Icons.keyboard_arrow_up),
                ),
              ],
            ),
            helpScreenModel.isShowMoreLess
                ? Container(
                    padding: EdgeInsets.only(
                        left: getSize(20),
                        top: getSize(10),
                        bottom: getSize(10)),
                    child: Text(helpScreenModel.answer,
                        style: appTheme.black14RegularTextStyle),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
