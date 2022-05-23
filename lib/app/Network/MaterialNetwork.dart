import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/MaterialMod.dart';

class MaterialNetwork {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference materialRef =
      FirebaseFirestore.instance.collection('Material');

  Future<List<MaterialMod>> getMaterialList() async {
    List<MaterialMod> materials = [];

    QuerySnapshot snapshot = await materialRef.get();
    var list = snapshot.docs.map((e) => e.data()).toList();
    snapshot.docs.forEach((element) async {
      MaterialMod material = MaterialMod.fromFire(element);

      material.id = element.id;
      materials.add(material);
      // print(material.name);
    });
    return materials;
  }

  Future<MaterialMod> getMaterialById(String id) async {
    MaterialMod material;
    DocumentSnapshot snapshot = await materialRef.doc(id).get();
    material = MaterialMod.fromFire(snapshot.data());
    material.id = snapshot.id;
    return material;
  }

  Future<DocumentReference> addMaterial(data) async {
    try {
      DocumentReference dr = await materialRef.add(data);
      return dr;
    } catch (e) {
      print("add material error " + e);
    }
    // materialRef
    //     .add(data)
    //     .then((value) => print('Material Added'))
    //     .catchError((e) {
    //   print('can not add material');
    // });
  }
}
