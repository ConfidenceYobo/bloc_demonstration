import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final String placeHolderText;
  final Function onChange;

  SearchInput({@required this.placeHolderText, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: TextField(
        onChanged: onChange,
        textAlign: TextAlign.start,
        cursorColor: Colors.black,
        style: new TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontFamily: "CircularStd",
            fontSize: 15),
        decoration: InputDecoration(
          hintStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontFamily: "CircularStd",
              fontWeight: FontWeight.w400),
          hintText: placeHolderText,
          hintMaxLines: 1,
          alignLabelWithHint: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
