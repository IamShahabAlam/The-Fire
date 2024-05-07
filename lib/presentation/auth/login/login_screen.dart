// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_fire/app/config/app_size_config.dart';
import 'package:the_fire/presentation/home/homepage/homepage_screen.dart';

import '../../../app/utils/custom_functions/app_alerts.dart';
import '../../../app/utils/custom_widgets/gradient_button.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  DocumentSnapshot? profile;

  bool isLoading = false;

  Future onPressLogin() async {
    setState(() => isLoading = true);
    try {
      if (_formKey.currentState!.validate()) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (userCredential.user != null) {
          Dialogs.createSnackBar(context, 'User Logged In', 1);

          profile = await db.collection('user').doc(userCredential.user!.uid).get();
          // profile save to Preferences ----
          HomePage(profile: profile!.data() as Map);
          print(profile!);
        } else {
          Dialogs.createSnackBar(context, 'User Not Found', 0);
        }
      }
      setState(() => isLoading = false);
    } on FirebaseAuthException catch (e) {
      Dialogs.createSnackBar(context, e.message!, 0);
    } catch (e) {
      Dialogs.createSnackBar(context, e.toString(), 0);
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    var theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomField(controller: emailController, name: 'Email'),
                  CustomField(controller: passwordController, name: 'Password'),
                ],
              )),
          0.08.ph,
          GradeBtn(
              name: 'Login',
              marginAll: 0.0,
              onpressed: () {
                onPressLogin();
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
