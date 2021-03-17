import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/theme/app_theme.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zaviato/app/app.export.dart';
import 'package:zaviato/app/localization/app_locales.dart';

void modalBottomSheetMenu(
  context, {
  String title,
  TextStyle titleStyle,
  TextStyle selectecOptionStyle,
  TextStyle optionsStyle,
  List<SelectionPopupModel> selectionOptions,
  SelectionPopupModel selectionPopupModel,
  SelectionCallback callback,
}) =>
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      context: context,
      builder: (builder) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (isStringEmpty(title) == false)
              Padding(
                  padding:
                      EdgeInsets.only(top: getSize(15), bottom: getSize(10)),
                  //padding: EdgeInsets.all(getSize(10)),
                  child: Text(
                    title,
                    style: titleStyle ??
                        AppTheme.of(context).theme.textTheme.display1.copyWith(
                            color: appTheme.whiteColor,
                            fontWeight: FontWeight.w600),
                  )),
            Container(
              height: 1,
              width: MathUtilities.screenWidth(context),
              // decoration: BoxDecoration(color: kGrey200),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: 50,
                  maxHeight: MathUtilities.screenHeight(context) - 150),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: selectionOptions.length,
                  itemBuilder: (context, index) {
                    var option = selectionOptions[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          contentPadding:
                              EdgeInsets.only(left: getSize(16), top: 0),
                          onTap: () {
                            Navigator.pop(context);
                            callback(option);
                          },
                          title: (option.isSelected ?? false)
                              ? selectecOptionStyle == null
                                  ? getTitleText(context, option.title,
                                      color: AppTheme.of(context)
                                          .theme
                                          .textTheme
                                          .title
                                          .color,
                                      alignment: TextAlign.left)
                                  : Text(
                                      option.title,
                                      style: selectecOptionStyle,
                                      textAlign: TextAlign.left,
                                    )
                              : optionsStyle == null
                                  ? getBodyText(context, option.title,
                                      color: AppTheme.of(context)
                                          .theme
                                          .textTheme
                                          .body2
                                          .color,
                                      alignment: TextAlign.left)
                                  : Text(
                                      option.title,
                                      style: optionsStyle,
                                      textAlign: TextAlign.left,
                                    ),
                        ),
                        index == selectionOptions.length - 1
                            ? SizedBox(
                                height: 0,
                              )
                            : Container(
                                height: 0.5,
                                color: appTheme.dividerColor,
                              )
                      ],
                    );
                  }),
            ),
            Container(
              height: 1,
              color: appTheme.dividerColor,
            ),
            SafeArea(
              child: InkWell(
                child: Container(
                  alignment: Alignment.center,
                  width: MathUtilities.screenWidth(context),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: getTitleText(context, R.string().commonString.cancel,
                        color:
                            AppTheme.of(context).theme.textTheme.title.color),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );

typedef SelectionCallback(SelectionPopupModel model);

class SelectionPopupModel {
  String id;
  String title;
  bool isSelected;
  int type;
  int rideType;

  SelectionPopupModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson["id"] ?? "";
    title = parsedJson["name"] ?? "";
    isSelected = parsedJson["isSelected"] ?? false;
  }

  SelectionPopupModel(String id, String title,
      {bool isSelected = false, int type, int ridetype}) {
    this.id = id;
    this.title = title;
    this.isSelected = isSelected;
    this.type = type;
    this.rideType = ridetype;
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<SelectionPopupModel> reportList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.reportList, {this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item.title),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item.title);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
