import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:movieticket/utils/color.dart";

class ticket extends StatefulWidget {
  final snap;
  final String theatre;
  final String time;
  final String date;
  final int price;
  final List seat;
  final String theatreAdress;
  final String theatreicon;
  final String Orderid;
  const ticket({
    super.key,
    required this.date,
    required this.price,
    required this.snap,
    required this.theatre,
    required this.time,
    required this.seat,
    required this.theatreAdress,
    required this.theatreicon,
    required this.Orderid,
  });

  @override
  State<ticket> createState() => _ticketScreenState();
}

class _ticketScreenState extends State<ticket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("My Ticket"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Container(
                height: 680.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                widget.snap["Poster"],
                                height: 200.h,
                                fit: BoxFit.fill,
                              )),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30.h,
                              ),
                              Text(
                                widget.snap["moviename"],
                                style:  TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/clock.svg",
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                      '${widget.snap["TimeInHours"]} hours ${widget.snap["TimeInMin"]} minutes',
                                      style:  TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400))
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/video.svg",
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  SizedBox(
                                    width: 100.w,
                                    child: Text(
                                        '${widget.snap["Type of movie"][0]}, ${widget.snap["Type of movie"][1]}',
                                        maxLines: 2,
                                        style:  TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/calendar.svg",
                                  color: Color.fromARGB(255, 88, 87, 87),
                                  height: 40.h,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.time,
                                      style:  TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      '${widget.date}.02.2024',
                                      style:  TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/Seat Cinema.svg",
                                  height: 40.h,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                      "Screen 4",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Row(
                                      children: [
                                         Text(
                                          'Seat ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        ...List.generate(
                                          widget.seat.length,
                                          (index) => Text(
                                            '${widget.seat[index]}, ',
                                            style:  TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset("assets/money-send.svg"),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            '₹${widget.price}.000',
                            style:  TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/location.svg",
                            color: Colors.black,
                            height: 25.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget.theatre,
                                    style:  TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Image.network(
                                    widget.theatreicon,
                                    height: 30.h,
                                    width: 40.w,
                                    fit: BoxFit.fill,
                                  )
                                ],
                              ),
                              Text(
                                widget.theatreAdress,
                                style:  TextStyle(
                                    color: Colors.black, fontSize: 14.sp),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/note.svg"),
                          SizedBox(
                            width: 10.w,
                          ),
                          const Expanded(
                              child: Text(
                            "Show this QR code to the ticket counter to recieve your ticket",
                            style: TextStyle(color: Colors.black),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SvgPicture.asset("assets/dotted line.svg"),
                      SizedBox(
                        height: 10.h,
                      ),
                      Image.asset(
                        "assets/qr code.png",
                        height: 150.h,
                        width: 150.w,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Order ID: ${widget.Orderid}',
                        style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),
                      )
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
