// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_box_shadow.dart';
import '../../config/app_size_config.dart';

class GradeBtn extends StatelessWidget {
  GradeBtn(
      {super.key,
      required this.marginAll,
      this.name,
      required this.onpressed,
      required this.firstClr,
      required this.lastClr,
      required this.heightB,
      required this.widthB,
      required this.circularBorder,
      this.isShadow = true,
      this.isChild = false,
      this.isLoading = false,
      this.child});

  final double marginAll, heightB, widthB, circularBorder;
  final String? name;
  final Function() onpressed;
  final Color firstClr, lastClr;
  bool isShadow = true, isChild = false;
  final Widget? child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme.colorScheme;
    HeightWidth(context);

    return InkWell(
      splashColor: theme.primary,
      borderRadius: BorderRadius.circular(circularBorder),
      onTap: onpressed,
      child: Container(
        padding: const EdgeInsets.all(1.0),
        margin: EdgeInsets.all(marginAll),
        height: h * heightB,
        width: w * widthB,
        decoration: BoxDecoration(
          boxShadow: isShadow ? [AppBoxShadow.tinyBtnBoxShadow] : [],
          borderRadius: BorderRadius.circular(circularBorder),
          gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
            firstClr,
            lastClr,
          ]),
        ),
        child: isLoading
            ? const SizedBox(width: 80, child: CircularProgressIndicator(color: Colors.white))
            : !isChild
                ? FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ))
                : child,
      ),
    );
  }
}
