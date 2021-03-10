import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

loading(BuildContext context, {Widget title, Widget content, Widget buttons, String percentage}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => StatefulBuilder(
            builder: (context, setState) {
              return WillPopScope(
                onWillPop: pop,
                child: AlertDialog(
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
                ),
              );
            },
          ));
}

Future<bool> pop() async {
  print("back");
  return false;
}
