import 'dart:async';
import 'package:movieticket/utils/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:movieticket/screens/startscreen.dart';
import 'package:movieticket/utils/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

late String name;

class _SplashScreenState extends State<SplashScreen> {
  static const String KEYNAME = "name";
  bool _showImage = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname();
    Timer(const Duration(seconds: 4), () {
      
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OpeningScreen()));
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showImage = true; // Set _showImage to true after 2 seconds
      });
    });
  }

  void getname() async {
    //shared prefrence for saving name
    var prefs = await SharedPreferences.getInstance();
    var getname = prefs.getString(KEYNAME);
    name = getname ?? "User101";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: LottieBuilder.asset(
                "assets/animation.json",
                height: 300.h,
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              bottom: 0.h, // Position of the image
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: _showImage ? 1 : 0, // Opacity of the image
                child: SvgPicture.asset(
                    'assets/appicon.svg'), // Replace with your image path
              ), // Replace with your image path
            ),
          ],
        ),
      ),
    );
  }
}


class OpeningScreen extends StatelessWidget {
  const OpeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("opening screen");
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor:
              mobileBackgroundColor, //copywith used to set theme for selected widget
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(), // when user want signin then it searches in previous data
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                // this function decide which type of screen is there

                return Navbar(
                  name: name,
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }
            return const StartScreen();
          },
        ),
       // home: Navbar(name: name,),
        );
  }
}
