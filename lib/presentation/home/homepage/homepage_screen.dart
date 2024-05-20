// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:the_fire/app/config/app_size_config.dart';
import 'package:the_fire/app/utils/custom_functions/app_alerts.dart';
import 'package:the_fire/app/utils/custom_widgets/common_text.dart';
import 'package:the_fire/app/utils/custom_widgets/custom_dialogs.dart';
import 'package:the_fire/app/utils/custom_widgets/custom_textfield.dart';
import 'package:the_fire/routes/page_names.dart';

import '../../../app/utils/custom_widgets/gradient_button.dart';
import '../../auth/register/register_screen.dart';

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
  List<Map<String, dynamic>> usersList = [];
  Map<String, dynamic> product = {};
  bool isLoading = false;
  // Controllers -------------------
  final nameController = TextEditingController();
  final companyController = TextEditingController();
  final categoryController = TextEditingController();
  // controller nameController = controller();

  @override
  void initState() {
    prepareData();
    super.initState();
  }

  prepareData() async {
    productsList = await getProductsCollection('products');
    usersList = await getProductsCollection('users');
    getProductsDocument('0');
  }

  //
  resetControllers() {
    nameController.clear();
    companyController.clear();
    categoryController.clear();
    setState(() {});
  }

// To get the Entire Collection ---------------
  Future<List<Map<String, dynamic>>> getProductsCollection(collectionName) async {
    resetControllers();
    setState(() => isLoading = true);
    List<Map<String, dynamic>> result = [];
    QuerySnapshot resp = await db.collection(collectionName).get();
    // .map method (preferred)
    /*
    result = resp.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();
*/
    // .forEach method
    resp.docs.forEach((doc) {
      var data = doc.data() as Map<String, dynamic>;
      result.add(data);
    });
    // MyDialog.hideProgressBar();
    setState(() => isLoading = false);

    return result;
  }

// C-R-U-D --------
// get Individual Document --------------------
  getProductsDocument(String docName) async {
    DocumentSnapshot resp = await db.collection('products').doc(docName).get();
    product = resp.data() as Map<String, dynamic>;
    setState(() {});
  }

  onUpdateProduct(String docId, name, company, category) async {
    db.collection('products').doc(docId).update({'Name': name});
    Navigator.pop(context);
    Dialogs.createSnackBar(context, 'Product with $docId is updated!', 1);
    productsList = await getProductsCollection('products');
    setState(() {});
  }

  addNewProduct(List oldList, name, category, company) async {
    int? listLength = oldList.length;
    String id = 'PRD-$listLength';
    db.collection('products').doc(id).set({'Name': name, 'Company': company, 'Category': category, 'Id': id});
    Navigator.pop(context);

    Dialogs.createSnackBar(context, 'Product with $id is added!', 1);
    productsList = await getProductsCollection('products');
    setState(() {});
  }

  onDeleteProduct(String docId) async {
    db.collection('products').doc(docId).delete();
    Dialogs.createSnackBar(context, 'Product with $docId is deleted!', 1);

    productsList = await getProductsCollection('products');

    setState(() {});
  }

  onPressLogout() {
    _auth.signOut().then((value) {
      Dialogs.createSnackBar(context, 'Successfully Logged out', 1);
      Navigator.pushReplacementNamed(context, PageNames.loginScreen);
    }).catchError((e) {
      Dialogs.createSnackBar(context, 'Something went wrong', 0);
    });
  }

  onPressEdit(item) {
    nameController.text = item['Name'];
    companyController.text = item['Company'];
    categoryController.text = item['Category'];
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomField(controller: nameController, name: 'Name'),
            CustomField(controller: companyController, name: 'Company'),
            CustomField(controller: categoryController, name: 'Category'),
            0.08.ph,
            GradeBtn(
                name: 'Update',
                marginAll: 0.0,
                onpressed: () => onUpdateProduct(item['Id'], nameController.text, companyController.text, categoryController.text),
                firstClr: context.theme.colorScheme.primaryContainer,
                lastClr: context.theme.colorScheme.primary,
                heightB: 0.065,
                widthB: 0.92,
                circularBorder: 10.0)
          ],
        );
      },
    );
  }

  onPressNew(list) {
    resetControllers();
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomField(
              controller: nameController,
              name: 'Name',
            ),
            CustomField(
              controller: companyController,
              name: 'Company',
            ),
            CustomField(
              controller: categoryController,
              name: 'Category',
            ),
            0.08.ph,
            GradeBtn(
                name: 'Add Product',
                marginAll: 0.0,
                onpressed: () => addNewProduct(list, nameController.text, categoryController.text, companyController.text),
                firstClr: context.theme.colorScheme.primaryContainer,
                lastClr: context.theme.colorScheme.primary,
                heightB: 0.065,
                widthB: 0.92,
                circularBorder: 10.0)
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    var theme = context.theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CommonText(text: 'Home Page', color: Colors.black),
        actions: [IconButton(onPressed: () => onPressLogout(), icon: const Icon(Icons.power_settings_new))],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const CommonText(text: 'HOMEPAGE', fontSize: 20, color: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CommonText(text: widget.profile['Email'].toString(), fontSize: 15, color: Colors.black),
              CommonText(text: widget.profile['Username'].toString(), fontSize: 15, color: Colors.black),
              CommonText(text: widget.profile['Phone'].toString(), fontSize: 15, color: Colors.black),
              CommonText(text: widget.profile['Age'].toString(), fontSize: 15, color: Colors.black),
            ],
          ),
          0.01.ph,
          const CommonText(text: 'Products List ', fontSize: 25, color: Colors.black),
          isLoading
              ? Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    color: theme.primaryContainer,
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productsList.length,
                    itemBuilder: (context, i) {
                      var item = productsList[i];
                      return ListTile(
                        visualDensity: VisualDensity.compact,
                        tileColor: theme.primaryContainer,
                        leading: Text(item['Id'].toString()),
                        title: Text('${item['Company']} >> ${item['Name']}'),
                        subtitle: Text(item['Category']),
                        trailing: SizedBox(
                          width: 70,
                          child: Row(
                            children: [
                              InkWell(onTap: () => onPressEdit(item), child: const Icon(Icons.edit)),
                              const Spacer(),
                              InkWell(onTap: () => onDeleteProduct(item['Id']), child: const Icon(Icons.delete))
                            ],
                          ),
                        ),
                      ).paddingAll(5);
                    },
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => onPressNew(productsList),
        child: const Icon(Icons.add),
      ),
    );
  }
}
