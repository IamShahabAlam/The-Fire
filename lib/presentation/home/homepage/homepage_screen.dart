import 'package:flutter/material.dart';
import 'package:the_fire/app/utils/custom_widgets/common_text.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({required this.profile, super.key});
  Map profile = {};

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CommonText(text: 'Home Page'),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonText(
            text: 'HOMEPAGE',
            fontSize: 40,
          )
        ],
      ),
    );
  }
}
