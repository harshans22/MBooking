import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:movieticket/provider/moviedetails.dart';
import 'package:movieticket/screens/splashscreen.dart';
import 'package:movieticket/utils/dimension.dart';
import 'package:movieticket/utils/navbar.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:movieticket/utils/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
//await FirebaseAppCheck.instance.activate();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: AppDimensions.screenSize,
        minTextAdapt: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => Movie()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor:
                    mobileBackgroundColor, //copywith used to set theme for selected widget
              ),
              // home: StreamBuilder(
              //     stream: FirebaseAuth.instance
              //         .authStateChanges(), // when user want signin then it searches in previous data
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.active) {
              //         if (snapshot.hasData) {
              //           // this function decide which type of screen is there
              //           return const Homescreen();
              //         } else if (snapshot.hasError) {
              //           return Center(child: Text('${snapshot.error}'));
              //         }
              //       }
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return const Center(
              //           child: CircularProgressIndicator(color: primaryColor),
              //         );
              //       }

              //       return const StartScreen();
              //     }),
              home: Navbar(),
            ),
          );
        });
  }
}
