import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/src/repository/auth_repository.dart';
import 'package:todoapp/src/routes/app_pages.dart';
import 'package:todoapp/src/widget/build_dialog.dart';
import 'package:todoapp/src/widget/dialog_common.dart';

class RegisterScreen extends StatefulWidget {
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 100),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 35,
                ),
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      email = val.trim();
                    });
                  },
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (val) =>
                      val!.trim().length == 0 ? "Please input email" : null,
                ),
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      password = val.trim();
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (val) => val!.trim().length == 0
                      ? "Password must be have least 6 characters"
                      : null,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Retype password'),
                  validator: (val) =>
                      val!.trim() != password ? "Password not match" : null,
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          showDialogLoading(context);
                          int isSuccess =
                              await AuthRepository().register(email, password);
                          Get.back();
                          if (isSuccess == 1) {
                            Get.offAllNamed(Routes.ROOT);
                          } else {
                            if (isSuccess == 2) {
                              showOKDialog(context, "Register failed",
                                  "Your email is invalid, please check it again");
                            }
                            if (isSuccess == 3) {
                              showOKDialog(context, "Register failed",
                                  "This email already in use, if you have an account, please login");
                            }
                            if (isSuccess == 4) {
                              showOKDialog(context, "Register failed",
                                  "weak password");
                            }
                            if (isSuccess == 0) {
                              showOKDialog(
                                  context, "Register failed", "Register failed, please check your connection and try again");
                            }
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 48,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.blueAccent),
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
