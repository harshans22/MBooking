import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieticket/utils/color.dart';

class MovieCard extends StatefulWidget {
  List<String> images = [];
  int index;
  MovieCard({super.key, required this.images,required this.index});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.asset(
              widget.images[widget.index],
            ),),);
  }
}
