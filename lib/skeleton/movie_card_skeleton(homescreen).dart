import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";


class SkeletonMovieCard extends StatelessWidget {
  const SkeletonMovieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children:[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
           color: Colors.white,),
                  height: 300.h,
                    width: 220.w,  
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
           Container(width: 200.w,
           height: 10.h,
           decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
           color: Colors.white,),),
          const SizedBox(
            height: 5,
          ),
         Container(width: 100.w,
         height: 10.h,
         decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
           color: Colors.white,),
         ),
        
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 80.w,height: 10.h,decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
           color: Colors.white,),)
             
            ],
          )
        ],
      );
  }
}