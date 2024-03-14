import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieticket/utils/color.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    print("rebuild events");
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Events"),
        backgroundColor: mobileBackgroundColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                            padding:const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Stack(
                                  children:[ SizedBox(
                                    height: 90.h,
                                    width: 150.w,
                                    child: ClipRRect(
                                       borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          snapshot.data!.docs[index]["logo"],
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                      Container(
                                          height: 90.h,
                                    width: 150.w,
                                        decoration: BoxDecoration( borderRadius: BorderRadius.circular(10),
                                          color: Color.fromARGB(255, 15, 14, 14).withOpacity(0.7)),
                                          alignment: Alignment.center,
                                        child: Text(snapshot.data!.docs[index]["logoname"],style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500),),
                                      )
                                      ]
                                ),
                              ],
                            ),
                          );
                        })),
                  );
                }),
                SizedBox(height: 25.h,),
                //recomeded for you
                Text("Offers Recommended For You",style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w500)),
                SizedBox(height: 20.h,),
            FutureBuilder(
                future: FirebaseFirestore.instance.collection("Recommended").get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  return SizedBox(
                    height: 150.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal:10.0),
                            child:Container(
                              width: 310.w,
                             
                              decoration: BoxDecoration(
                                color: greycolorshade1,
                                borderRadius: BorderRadius.circular(10),
                              )
                              ,
                             child: Column(
                              children: [
                                Container(
                                  padding:const EdgeInsets.all(10),
                                  height: 100.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: appthemecolor.withOpacity(0.45),
                                    borderRadius:const BorderRadiusDirectional.only(topStart: Radius.circular(10),topEnd: Radius.circular(10),bottomStart: Radius.circular(20),bottomEnd: Radius.circular(20)),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(radius: 35,
                                            backgroundImage: NetworkImage(snapshot.data!.docs[index]["logo"],),
                                          ),
                                          SizedBox(width: 20.w,),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(snapshot.data!.docs[index]["title"],maxLines: 1,
                                                style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500)),
                                                 SizedBox(height: 15.h,),
                                                Row(
                                                  children: [
                                                    Text(snapshot.data!.docs[index]["type"][0]+", " +snapshot.data!.docs[index]["type"][1],
                                                    maxLines: 2,overflow: TextOverflow.clip, style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w500,color: Color.fromARGB(255, 0, 0, 0),)),
                                                   
                                                    Text("  |  "+snapshot.data!.docs[index]["Date"],
                                                    maxLines: 2,overflow: TextOverflow.clip, style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w500,color: Color.fromARGB(255, 0, 0, 0),)),
                                                  ],
                                                ),
                                                 SizedBox(height: 5.h,),
                                                 Text(snapshot.data!.docs[index]["Venue"],
                                                    maxLines: 2,overflow: TextOverflow.clip, style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w500,color: Color.fromARGB(255, 15, 15, 15),)),
                                                    
                                              ],
                                            ),
                                          )
                                      
                                        ],
                                      ),
                                    
                                    ],
                                  ),
                                ),
                                  Divider(color: appthemecolor,height: 0,indent: 20,endIndent: 20,thickness: 2,)
                              ],
                             ),
                            ),
                          );
                        })),
                  );
                }),
          ],
        ),
      ),
    );
  }
} 
