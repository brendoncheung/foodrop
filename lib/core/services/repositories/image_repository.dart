import 'package:firebase_storage/firebase_storage.dart';

class ImageRepository {
  FirebaseStorage storage;
  ImageRepository({this.storage});

  Future<String> getDownloadUrlBypath(String path) {
    return storage.ref(path).getDownloadURL();
  }

  Future<List<String>> getAllDownloadUrlByDirectory(String item_id) async {
    //https://dominuskelvin.dev/blog/the-magic-of-future-wait-in-dart/
    List<String> links = List.empty(growable: true);

    Reference reference = storage.ref().child('item').child(item_id);
    ListResult results = await reference.listAll();

    final futures = results.items.map((e) => e.getDownloadURL());

    return Future.wait(futures);
  }
}
