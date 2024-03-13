import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movieticket/utils/color.dart';

class Cinemaupload extends StatefulWidget {
  const Cinemaupload({super.key});

  @override
  State<Cinemaupload> createState() => _CinemauploadState();
}

class _CinemauploadState extends State<Cinemaupload> {
  List<String> list = ["21:45", "17:10", "11:50", "9:10", "19:55", "12:25", "16:15"];

  

  TextEditingController controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> toJson() => {
        "timeOfshows": list,
      };
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          actions: [
            TextButton(
                onPressed: () async {
                  try {
                    await _firestore
                        .collection("Movie data")
                        .doc("X-Men: Apocalypse")
                        .set(toJson(), SetOptions(merge: true));
                    print('success');
                  } catch (err) {
                    print(err.toString());
                  }
                },
                child: const Text("Uplaod")),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration:
                    const InputDecoration(hintText: "enter movie languages"),
                onSubmitted: (value) {
                  list.add(value);
                  controller.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
