import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieticket/utils/color.dart';

class Moviecard extends StatefulWidget {
  final snap;
  const Moviecard({super.key, required this.snap});

  @override
  State<Moviecard> createState() => _MoviecardState();
}

class _MoviecardState extends State<Moviecard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.snap["Poster"],
                  height: 300.h,
                  width: 220.w,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.snap["moviename"],
            style: const TextStyle(
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${widget.snap["TimeInHours"]}h${widget.snap["TimeInMin"]}m | ${widget.snap["Type of movie"][0]}, ${widget.snap["Type of movie"][1]}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFFBFBFBF)),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "⭐ ${widget.snap["Rating"]} ",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              const Text(
                "(1.222)",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFFBFBFBF)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
