import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_services_provider/app/Network/BillNetwork.dart';
import 'package:home_services_provider/app/Network/CategoryNetwork.dart';
import 'package:home_services_provider/app/Network/ClientNetwork.dart';
import 'package:home_services_provider/app/Network/ServiceProviderNetwork.dart';
import 'package:home_services_provider/app/Network/UserNetwork.dart';
import 'package:home_services_provider/app/models/Bill.dart';
import 'package:home_services_provider/app/models/Category.dart';
import 'package:home_services_provider/app/models/Client.dart';
import 'package:home_services_provider/app/models/Intervention.dart';

import '../models/Media.dart';

class InterventionNetwork {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference InterventionsRef =
      FirebaseFirestore.instance.collection('Intervention');

  CollectionReference providers =
      FirebaseFirestore.instance.collection('Provider');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('Category');
  CollectionReference clients = FirebaseFirestore.instance.collection('Client');

  UserNetwork userServices = UserNetwork();
  ClientNetwork clientServices = ClientNetwork();

  BillNetwork billServices = BillNetwork();

  CategoryNetwork categoryServices = CategoryNetwork();
  ServiceProviderNetwork providerServices = ServiceProviderNetwork();

  Future<DocumentReference> addIntervention(data) async {
    var d = await InterventionsRef.add(data);
    return d;
  }

  DocumentReference getClientRef(String id) {
    return firestore.doc('Client/' + id);
  }

  DocumentReference getProviderRef(String id) {
    return firestore.doc('Provider/' + id);
  }

  Future<List<Intervention>> getInterventionsList(String id) async {
    List<Intervention> interventions = [];

// if(Interventions.isNotEmpty){
//   Interventions.clear();
// }
    var ref = getProviderRef(id);
    print(ref);
    QuerySnapshot snapshot =
        await InterventionsRef.where('provider', isEqualTo: ref).get();
    snapshot.docs.forEach((element) async {
      print(element.data());
      DocumentReference dr = element['provider'];

      Intervention intervention = Intervention.fromFire(element);
      // interventions.add(intervention);
      intervention.id = element.id;
      // intervention.id = element.id;

      //get Branches
      if (dr != null) {
        intervention.provider = await providerServices.getProviderById(dr.id);
      } else {
        intervention.provider = null;
      }
      // get category
      dr = element['category'];
      Category category = await categoryServices.getCategoryById(dr.id);
      intervention.category = category;

      //get client
      dr = element['client'];

      Client client = await clientServices.getClientById(dr.id);
      intervention.client = client;

      //get media
      List<Media> media = await getMediaListByProvider(element.id);
      print('object 13');
      intervention.media = media;

      //get bill
      dr = element['bill'];

      // Bill bill = await billServices.getBillById(dr.id);
      // intervention.bill = bill;
      interventions.add(intervention);
    });
    print('leeen' + interventions.length.toString());
    return interventions;
  }

  Future<Intervention> getInterventionById(String id) async {
    print('object 1');
    DocumentSnapshot snapshot = await InterventionsRef.doc(id).get();
    print('object 2');
    DocumentReference dr = snapshot['provider'];
    print('object 3');
    Intervention intervention = Intervention.fromFire(snapshot);
    print('object 4'); // interventions.add(intervention);
    intervention.id = snapshot.id;
    // intervention.id = element.id;
    print('object 5');
    //get Branches
    intervention.provider = await providerServices.getProviderById(dr.id);
    print('object 6');
    // get category
    dr = snapshot['category'];
    print('object 7');
    Category category = await categoryServices.getCategoryById(dr.id);
    print('object 8');
    intervention.category = category;
    print('object 9');
    //get client
    dr = snapshot['client'];
    print('object 10');
    Client client = await clientServices.getClientById(dr.id);
    print('object 11');
    intervention.client = client;
    print('object 12');
    //get media
    // dr = snapshot['Media'];

    List<Media> media = await getMediaListByProvider(snapshot.id);
    print('object 13');
    intervention.media = media;
    print('lenmed');
    print(media.length);

    //get bill
    dr = snapshot['bill'];

    Bill bill = await billServices.getBillById(dr.id);
    intervention.bill = bill;
    print(intervention.description);
    return intervention;
  }

  Future<List<Media>> getMediaListByProvider(String id) async {
    try {
      print('media here');

      // List<Image> iml = [];
      // List<File> filel = [];
      List<Media> mediaList = [];
      print('media here');
      QuerySnapshot snapshot =
          await InterventionsRef.doc(id).collection('Media').get();
      // var list = snapshot.docs.map((e) => e.data()).tofire().toList();
      print('media here');
      snapshot.docs.forEach((element) {
        Media med = Media.fromFire(element);
        med.id = element.id;
        mediaList.add(med);
        print(element);
      });
      // snapshot.docs.forEach((element) async {
      //   filel.add(File(element.path));
      //   iml.add(filel.last);
      // });
      return mediaList;
    } catch (e) {
      print("media test");
      print(e);
    }
  }
}
