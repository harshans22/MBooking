import 'dart:math';
import 'package:movieticket/screens/tikcet.dart';
import 'package:upi_india/upi_india.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieticket/utils/color.dart';


class PaymentScreen extends StatefulWidget {
  final snap;
  final List seat;
  final String theatrename;
  final String date;
  final String time;
  final int amount;
  final String theatreaddress;
  final String theatreicon;
  const PaymentScreen(
      {super.key,
      required this.snap,
      required this.amount,
      required this.seat,
      required this.date,
      required this.theatrename,
      required this.time,
      required this.theatreaddress,
      required this.theatreicon});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late int orderid;
  Future<UpiResponse>? _transaction;
  final UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;
  @override
  void initState() {
    // TODO: implement initState
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((err) {
      print(err);
      apps = [];
    });
    super.initState();
    orderid = Random().nextInt(10000000) +
        Random().nextInt(10000000) +
        Random().nextInt(10000000) +
        8859882964; //to create random id each and everytime
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "aikanshtiwari007@okicici",
      receiverName: "harsh",
      transactionRefId: "Testing upi india payment",
      amount: 10,
    );
  }

  Widget displayUpiApps() {
    if (apps == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (apps!.isEmpty) {
      return const Center(
        child: Text(
          "No apps found to handle transaction",
        ),
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Payment"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //movie ticket details
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: greycolorshade1,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Image.network(
                      widget.snap["Poster"],
                      width: 100.w,
                      height: 141.h,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.snap["moviename"],
                              style:  TextStyle(
                                  fontSize: 20.sp,
                                  color: appthemecolor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                         SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset("assets/video-play.svg"),
                             SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '${widget.snap["Type of movie"][0]}, ${widget.snap["Type of movie"][1]}',
                              style:  TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                         SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset("assets/location.svg"),
                             SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              widget.theatrename,
                              style:  TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                         SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset("assets/clock.svg"),
                             SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '${widget.date}.02.2024  • ${widget.time}',
                              style:  TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    "Order ID",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    orderid.toString(),
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    "Seat",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  Row(
                    children: [
                      ...List.generate(
                        widget.seat.length - 1,
                        (index) => Text(
                          '${widget.seat[index]}, ',
                          style:  TextStyle(
                            color: primaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '${widget.seat[widget.seat.length - 1]} ',
                        style:  TextStyle(
                          color: primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              //discount container
              Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: greycolorshade1,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/discount-shape.svg"),
                          SizedBox(
                            width: 10.w,
                          ),
                           Text(
                            "discount code",
                            style: TextStyle(
                                color: Color(0xFF949494), fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ),
                    //apply now button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: appthemecolor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child:  Text(
                          "Apply",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Divider(
                color: Color.fromARGB(193, 153, 153, 153),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total"),
                  Text(
                    '₹${widget.amount}.000',
                    style:  TextStyle(
                        color: appthemecolor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
               Text(
                "Payment Method",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15.h,
              ),
              //upi
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: greycolorshade1,
                    borderRadius: BorderRadius.circular(10)),
                child:displayUpiApps()
                // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     SizedBox(
                //       child: Row(
                //         children: [
                //           ClipRRect(
                //             borderRadius: BorderRadius.circular(10),
                //             child: Container(
                //                 color: Colors.white,
                //                 padding: const EdgeInsets.all(10),
                //                 child: Image.asset(
                //                   "assets/upi.webp",
                //                   height: 30.h,
                //                   width: 60.w,
                //                   fit: BoxFit.fill,
                //                 )),
                //           ),
                //           SizedBox(
                //             width: 8.w,
                //           ),
                //                         Text(
                //             "Pay by any UPI app",
                //             style: TextStyle(fontSize: 14.sp),
                //           ),
                //         ],
                //       ),
                //     ),
                //     SvgPicture.asset("assets/arrow-right.svg",height: 20.h,)
                //   ],
                // ),
              ),
              SizedBox(
                height: 15.h,
              ),
              // atm cards
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: greycolorshade1,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/atm-card.png",
                                  height: 30.h,
                                  width: 60.w,
                                  fit: BoxFit.fill,
                                )),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                                        Text(
                            "Pay Via any Debit/Credit Card",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset("assets/arrow-right.svg",height: 20.h,)
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              // net banking cards
              Container(
                padding:const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: greycolorshade1,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/mobile-banking.png",
                                  height: 30.h,
                                  width: 60.w,
                                  fit: BoxFit.fill,
                                )),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                                        Text(
                            "Pay through Net banking",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset("assets/arrow-right.svg",height: 20.h,)
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              // vouchers
              Container(
                padding:const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: greycolorshade1,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/voucher.png",
                                  height: 30.h,
                                  width: 60.w,
                                  fit: BoxFit.fill,
                                )),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                                        Text(
                            "Use any gift voucher",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset("assets/arrow-right.svg",height: 20.h,)
                  ],
                ),
              ),
              SizedBox(height: 15.h,),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ticketScreen(
                                date: widget.date,
                                price: widget.amount,
                                snap: widget.snap,
                                theatre: widget.theatrename,
                                time: widget.time,
                                theatreAdress: widget.theatreaddress,
                                seat: widget.seat,
                                theatreicon: widget.theatreicon,
                                Orderid: orderid.toString(),
                              )));

                },
                child: Container(
                          height: 55.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(30),
                                right: Radius.circular(30)),
                            color: appthemecolor,
                          ),
                          alignment: Alignment.center,
                          child:  Text(
                            "Continue",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
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
