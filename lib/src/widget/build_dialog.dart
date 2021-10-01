import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/src/common/constraint.dart';
showOKDialog(context, title, content){
  showDialog(context: context, builder: (context) => AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20)
    ),
    title: Container(
      height: 45,
      decoration: BoxDecoration(
        color: colorPrimary,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      child: Center(
        child: Text(title, style: TextStyle(
          color: Colors.white,
          fontSize: 23,
        )),
      ),
    ),
    actions: [
      TextButton(onPressed: () => Get.back(), child: Text("OK"))
    ],
    
    content: Container(
      
      height: 50,
      child: Center(
        child: Text(content))),
    titlePadding: EdgeInsets.all(0),
    contentPadding: EdgeInsets.only(top: 20, left: 30, right: 30),
    
  ),);
}