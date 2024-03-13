import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieticket/methods/authfunctions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:movieticket/screens/homescreen.dart';
import 'package:movieticket/utils/color.dart';
import 'package:movieticket/utils/pickimage.dart';
import 'package:movieticket/widgets/text_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static const String KEYNAME = "name";
  bool isloading = false;
  String name = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final formKey = GlobalKey<FormState>();

//for siigning up user
  void SignUp() async {
    setState(() {
      isloading = true;
    });

    // String res = await AuthMethods().signUpUser(
    //     email: _emailController.text,
    //     password: _passwordController.text,
    //     name: _nameController.text,
    //     city: _cityController.text);
    try {
      var usersnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      name = usersnapshot["username"];
    } catch (err) {
      print(err.toString());
    }

    //shared prefrence for saving name
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(KEYNAME, _nameController.text);
    setState(() {
      isloading = false;
    });
    // if (res != "success") {
    //   // in authmethods we are making res =success if authentication is successfull
    //   showSnackBar(res, context);
    // } else {
    //   showSnackBar("Registered successfuly", context);
    //   Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => Homescreen(
    //       name: name,
    //     ),
    //   ));
   // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFieldInput(
                    textEditingController: _nameController,
                    hintText: "Enter your name",
                    textInputType: TextInputType.text),
                SizedBox(
                  height: 20.h,
                ),
                TextFieldInput(
                    textEditingController: _emailController,
                    hintText: "Enter your mail",
                    textInputType: TextInputType.text),
                SizedBox(
                  height: 20.h,
                ),
                TextFieldInput(
                    textEditingController: _passwordController,
                    hintText: "New password",
                    textInputType: TextInputType.text),
                SizedBox(
                  height: 20.h,
                ),
                TextFieldInput(
                    textEditingController: _confirmpasswordController,
                    hintText: "Confirm password",
                    textInputType: TextInputType.text),
                SizedBox(
                  height: 20.h,
                ),
                TextFieldInput(
                    textEditingController: _cityController,
                    hintText: "Enter your City",
                    textInputType: TextInputType.text),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: SignUp,
                  child: Container(
                    height: 55.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(30),
                          right: Radius.circular(30)),
                      color: appthemecolor,
                    ),
                    alignment: Alignment.center,
                    child: isloading
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : const Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
