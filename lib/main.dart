import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movieticket/models/moviedata.dart';
import 'package:movieticket/screens/homescreen.dart';
import 'package:movieticket/screens/seatselection.dart';
import 'package:movieticket/screens/upload(only_for_admin).dart/upload2.dart';
import 'package:movieticket/utils/dimension.dart';
import 'firebase_options.dart';
import 'package:movieticket/utils/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          
          theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor:
              mobileBackgroundColor, //copywith used to set theme for selected widget
        ),
          home: const Homescreen(),
        );
      },
    );
  }
}
