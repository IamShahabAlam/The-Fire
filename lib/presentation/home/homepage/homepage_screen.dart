import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_fire/app/config/app_size_config.dart';
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
    setState(() {});
  }

// C-R-U-D --------
// get Individual Document --------------------
  getProductsDocument(String docName) async {
    DocumentSnapshot resp = await db.collection('products').doc(docName).get();
    product = resp.data() as Map<String, dynamic>;
    setState(() {});
  }

  onUpdateProduct(String docPath) {
    db.collection('products').doc(docPath).update({'Name': 'controller here'});
    setState(() {});
  }

  addNewProduct(name, category, id) {
    db.collection('products').doc().set({'Name': name, 'Category': category, 'Id': id});
    setState(() {});
  }

  onDeleteProduct(String docPath) {
    db.collection('products').doc(docPath).delete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    var theme = context.theme.colorScheme;
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
          const CommonText(text: 'HOMEPAGE', fontSize: 40, color: Colors.black),
          CommonText(text: widget.profile['Email'].toString(), fontSize: 30, color: Colors.black),
          ListView.builder(
            shrinkWrap: true,
            itemCount: productsList.length,
            itemBuilder: (context, i) {
              var item = productsList[i];
              return ListTile(
                tileColor: theme.primaryContainer,
                leading: Text(item['Id'].toString()),
                title: Text(item['Name']),
                subtitle: Text(item['Category']),
                trailing: Row(
                  children: [IconButton(onPressed: () {}, icon: Icon(Icons.edit)), IconButton(onPressed: () {}, icon: Icon(Icons.delete))],
                ),
              ).paddingAll(8);
            },
          ),
        ],
      ),
    );
  }
}
