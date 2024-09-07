import 'package:flutter/material.dart';

class ProfileUserData extends StatelessWidget {
  const ProfileUserData({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userPhoto,
  });

  final String userName;
  final String userEmail;
  final String userPhoto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0, bottom: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            child: (userPhoto !=  'No Photo')
                ? Image.network(userPhoto)
                : Icon(Icons.account_circle),
            backgroundColor: Colors.white,
            radius: 30.0,
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(userEmail),
            ],
          ),
        ],
      ),
    );
  }
}
