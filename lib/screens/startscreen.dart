import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieticket/auth/signin.dart';
import 'package:movieticket/auth/signup.dart';
import 'package:movieticket/utils/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieticket/widgets/bottomsheet.dart';
import 'package:movieticket/widgets/movie_card.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with TickerProviderStateMixin {
  List<String> sliderimages = [
    "assets/movies_imgaes/avengers.jpg",
    "assets/movies_imgaes/fast and furious.jpg",
    "assets/movies_imgaes/shershaah.jpg"
  ];
  int currentindex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          "assets/appicon.svg",
          height: 32,
        ),
        actions: [
          InkWell(
              onTap: () {
                bottomsheet(context);
              },
              child: SvgPicture.asset(
                "assets/translate.svg",
                height: 32,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
             SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              child: PageView.builder(
                itemCount: sliderimages.length,
                reverse: true,
                pageSnapping: false,
                padEnds: false,
                controller: PageController(
                  viewportFraction: 0.7,
                  initialPage: 1,
                ),
                onPageChanged: (value) {
                  currentindex = value;
                  setState(() {});
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return MovieCard(images: sliderimages, index: index);
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Text(
              "MBooking hello!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
            ),
             SizedBox(
              height: 10.h,
            ),
            const Text(
              "Enjoy your favorite movies",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
             SizedBox(
              height: 10.h,
            ),
            TabPageSelector(
              controller: TabController(
                length: sliderimages.length,
                vsync: this,
                initialIndex: currentindex,
              ),
              selectedColor: const Color(0xFFFCC434),
              color: secondaryColor,
              borderStyle: BorderStyle.none,
              indicatorSize: 8.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>const LoginIn()));
                },
                child: SvgPicture.asset("assets/sign in.svg")),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                child: SvgPicture.asset("assets/sign up button.svg")),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Text(
              "By sign in or sign up, you agree to our Terms  of Service",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            const Text("and privacy policy",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
