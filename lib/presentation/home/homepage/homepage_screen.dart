import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_fire/app/utils/custom_functions/app_alerts.dart';
import 'package:the_fire/app/utils/custom_widgets/common_text.dart';
import 'package:the_fire/routes/page_names.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({required this.profile, super.key});
  dynamic profile;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  onPressLogout() {
    _auth.signOut().then((value) {
      Dialogs.createSnackBar(context, 'Successfully Logged out', 1);
      Navigator.pushReplacementNamed(context, PageNames.loginScreen);
    }).catchError((e) {
      Dialogs.createSnackBar(context, 'Something went wrong', 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.profile);
    return Scaffold(
      appBar: AppBar(
        title: const CommonText(text: 'Home Page'),
        actions: [IconButton(onPressed: () => onPressLogout(), icon: Icon(Icons.power_settings_new))],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CommonText(
            text: 'HOMEPAGE',
            fontSize: 40,
            color: Colors.black,
          ),
          CommonText(
            text: widget.profile['Email'].toString(),
            fontSize: 30,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
