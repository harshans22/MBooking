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
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Events"),
        backgroundColor: mobileBackgroundColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10.0),
        child: Column(
          children: [
            FutureBuilder(
                future: FirebaseFirestore.instance.collection("events").get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  return SizedBox(
                    height: 100.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child:Column(
                              children: [
                                SizedBox(height: 90.h,
                                width: 80.w,
                                  child: ClipRRect(borderRadius: BorderRadius.circular(10),
                                    child: Image.network(snapshot.data!.docs[index]["logo"],fit: BoxFit.cover,)),),
                              ],
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
