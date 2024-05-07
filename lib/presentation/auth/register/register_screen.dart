// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_fire/app/config/app_size_config.dart';
import 'package:the_fire/app/utils/custom_widgets/common_text.dart';
import 'package:the_fire/app/utils/custom_widgets/gradient_button.dart';
import 'package:the_fire/routes/page_names.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/utils/custom_functions/app_alerts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final cityController = TextEditingController();
  final phoneNoController = TextEditingController();
  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future onPressRegister() async {
    setState(() => isLoading = true);

    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = false);
      // final UserCredential user = await _auth.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text);
      try {
        // Attempt to create a new user with email and password
        final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // If the user is successfully created, proceed to store additional information in Firestore
        if (userCredential.user != null) {
          Dialogs.createSnackBar(context, 'User Registered Successfully', 1);

          await db.collection("users").doc(userCredential.user!.uid).set({
            "Email": emailController.text,
            "Username": nameController.text,
            "Age": ageController.text,
            "Phone": phoneNoController.text,
          });

          Navigator.pushReplacementNamed(context, PageNames.loginScreen);
        } else {
          // User creation failed, handle this case
          Dialogs.createSnackBar(context, 'Unable to Register User', 0);
        }

        // Optionally, you might want to navigate the user to a different screen or perform other actions
      } on FirebaseAuthException catch (e) {
        // Handle specific Firebase authenticatzion errors here
        if (e.code == 'weak-password') {
          Dialogs.createSnackBar(context, '${e.message}', 0);
        } else if (e.code == 'email-already-in-use') {
          Dialogs.createSnackBar(context, 'An account already exists for that email.', 0);
        } else {
          Dialogs.createSnackBar(context, '${e.message}', 0);
        }
      } catch (e) {
        // Handle other errors that might occur
        Dialogs.createSnackBar(context, '$e', 0);
      }

      // Navigator.pus

      setState(() => isLoading = false);
    }

    // Dialogs.createSnackBar(context,'THE ERROR HAS FOUND!!!');

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    var theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Screen'),
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          0.03.ph,
          Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomField(controller: nameController, name: 'Name'),
                  CustomField(controller: emailController, name: 'Email'),
                  CustomField(controller: passwordController, name: 'Password'),
                  CustomField(controller: ageController, name: 'Age'),
                  CustomField(controller: phoneNoController, name: 'Phone Number'),
                ],
              )),
          Container(
            margin: const EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            width: w,
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PageNames.loginScreen);
                },
                child: CommonText(
                  text: 'Already have an Account ?',
                  color: theme.primary,
                  weight: FontWeight.w700,
                )),
          ),
          0.08.ph,
          GradeBtn(
              isLoading: isLoading,
              name: 'Register',
              marginAll: 0.0,
              onpressed: () {
                // _formKey.currentState!.validate();
                onPressRegister();
              },
              firstClr: theme.primaryContainer,
              lastClr: theme.primary,
              heightB: 0.065,
              widthB: 0.92,
              circularBorder: 10.0)
        ],
      ),
    );
  }
}

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.controller,
    required this.name,
  });

  final TextEditingController controller;
  final String name;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: TextFormField(
        onTapOutside: (_) => FocusManager.instance.primaryFocus!.unfocus(),
        controller: controller,
        decoration: InputDecoration(
            hintText: name,
            labelText: name,
            border: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
            filled: true,
            fillColor: theme.primaryContainer),
        validator: (value) {
          if (value!.isEmpty) {
            return '$name Field is Required';
          }
          return null;
        },
      ),
    );
  }
}
