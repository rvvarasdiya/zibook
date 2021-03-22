import 'package:flutter/material.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
         color: Colors.pink,
                    // color: Color(0xffFAFAFA),
                    boxShadow: getBoxShadow(context),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
      
    );
  }
}