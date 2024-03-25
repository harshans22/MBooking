// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieticket/utils/color.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0; //for dotted image indicator of things do in your city
    // final CarouselController carouselController = CarouselController();
    List<Map<String, dynamic>> list1 = [
      {
        "name": "HOLI PARTIES",
        "color": const Color.fromARGB(255, 236, 18, 2),
        "image": "assets/amazed.png"
      },
      {
        "name": "FAST-FILLING",
        "color": const Color.fromARGB(255, 0, 139, 253),
        "image": "assets/shouting.png"
      },
      {
        "name": "MUST-ATTENDED",
        "color": const Color.fromARGB(255, 255, 230, 3),
        "image": "assets/must attended.png"
      },
      {
        "name": "EVERYONE CHOICE",
        "color": const Color.fromARGB(255, 0, 255, 8),
        "image": "assets/everyone choice.png"
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Events"),
        backgroundColor: mobileBackgroundColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //features
              FutureBuilder(
                  future: FirebaseFirestore.instance.collection("events").get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    return SizedBox(
                      height: 90.h,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Stack(children: [
                                    SizedBox(
                                      height: 90.h,
                                      width: 150.w,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            snapshot.data!.docs[index]["logo"],
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                    Container(
                                      height: 90.h,
                                      width: 150.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(255, 15, 14, 14)
                                              .withOpacity(0.7)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        snapshot.data!.docs[index]["logoname"],
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ]),
                                ],
                              ),
                            );
                          })),
                    );
                  }),
              SizedBox(
                height: 25.h,
              ),

              //recomeded for you

              Text("Offers Recommended For You",
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 20.h,
              ),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("Recommended")
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    return SizedBox(
                      height: 162.h,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding:
                                   EdgeInsets.symmetric(horizontal: 10.w),
                              child: Container(
                                width: 310.w,
                                decoration: BoxDecoration(
                                  color: greycolorshade1,
                                  borderRadius: BorderRadius.circular(10.r),
                                  //                               boxShadow: [
                                  //   BoxShadow(
                                  //     color: Color.fromARGB(255, 255, 243, 109),
                                  //     spreadRadius: 4,
                                  //     blurRadius: 6,
                                  //      offset: Offset(0, 4), // changes the position of the shadow
                                  //   ),
                                  // ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:  EdgeInsets.all(10.h),
                                      height: 100.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: appthemecolor.withOpacity(0.45),
                                        borderRadius:
                                             BorderRadiusDirectional.only(
                                                topStart: Radius.circular(10.r),
                                                topEnd: Radius.circular(10.r),
                                                bottomStart:
                                                    Radius.circular(20.r),
                                                bottomEnd: Radius.circular(20.r)),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 35.r,
                                                backgroundImage: NetworkImage(
                                                  snapshot.data!.docs[index]
                                                      ["logo"],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ["title"],
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    SizedBox(
                                                      height: 15.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                            snapshot.data!.docs[
                                                                        index][
                                                                    "type"][0] +
                                                                ", " +
                                                                snapshot.data!
                                                                            .docs[
                                                                        index]
                                                                    ["type"][1],
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255, 0, 0, 0),
                                                            )),
                                                        Text(
                                                            "  |  " +
                                                                snapshot.data!
                                                                            .docs[
                                                                        index]
                                                                    ["Date"],
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255, 0, 0, 0),
                                                            )),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ["Venue"],
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500,

                                                          color: const Color
                                                              .fromARGB(
                                                              255, 15, 15, 15),
                                                        )),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: appthemecolor,
                                      height: 0,
                                      indent: 20,
                                      endIndent: 20,
                                      thickness: 2,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text.rich(TextSpan(children: [
                                            TextSpan(
                                                text: "10% ",
                                                style: TextStyle(
                                                    color: appthemecolor,
                                                    fontSize: 30.sp,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            TextSpan(
                                                text: "off",
                                                style: TextStyle(
                                                    color: appthemecolor,
                                                    fontSize: 20.sp,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ])),
                                          Container(
                                            padding:  EdgeInsets.symmetric(
                                                horizontal: 15.w, vertical: 10.h),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: appthemecolor),
                                                borderRadius:
                                                    BorderRadius.circular(10.r)),
                                            child: const Text(
                                              "Book Now",
                                              style: TextStyle(
                                                  color: appthemecolor),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })),
                    );
                  }),

              //things to do in your city


              
              SizedBox(
                height: 30.h,
              ),
              Container(
                color: greycolorshade1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Things to do in your city",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text("Here's what everyone is booking",
                          style: TextStyle(fontSize: 12.sp)),
                      SizedBox(
                        height: 20.h,
                      ),
                      FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("Incity")
                              .get(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            return Column(
                              children: [
                                CarouselSlider(
                                  //  carouselController: carouselController,
                                  options: CarouselOptions(
                                    // reverse: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    },
                                    autoPlayInterval:
                                        const Duration(seconds: 2),
                                    autoPlayAnimationDuration:
                                        const Duration(seconds: 1),
                                    autoPlay: true,
                                    // enlargeCenterPage: true,
                                    // enlargeFactor: 0.2,
                                    viewportFraction: 1,
                                    height: 335.h,
                                  ),
                                  items: snapshot.data!.docs
                                      .map((doc) => Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 250.h,
                                                      width: 140.w,
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: Image.network(
                                                            doc["logo"],
                                                            fit: BoxFit.fill,
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      width: 15.w,
                                                    ),
                                                    Flexible(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 40.h,
                                                          ),
                                                          Text(doc["title"],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                              '${doc["type"][0]}, ${doc["type"][1]}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                          SizedBox(
                                                            height: 35.h,
                                                          ),
                                                          Text(doc["about"],
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                          SizedBox(
                                                            height: 20.h,
                                                          ),
                                                          Text(
                                                              '₹ ${doc["price"]} onwards',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 20,
                                                      horizontal: 5),
                                                  height: 40.h,
                                                  width: double.infinity,
                                                  decoration: const BoxDecoration(
                                                      //borderRadius: BorderRadius.circular(5),
                                                      color: appthemecolor),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Book now",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 17.sp),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: snapshot.data!.docs
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    return Container(
                                      width: currentIndex == entry.key ? 17 : 8,
                                      height: 8.0,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 3.0,
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: currentIndex == entry.key
                                              ? appthemecolor
                                              : appthemecolor.withOpacity(0.2)),
                                    );
                                  }).toList(),
                                )
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 30.h,
              ),



              // filling fast



              Text(
                "Choices Vast But Filling Fast",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5.h,),
              Text(
                "Hurry, explore range of our fun events",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5.h,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      list1.length,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        //  decoration: BoxDecoration( color: Colors.white,
                        //   borderRadius: BorderRadius.circular(20)
                        //  ),
                        height: 150.h,
                        width: 140.w,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 20,
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        list1[index]["color"].withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20)),
                                height: 120.h,
                                width: 140.w,
                              ),
                            ),
                            Positioned(
                                top: -10,
                                right: -25,
                                bottom: 15,
                                child: Image.asset(
                                  list1[index]["image"],
                                  height: 130.h,
                                  width: 150.w,
                                  fit: BoxFit.fill,
                                )),
                            Positioned(
                              left: 0.5,
                              bottom: 5,
                              child: Container(
                                height: 90.h,
                                width: 140.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      colors: [
                                        list1[index]["color"],
                                        list1[index]["color"].withOpacity(0.0),
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 10,
                              child: Text(
                                list1[index]["name"],
                                style: TextStyle(
                                  fontFamily: 'MyCustomFont',
                                  color: primaryColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 30.h,
              ),


              //more to sports

              Container(
                width: double.infinity,
                color: greycolorshade1,
                child: Padding(
                  padding:  EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("There is more to Sports",style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w600),),
                      SizedBox(height: 5.h,),
                      Text("Get started",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400),),
                      SizedBox(height: 20.h,),
                      Container(
                       // color: Colors.white,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              height: 120.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                gradient:const LinearGradient(
                                   begin: Alignment.bottomLeft,
                                   end: Alignment.topRight,
                                  colors: [ Color.fromARGB(172, 78, 169, 243),Color.fromARGB(146, 71, 52, 133)],
                                  )
                              ),
                            ),
                            ClipPath(
                              clipper: Clip(),
                              child: Container(
                                height: 120.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  gradient:const LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    
                                    colors: [Color.fromARGB(255, 30, 98, 153),Color.fromARGB(255, 199, 225, 247)]),
                                 // color: const Color.fromARGB(255, 103, 178, 239),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: SizedBox(
                                height: 120.h,
                                width: 100.w,
                                child: Image.asset("assets/batsman.png",fit: BoxFit.cover,),),
                            ),
                              Container(     
                                height: 120.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                gradient: LinearGradient(
                                  
                                  begin: Alignment.bottomCenter,
                                  end:Alignment.topCenter ,
                                  colors: [Color.fromARGB(255, 0, 192, 251).withOpacity(0.5),Color.fromARGB(249, 110, 166, 199).withOpacity(0.0)])
                              ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Clip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0); // Top left-point
    path.lineTo(0, size.height*0.8); // Bottom-left point
    path.lineTo(size.width*0.4, size.height/3); // Bottom-right point
    path.lineTo(size.width*0.25, 0); // Bottom-right point
    path.close(); // Close the path to form a triangle
   

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}