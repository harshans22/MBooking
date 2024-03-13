import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieticket/screens/payment.dart';
import 'package:movieticket/utils/color.dart';

class SeatSelection extends StatefulWidget {
  final snap;
  final String theatrename;
 final String theatreAddress;
 final String theatreLogo;

  const SeatSelection(
      {super.key, required this.snap, required this.theatrename,required this.theatreAddress,required this.theatreLogo});

  @override
  State<SeatSelection> createState() => _SeatSelectionState();
}

List<List<int>> seat = [
  [4, 9],
  [3, 9],
  [5, 9]
];

List<String> selected = [];

class _SeatSelectionState extends State<SeatSelection> {
  //function to  price screen
  _showprice() {
    int price = pricecalculator();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total", style: TextStyle(fontSize: 16)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "₹ ${price}.000",
                    style: TextStyle(fontSize: 25, color: appthemecolor),
                  ),
                ],
              ),
              //buy button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                              snap: widget.snap,
                              amount: price,
                              seat: selected,
                              date: selecteddate,
                              theatrename: widget.theatrename,
                              time: selectedtime,
                              theatreaddress:widget.theatreAddress,
                              theatreicon:widget.theatreLogo,
                              )));
                },
                child: Container(
                  height: 50.h,
                  width: 150.w,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(40),
                          right: Radius.circular(40)),
                      color: appthemecolor),
                  alignment: Alignment.center,
                  child: const Text(
                    "Buy ticket",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  //calculate price
  int pricecalculator() {
    int price = 0;
    for (int i = 0; i < selected.length; i++) {
      int seatnumber = selected[i].codeUnitAt(0) - 64;
      if (seatnumber <= seat[0][0]) {
        price += 180;
      } else if (seatnumber <= (seat[0][0] + seat[1][0])) {
        price += 250;
      } else if (seatnumber <= (seat[0][0] + seat[1][0] + seat[2][0])) {
        price += 350;
      }
    }
    return price;
  }

  int dateindex = 2;
  int timeindex = 2;
  String selectedtime = "";
  List booked = [];
  String selecteddate = "";
  @override
  void initState() {
    // TODO: implement initState
    selectedtime = widget.snap["timeOfshows"][timeindex];
    bookedseat(selectedtime);
    selecteddate = date[dateindex][2];
    super.initState();
  }

  bookedseat(String selectedtime) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("timings")
          .doc(selectedtime)
          .get();
      booked = snapshot["booked"];
      setState(() {});
    } catch (err) {
      print(err.toString());
    }
  }

  List<List> date = [
    [false, "Dec", '9'],
    [false, "Dec", '10'],
    [true, "Dec", '11'],
    [false, "Dec", '12'],
    [false, "Dec", '13'],
    [false, "Dec", '14']
  ];
 
  int length =
      seat[0][0] + seat[1][0] + seat[2][0]; //for sized box of seat selection
  @override
  Widget build(BuildContext context) {
    int seatnumber = -1; //for adding seatnumber alphabet
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mobileBackgroundColor,
        title: const Text("Select seat"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "All eyes this way please",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            //screen movie theatre
            Stack(
              children: [
                ClipPath(
                  clipper: Clip(),
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          appthemecolor.withOpacity(0.3),
                          const Color.fromARGB(0, 98, 96, 96)
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 3,
                    color: appthemecolor,
                  ),
                ),
              ],
            ),
            // seats
            SizedBox(
              height: (length * 48).h,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: seat.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Text(
                            index == 2
                                ? "Rs.350 VIP"
                                : (index == 1
                                    ? "Rs.250 Premium"
                                    : "Rs.180 Classic"),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          ...List.generate(seat[index][0], (row) {
                            seatnumber++; //to give seatname
                            int c = 0;
                            return Wrap(
                              children: List.generate(seat[index][1], (col) {
                                if (col == seat[index][1] ~/ 2 && c == 0) {
                                  c++;
                                  return const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: SizedBox(
                                      height: 25,
                                      width: 25,
                                    ),
                                  );
                                }
                                String seatname =
                                    '${String.fromCharCode(65 + seatnumber)}${col + 1 - c}';
                                bool isbooked = booked.contains(seatname);
                                bool isselected = selected.contains(seatname);
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (isselected) {
                                        selected.remove(seatname);
                                      } else {
                                        selected.add(seatname);
                                      }

                                      setState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        //  boxShadow: [
                                        // BoxShadow(
                                        //   color: Colors.grey
                                        //       .withOpacity(0.5), // shadow color
                                        //   spreadRadius: 2, // spread radius
                                        //   blurRadius: 3, // blur radius
                                        //   offset: const Offset(0,
                                        //       3), // changes position of shadow
                                        // ),
                                        // ],
                                        color: isbooked
                                            ? appthemecolor.withOpacity(0.2)
                                            : (isselected
                                                ? appthemecolor
                                                : greycolorshade1),
                                      ),
                                      height: 25,
                                      width: 25.w,
                                      alignment: Alignment.center,
                                      child: Text(
                                        seatname,
                                        style: TextStyle(
                                            color: isbooked
                                                ? appthemecolor
                                                : (isselected
                                                    ? Colors.black
                                                    : Colors.grey),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          }),
                          const Divider(
                            color: Colors.grey,
                            indent: 30,
                            endIndent: 30,
                            thickness: 1,
                          )
                        ],
                      ),
                    );
                  }),
            ),
            //selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: greycolorshade1,
                      ),
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "Available",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFFF2F2F2)),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: appthemecolor.withOpacity(0.2),
                      ),
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "Reserved",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFFF2F2F2)),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: appthemecolor,
                      ),
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "Selected",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFFF2F2F2),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            //date selection
            const Text(
              "Select Date & Time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.snap["timeOfshows"].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          if (timeindex != index) {
                            timeindex = index;
                            selectedtime =
                                widget.snap["timeOfshows"][timeindex];
                            await bookedseat(selectedtime);
                            
                            selected = [];
                          }
                          setState(() {});
                        },
                        child: Container(
                          width: 80.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: timeindex == index
                                  ? appthemecolor
                                  : Colors.transparent,
                            ),
                            borderRadius:
                                const BorderRadiusDirectional.horizontal(
                              start: Radius.circular(20),
                              end: Radius.circular(20),
                            ),
                            color: timeindex == index
                                ? appthemecolor.withOpacity(0.2)
                                : greycolorshade1,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            widget.snap["timeOfshows"][index],
                            style: const TextStyle(
                                color: Color.fromARGB(255, 203, 202, 202)),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            //date
            SizedBox(
              height: 105.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: date.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (date[index][0] == false) {
                            date[index][0] = true;
                            date[dateindex][0] = false;
                            dateindex = index;
                            selecteddate = date[dateindex][2];
                          }
                          setState(() {});
                        },
                        child: Container(
                          height: 60,
                          width: 40.w,
                          decoration: BoxDecoration(
                              color: date[index][0]
                                  ? appthemecolor
                                  : greycolorshade1,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                  bottom: Radius.circular(20))),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                //month name
                                "Dec",
                                style: TextStyle(
                                    color: date[index][0]
                                        ? Colors.black
                                        : primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Container(
                                height: 35.h,
                                width: 35.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: date[index][0]
                                      ? const Color(0xFF1D1D1D)
                                      : const Color.fromARGB(255, 54, 54, 54),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  //date of movie
                                  date[index][2],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            selected.isNotEmpty ? _showprice() : Container(),
          ],
        ),
      ),
    );
  }
}

//for screen
class Clip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height); // Bottom-left corner
    path.lineTo(size.width * 0.1, 0); // Top-left corner
    path.lineTo(size.width * 0.9, 0); // Top-right corner
    path.lineTo(size.width, size.height); // Bottom-right corner
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
