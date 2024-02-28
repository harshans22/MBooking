import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(
      String childName, Uint8List file, String type, String moviename) async {
    Reference ref =
        _storage.ref().child(moviename).child(type).child(childName);
    // for assiging unique id to posts
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask; //  metadata data of uploaded file
    // to download link of our image which is stored in firestore
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
