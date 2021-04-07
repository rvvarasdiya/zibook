import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/ServiceModule.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/models/FaqsModel.dart';

import '../../../main.dart';

class FaqsScreen extends StatefulWidget {
  static const route = "FaqsScreen";
  @override
  _FaqsScreenState createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  List<Faqs> faqScreenModelList = [];
  // bool showMoreLess = false;

  @override
  void initState() {
    super.initState();
    callApi(true);
  }
 callApi(bool isRefress, {bool isLoading = false}) {
        NetworkCall<FaqsResp>()
          .makeCall(
        () => app
            .resolve<ServiceModule>()
            .networkService()
            .getFaqs(),
        context,
        isProgress: true,
      )
          .then((respose) async {
            faqScreenModelList.addAll(respose.data.list);
            setState(() { });
            print("Success");
            // print(faqScreenModelList);
      }).catchError((onError) {
        print("Error");
      });
    
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
          itemCount: faqScreenModelList.length,
          itemBuilder: (BuildContext context, int index) {
            Faqs faqScreenModel = faqScreenModelList[index];
            return getQuestionAnswer(faqScreenModel, index);
          },
        ),
      ),
    );
  }

  getQuestionAnswer(Faqs faqScreenModel, int index) {
    return InkWell(
      onTap: () {
        // NavigationUtilities.pushRoute(BusinessView.route);
        setState(() {
                      faqScreenModel.isShowMoreLess =
                          !faqScreenModel.isShowMoreLess;
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
                    faqScreenModel.question,
                    style: appTheme.black14RegularTextStyle,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      faqScreenModel.isShowMoreLess =
                          !faqScreenModel.isShowMoreLess;
                    });
                  },
                  child: !faqScreenModel.isShowMoreLess
                      ? Icon(Icons.keyboard_arrow_down)
                      : Icon(Icons.keyboard_arrow_up),
                ),
              ],
            ),
            faqScreenModel.isShowMoreLess
                ? Container(
                    padding: EdgeInsets.only(
                        left: getSize(20),
                        top: getSize(10),
                        bottom: getSize(10)),
                    child: Text(faqScreenModel.answer,
                        style: appTheme.black14RegularTextStyle),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
