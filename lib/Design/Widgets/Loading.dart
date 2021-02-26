import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

loading(BuildContext context, {Widget title, Widget content, Widget buttons}) {
  return showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: title,
            content: Container(
              color: Colors.white,
              height: 20.0.h,
              width: 90.0.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Center(child: content)],
              ),
            ),
          ));
}
