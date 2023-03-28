import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // aading image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    // saving to the current user. is a pointer to the variable
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      // generating an id for the post
      ref = ref.child(id);
    }

    //  to control the way the data is uploaded
    UploadTask uploadTask = ref.putData(file);

    // getting the data from the snap
    TaskSnapshot snap = await uploadTask;
    // get the url of the uploaded image o show it later
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
