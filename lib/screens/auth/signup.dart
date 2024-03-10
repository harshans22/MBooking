import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieticket/screens/auth/confirmOTP.dart';
import 'package:movieticket/utils/color.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController phonecontroller = TextEditingController();
  bool isloading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          "Sign up",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(children: [
          Flexible(flex: 1, child: Container()),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: phonecontroller,
              decoration: InputDecoration(
                  prefixIcon: SvgPicture.asset(
                    "assets/call.svg",
                  ),
                  hintText: "Enter your number",
                  border: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey), // Set border color
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: appthemecolor), // Set border color
                  ),
                  hintStyle: const TextStyle(fontSize: 18)),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.length < 10) {
                  return "Phone number should have atleast 10 digits";
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              _formKey.currentState!.validate();

              if (phonecontroller.text.length == 10) {
                setState(() {
                  isloading = true;
                });
                await FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException ex) {
                       setState(() {
                  isloading = false;

                });
                ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Some error occured',
                              style: TextStyle(color: appthemecolor,fontSize: 18,fontWeight: FontWeight.w500),
                            ),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: greycolorshade1,
                          ));
                    },
                    codeSent: (String verificationid, int? resendtoken) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ConfirmOTP(
                                phonenumber: phonecontroller.text,
                                verificationId: verificationid,
                              )));
                    },
                    codeAutoRetrievalTimeout: (String verificationid) {},
                    phoneNumber: '+91${phonecontroller.text}');
               
              }
            },
            child: Container(
              height: 55.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(30), right: Radius.circular(30)),
                color: appthemecolor,
              ),
              alignment: Alignment.center,
              child: isloading
                  ? const CircularProgressIndicator(color:Colors.black)
                  : const Text(
                      "Send OTP",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
            ),
          ),
          Flexible(flex: 7, child: Container()),
          const Row(
            children: [
              Expanded(
                child: Divider(
                  endIndent: 10,
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Or continue with',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Expanded(
                child: Divider(
                  indent: 10,
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          SvgPicture.asset("assets/facebook.svg"),
          const SizedBox(
            height: 5,
          ),
          SvgPicture.asset("assets/google.svg"),
          const SizedBox(
            height: 35,
          ),
          const Text(
            "By sign in or sign up, you agree to our Terms  of Service",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          const Text("and privacy policy",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey)),
          const SizedBox(
            height: 10,
          ),
        ]),
      )),
    );
  }
}
