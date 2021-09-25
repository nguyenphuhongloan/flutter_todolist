import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/src/repository/auth_repository.dart';
import 'package:todoapp/src/routes/app_pages.dart';
import 'package:todoapp/src/screens/register_screen.dart';
import 'package:todoapp/src/widget/dialog_common.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = "";
  String _password = "";

  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .15,
                ),
                Text('Welcome',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    )),
                SizedBox(
                  height: 32.0,
                ),
                TextFormField(
                    onChanged: (val) {
                      setState(() {
                        _email = val.trim();
                      });
                    },
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade800),
                    decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Loan xinh xắn',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Colors.grey.shade400)),
                    validator: (val) => val!.trim().length == 0
                        ? "Please input username"
                        : null),
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      _password = val.trim();
                    });
                  },
                  obscureText: true,
                  style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade800),
                  decoration: InputDecoration(
                      labelText: 'Password',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Colors.grey.shade400)),
                  validator: (val) => val!.trim().length < 6
                      ? "Password must be least 6 characters"
                      : null,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        showDialogLoading(context);
                        bool isSuccess =
                            await AuthRepository().login(_email, _password);
                        Get.back();
                        if (isSuccess) {
                          Get.offAllNamed(Routes.ROOT);
                        } else {}
                      }
                    },
                    child: Container(
                      height: 48,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.blueAccent),
                      alignment: Alignment.center,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.REGISTER);
                      },
                      child: Text(
                        "Don't have any account? Sign up!",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async{
                        await AuthRepository().googleSignIn();
                      },
                      child: Text(
                        "Have an Google account? Sign in with Google",
                        style: TextStyle(color: Colors.blueAccent),
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
