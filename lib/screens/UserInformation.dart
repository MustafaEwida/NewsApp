import 'package:flutter/material.dart';
import 'package:newsapp/models/User.dart';
import 'package:newsapp/widgets/UserInformationItem.dart';

class UserInformation extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    UserMdoel user = ModalRoute.of(context)!.settings.arguments as UserMdoel;
    print(user.email);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: UserInfoItem(user),



      
    );
  }
}