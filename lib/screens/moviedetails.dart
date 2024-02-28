import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import "package:movieticket/utils/color.dart";
import 'package:readmore/readmore.dart';

class Moviedetails extends StatefulWidget {
  final snap;
  const Moviedetails({super.key, required this.snap});

  @override
  State<Moviedetails> createState() => _MoviedetailsState();
}

class _MoviedetailsState extends State<Moviedetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.transparent,
            pinned: true,
            // floating: true,
            stretch: true,
            expandedHeight: 390.h,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
              background: Stack(children: [
                Image.network(
                  widget.snap["Poster"],
                  width: double.infinity,
                  height: 350.h,
                  fit: BoxFit.fill,
                ),
                //review box
                Positioned(
                  top: 200,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: greycolorshade1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap["moviename"],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            '${widget.snap["TimeInHours"]}h${widget.snap["TimeInMin"]}m • ${widget.snap["Date of Release"]}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFBFBFBF),
                            )),
                        const SizedBox(
                          height: 35,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Review ',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: '⭐', style: TextStyle(fontSize: 13)),
                              TextSpan(text: ' ${widget.snap["Rating"]}'),
                              const TextSpan(
                                  text: ' (1.222)',
                                  style: TextStyle(
                                      fontSize: 10, color: Color(0xFFBFBFBF))),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RatingBar.builder(
                                unratedColor: Color(0xFF575757),
                                itemSize: 30,
                                glow: false,
                                //initialRating:double.parse(widget.snap["Rating"]),
                                initialRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  widget.snap["trailerLink"];
                                },
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                      side: const BorderSide(
                                        color: Color(0xFFBFBFBF),
                                        width: 1.0,
                                      )),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.play_arrow,
                                      size: 18,
                                      color: Color(0xFFBFBFBF),
                                    ),
                                    Text(
                                      " Watch trailer",
                                      style: TextStyle(
                                          color: Color(0xFFBFBFBF),
                                          fontSize: 12,
                                          letterSpacing: 0.3),
                                    )
                                  ],
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ),
            //description and all other stuff
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23.0),
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("Movie genre:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFBFBFBF),
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            '${widget.snap["Type of movie"][0]}, ${widget.snap["Type of movie"][1]}, ${widget.snap["Type of movie"][2]}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text("Censorship:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFBFBFBF),
                              )),
                          const SizedBox(
                            width: 23,
                          ),
                          Text(
                            '${widget.snap["censorship"]}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text("Language",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFBFBFBF),
                              )),
                          const SizedBox(
                            width: 35,
                          ),
                          Text(
                            '${widget.snap["Languages"][0]}, ${widget.snap["Languages"][1]} ',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Storyline",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ReadMoreText(
                        '${widget.snap["description"]}',
                        textAlign: TextAlign.justify,
                        trimLines: 4,
                        trimCollapsedText: "See more",
                        moreStyle: const TextStyle(color: appthemecolor),
                        lessStyle: const TextStyle(color: appthemecolor),
                        trimExpandedText: "See less",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      //actor data
                      const Text(
                        "Actor",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 60.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.snap["Actordata"].length,
                            itemBuilder: (context, index) {
                              var actorData = widget.snap["Actordata"][index];
                              var actorName = actorData.keys.first;
                              var actorImage = actorData[actorName];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: greycolorshade1,
                                  ),
                                  padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 17,
                                        backgroundImage: NetworkImage(actorImage),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                      width: 60,
                                        child: Text(
                                          actorName,
                                          maxLines: 2,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(fontSize: 14,color:primaryColor ,
                                          overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                       const SizedBox(
                        height: 20,
                      ),
                        //director data
                      const Text(
                        "Director",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 60.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.snap["Directordata"].length,
                            itemBuilder: (context, index) {
                              var actorData = widget.snap["Directordata"][index];
                              var actorName = actorData.keys.first;
                              var actorImage = actorData[actorName];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: greycolorshade1,
                                  ),
                                  padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 17,
                                        backgroundImage: NetworkImage(actorImage),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                      width: 60,
                                        child: Text(
                                          actorName,
                                          maxLines: 2,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(fontSize: 14,color:primaryColor ,
                                          overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ]),
              ),
            ),
          ]))
        ],
      ),
    );
  }
}
