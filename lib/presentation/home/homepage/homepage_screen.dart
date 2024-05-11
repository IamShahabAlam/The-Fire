import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> productsList = [];
  Map<String, dynamic> product = {};

  @override
  void initState() {
    getProductsCollection();
    getProductsDocument('0');
    super.initState();
  }

  onPressLogout() {
    _auth.signOut().then((value) {
      Dialogs.createSnackBar(context, 'Successfully Logged out', 1);
      Navigator.pushReplacementNamed(context, PageNames.loginScreen);
    }).catchError((e) {
      Dialogs.createSnackBar(context, 'Something went wrong', 0);
    });
  }

// To get the Entire Collection ---------------
  getProductsCollection() async {
    QuerySnapshot resp = await db.collection('products').get();
    // .map method (preferred)
    productsList = resp.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();

    // .forEach method
    /*
    resp.docs.forEach((doc) {
      var data = doc.data() as Map<String, dynamic>;
      productsList.add(data);
    });
  */
  }

// get Individual Document --------------------
  getProductsDocument(String docName) async {
    DocumentSnapshot resp = await db.collection('products').doc(docName).get();
    product = resp.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.profile);
    return Scaffold(
      appBar: AppBar(
        title: const CommonText(text: 'Home Page'),
        actions: [IconButton(onPressed: () => onPressLogout(), icon: const Icon(Icons.power_settings_new))],
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
