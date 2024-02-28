import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieticket/screens/moviedetails.dart';
import 'package:movieticket/utils/color.dart';

class comingsoon extends StatefulWidget {
  final snap;
  const comingsoon({super.key, required this.snap});

  @override
  State<comingsoon> createState() => _MoviecardState();
}

class _MoviecardState extends State<comingsoon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 10),
      color: mobileBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Moviedetails(
                              snap: widget.snap,
                            )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.snap["Poster"],
                  height: 200.h,
                  width: 150.w,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Text(widget.snap["moviename"],style: const TextStyle(color:appthemecolor ,fontSize:16,fontWeight: FontWeight.w600 ),),
            const SizedBox(height: 5,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("assets/video.svg",),
                Text(' ${widget.snap["Type of movie"][0]}, ${widget.snap["Type of movie"][1]}',style:const TextStyle(color: Color(0xFFDEDEDE),fontSize: 13),)
              ],
            ),
            const SizedBox(height: 5,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("assets/calendar.svg",),
                Text(' ${widget.snap["Date of Release"]}',style:const TextStyle(color: Color(0xFFDEDEDE),fontSize: 13),)
              ],
            ),
        ],
      ),
    );
  }
}
