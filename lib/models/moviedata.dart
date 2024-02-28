import 'dart:typed_data';
class Actor {
final Uint8List image;
 String name;

  Actor({required this.image, required this.name});
}

class MovieDetails {
  final String MovieName;
  final List<String> type;
  final String hours;
  final String min;
  final String rating;
  final String censorship;
  final String date;
  final List<String> langauges;
  final String storyline;
  final String trailer;
  final List actor;
  final List directors;
  final String moviePoster;
  

  MovieDetails({
    required this.MovieName,
    required this.type,
    required this.hours,
    required this.min,
    required this.rating,
    required this.date,
    required this.langauges,
    required this.storyline,
    required this.trailer,
    required this.actor,
    required this.directors,
    required this.moviePoster,
    required this.censorship,
  });

  Map<String, dynamic> toJson() => {
    "moviename":MovieName,
    "decription":storyline,
    "Actordata":actor,
    "Directordata":directors,
    "Languages":langauges,
    "TimeInHours":hours,
    "TimeInMin":min,
    "Poster":moviePoster,
    "Type of movie":type,
    "Rating":rating,
    "censorship":censorship,
    "trailerLink":trailer,
    "Date of Release":date,
  };
}


