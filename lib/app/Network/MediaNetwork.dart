import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Media.dart';

class MediaNetwork{

   FirebaseFirestore firestore = FirebaseFirestore.instance;
 CollectionReference providersRef =
      FirebaseFirestore.instance.collection('Provider');

  // Future<List<Media>> getMaterialList() async {
  //   List<Media> medias = [];

  //   QuerySnapshot snapshot = await mediaRef.get();
  //   var list = snapshot.docs.map((e) => e.data()).toList();
  //   snapshot.docs.forEach((element) async {
  //     Media media = Media.fromFire(element);

  //     media.id = element.id;
  //     medias.add(media);
  //     // print(media.name);
  //   });
  //   return medias;
  // }

  //  Future<Media> getMaterialById(String id) async {
  //   Media media;
  //   DocumentSnapshot snapshot = await mediaRef.doc(id).get();
  //   media = Media.fromFire(snapshot.data());
  //   media.id = snapshot.id;
  //   return media;
  // }

  addMedia( List<Map<String,dynamic>> data,id){
    data.forEach((element) {
          providersRef.doc(id).collection('Media').add(element).then((value) => print('Media Added')).catchError((e){print('can not add media');}   );

    });
  }
}