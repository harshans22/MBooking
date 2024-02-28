import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movieticket/models/moviedata.dart';
import 'package:movieticket/methods/storage.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
      String moviename,
      String Storyline,
      List<dynamic> actor,
      List<dynamic> director,
      List<String> languages,
      String hours,
      String min,
      Uint8List movieposter,
      List<String> type,
      String rating,
      String censorship,
      String trailerlink,
      String date) async {
    String res = "some error occured";
    List<Map> actorimagelink = [];
    List<Map> directorimagelink = [];
    try {
      //creating image director link
      for (int i = 0; i < actor.length; i++) {
        String photourl = await StorageMethods()
            .uploadImageToStorage(actor[i].name, actor[i].image,"cast",moviename);
        Map<String, String> currentactor = {actor[i].name: photourl};
        actorimagelink.insert(i, currentactor);
      }
      //creating image director link
      for (int i = 0; i < director.length; i++) {
        String photourl = await StorageMethods()
            .uploadImageToStorage(director[i].name, director[i].image,"director",moviename);
        Map<String, String> currentdirector = {actor[i].name: photourl};
        directorimagelink.insert(i, currentdirector);
      }
      String posterURL = await StorageMethods()
            .uploadImageToStorage("movieposter",movieposter,"Poster",moviename);
      MovieDetails movie = MovieDetails(
          MovieName: moviename,
          type:type ,
          hours: hours,
          min: min,
          rating: rating,
          date: date,
          langauges: languages,
          storyline: Storyline,
          trailer: trailerlink,
          actor: actorimagelink,
          directors: directorimagelink,
          moviePoster: posterURL,
          censorship: censorship);
      _firestore.collection("Movie data").doc(moviename).set(movie.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
      print(err.toString());
    }
    return res;
  }
}
