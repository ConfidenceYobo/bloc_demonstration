import 'package:flutter/material.dart';
import 'package:test_app/models/user.dart';

class UserInviteWidget extends StatelessWidget {
  final User userDetails;
  final Function onInvite;
  final bool selectable;
  UserInviteWidget(
      {@required this.userDetails, this.onInvite, this.selectable=true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      color: Colors.white,
      child: IntrinsicHeight(
        child: Row(children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 5, right: 15),
                  alignment: Alignment.bottomRight,
                  child: userDetails.profileImage != null &&
                          userDetails.profileImage.isNotEmpty
                      ? Container(
                            width: 35.0,
                            height: 35.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                          )
                      : CircleAvatar(
                          radius: 24.0,
                          backgroundImage:
                              AssetImage('assets/images/photo_holder.png'),
                        )),
            ],
          ),
          Expanded(
              child: Text(userDetails.username,
                  style: new TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "CircularStd",
                      fontSize: 15))),
          selectable
              ? SizedBox(
                  height: 33,
                  child: new RaisedButton(
                    elevation: 0,
                    child: Text(userDetails.isInvited ? 'Remove' : 'Add',
                        style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "CircularStd",
                            fontSize: 14)),
                    textColor: Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    color: userDetails.isInvited
                        ? Colors.grey[400]
                        : Colors.purple,
                    onPressed: () => onInvite(userDetails),
                  ),
                )
              : Container(),
        ]),
      ),
    );
  }
}
