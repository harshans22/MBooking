import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieticket/screens/auth/confirm.dart';
import 'package:movieticket/utils/color.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title:const Text(
          "Sign up",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(children: [
          Flexible(flex: 1, child: Container()),
          TextField(
            decoration: InputDecoration(
              prefixIcon: SvgPicture.asset(
                "assets/call.svg",
              ),
              hintText: "Enter your number",
               border: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey), // Set border color
    ),
    focusedBorder:const UnderlineInputBorder(
      borderSide: BorderSide(color: appthemecolor), // Set border color
    ),
              hintStyle:const TextStyle(fontSize: 18)
            ),
            keyboardType: TextInputType.number,
          ),
        const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap:(){
                Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) =>const ConfirmOTP()));
            },
            child: SvgPicture.asset("assets/continue.svg")),
          Flexible(flex: 7, child: Container()),
        const  Row(
            children: [
            Expanded(
              child: Divider(
                
                endIndent: 10,
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            Text('Or continue with',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
             Expanded(
              child: Divider(
                indent: 10,
                thickness: 1,
                color: Colors.grey,
              ),
            ),
          ],),
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
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: Colors.grey),
            ),
           const Text("and privacy policy",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: Colors.grey)),
                   const SizedBox(
                height: 10,
               ),
        ]),
      )),
    );
  }
}
