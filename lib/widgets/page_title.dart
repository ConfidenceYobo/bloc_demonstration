import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  @required
  final String title;
  final TextStyle textStyle;

  PageTitle({this.title, this.textStyle});

  @override
  Widget build(BuildContext context) {
    TextStyle effectiveTextStyle = textStyle;
    if (textStyle == null)
      effectiveTextStyle = TextStyle(
        color: Colors.black,
        fontFamily: 'CircularStd',
        fontWeight: FontWeight.w700,
        fontSize: 19.0,
      );
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Text(title, style: effectiveTextStyle),
    );
  }
}

class SmallPageTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  SmallPageTitle(this.title, {this.fontSize=17, this.fontWeight=FontWeight.w700});

  @override
  Widget build(BuildContext context) {
    return Text('Complete Details',
      style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'CircularStd',
          fontWeight: fontWeight,
          color: Colors.black));
  }
}
