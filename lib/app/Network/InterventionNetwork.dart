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

class InterventionNetwork {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference InterventionsRef =
      FirebaseFirestore.instance.collection('Intervention');
  UserNetwork userServices = UserNetwork();
    ClientNetwork clientServices = ClientNetwork();
    BillNetwork billServices = BillNetwork();

  CategoryNetwork categoryServices = CategoryNetwork();
    ServiceProviderNetwork providerServices = ServiceProviderNetwork();


  Future<List<Intervention>> getInterventionsList() async {
    int index=0;
    List<Intervention> interventions = [];


// if(Interventions.isNotEmpty){
//   Interventions.clear();
// }

    QuerySnapshot snapshot = await InterventionsRef.get();
    var list = snapshot.docs.map((e) => e.data()).toList();
    snapshot.docs.forEach((element) async {
            DocumentReference dr=element['provider'];

      Intervention intervention = Intervention.fromFire(element);
      // interventions.add(intervention);
intervention.id=element.id;
      // intervention.id = element.id;


      //get Branches
      intervention.provider=await providerServices.getProviderById(dr.id);

 // get category
       dr=element['category'];
      Category category=await categoryServices.getCategoryById(dr.id);
      intervention.category=category;

     

      //get client
       dr = element['client'];
      
      Client client = await clientServices.getClientById(dr.id);
      intervention.client=client;



      //get bill  
             dr = element['bill'];

      Bill bill=await billServices.getBillById(dr.id);   
      intervention.bill=bill;
interventions.add(intervention);
print(intervention.description);
index++;
      
      
    });

    return interventions;
  }




   Future<Intervention> getInterventionById(String id) async {
         DocumentSnapshot snapshot = await InterventionsRef.doc(id).get();

         DocumentReference dr=snapshot['provider'];

      Intervention intervention = Intervention.fromFire(snapshot);
      // interventions.add(intervention);
intervention.id=snapshot.id;
      // intervention.id = element.id;


      //get Branches
      intervention.provider=await providerServices.getProviderById(dr.id);

 // get category
       dr=snapshot['category'];
      Category category=await categoryServices.getCategoryById(dr.id);
      intervention.category=category;

     

      //get client
       dr = snapshot['client'];
      
      Client client = await clientServices.getClientById(dr.id);
      intervention.client=client;



      //get bill  
             dr = snapshot['bill'];

      Bill bill=await billServices.getBillById(dr.id);   
      intervention.bill=bill;
print(intervention.description);
return intervention;
  }



}
