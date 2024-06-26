// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common_text.dart';
import 'nuemorph_container.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.action,
    this.isAction = true,
    this.isTitleWidget = false,
    this.titleWidget,
  });

  Widget? leading, action, titleWidget;
  String? title;
  bool isAction = true, isTitleWidget = false;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme.colorScheme;
    return AppBar(
      leading: NuemorphContainer(
        marginAll: 8.0,
        height: 40.0,
        width: 40.0,
        child: leading ?? Container(),
      
      ),
      title: isTitleWidget
          ? titleWidget
          : CommonText(
              text: title!,
              color: theme.onSecondary,
              fontSize: 18,
              weight: FontWeight.w600,
            ),
      actions: [
        isAction
            ? NuemorphContainer(
                marginAll: 8.0,
                height: 40.0,
                width: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    action ?? Container(),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  EmptyAppBar({super.key});

  Widget? leading, action, titleWidget;
  String? title;
  bool isAction = true, isTitleWidget = false;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme.colorScheme;
    return Container();
  }
}
