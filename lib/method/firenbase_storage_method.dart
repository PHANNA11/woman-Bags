import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageMethod {
  Reference get firestorage => FirebaseStorage.instance.ref();
  Future<String?> getFileStorage() async {
    try {
      return firestorage.child("files/~2Fimage/test1.png").getDownloadURL();
    } catch (e) {
      return '';
    }
  }
}
