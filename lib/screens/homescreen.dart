import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieticket/utils/color.dart';
import 'package:movieticket/widgets/coming_soon.dart';
import 'package:movieticket/widgets/movie_card(homeScreen).dart';
import 'package:carousel_slider/carousel_slider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key, required String name});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, Harsh 👋",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Welcome back",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/notification.svg")),
          const SizedBox(
            width: 4,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Image.asset("assets/search-normal.png"),
                  hintText: "Search",
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 16),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Color(0xFF1C1C1C),
                  filled: true,
                ),
              ),
            ),
            //carousel slider
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                      child: Text(
                    "Now playing",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )),
                  TextButton(
                    onPressed: () {},
                    child: const Text("See all >",
                        style: TextStyle(
                            color: appthemecolor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Movie data")
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return CarouselSlider(
                    options: CarouselOptions(
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.2,
                      viewportFraction: 0.72,
                      height: 450.h,
                    ),
                    items: snapshot.data!.docs
                        .map((doc) => Column(
                              children: [
                                Moviecard(snap: doc.data()),
                              ],
                            ))
                        .toList(),
                  );
                }),
            //coming soon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    "Coming soon",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )),
                  TextButton(
                    onPressed: () {},
                    child: const Text("See all >",
                        style: TextStyle(
                            color: appthemecolor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),

            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("coming soon")
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox(
                    height: 300.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) =>
                          comingsoon(snap: snapshot.data!.docs[index].data()),
                    ),
                  );
                }),
            //offers and discount
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    "Promo & discount",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )),
                  TextButton(
                    onPressed: () {},
                    child: const Text("See all >",
                        style: TextStyle(
                            color: appthemecolor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618571888087/movie-ticket-offers.jpg",
                    height: 200.h,
                    fit: BoxFit.fill,
                  )),
            ),
            //service
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    "Service",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )),
                  TextButton(
                    onPressed: () {},
                    child: const Text("See all >",
                        style: TextStyle(
                            color: appthemecolor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("service")
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox(
                    height: 100.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => Column(
                              children: [
                                
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundImage: NetworkImage(snapshot
                                        .data!.docs[index]
                                        .data()["images"]),
                                  ),
                                ),
                              const  SizedBox(height: 5,),
                                Text(snapshot
                                        .data!.docs[index]
                                        .data()["name"],style:const TextStyle(fontWeight: FontWeight.w400),),
                              ],
                            )),
                  );
                }),
                //movie news
                            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    "Movie news",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )),
                  TextButton(
                    onPressed: () {},
                    child: const Text("See all >",
                        style: TextStyle(
                            color: appthemecolor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
             StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("movie news")
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox(
                    height: 160.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0),
                          child: Stack(
                                children: [
                                  ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(snapshot.data!.docs[index].data()["titleimage"],height: 160.h,width: 220.w,fit: BoxFit.fill,)),
                                    Container(
                                      height: 160.h,
                                      width: 230.h,
                                      color: const Color.fromARGB(64, 13, 13, 13),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: SizedBox( width: 220.w,
                                        child: Text(snapshot.data!.docs[index].data()["title"],style:const TextStyle(fontSize: 14,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis),maxLines: 2,))),
                                ],
                              ),
                        )),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
