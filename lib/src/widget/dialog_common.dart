import 'package:flutter/material.dart';

showDialogLoading(context){
   showDialog(
      context: context,
      builder: (context) => Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ),
          barrierDismissible: false,
          barrierColor: Color(0x80000000));
}