import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_services_provider/app/Network/MaterialNetwork.dart';
import 'package:home_services_provider/app/Network/PaymentNetwork.dart';
import 'package:home_services_provider/app/models/Material.dart';
import 'package:home_services_provider/app/models/Payment.dart';

// import '../models/Enums/PaymentEnum.dart';
import '../models/Bill.dart';

class BillNetwork {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference billsRef = FirebaseFirestore.instance.collection('Bill');
  PaymentNetwork paymentServices = PaymentNetwork();
    MaterialNetwork materialServices = MaterialNetwork();


  Future<List<Bill>> getBillsList() async {
    List<Bill> bills = [];

    QuerySnapshot snapshot = await billsRef.get();
    // var list = snapshot.docs.map((e) => e.data()).toList();

    
    snapshot.docs.forEach((element) async {
      Bill bill = Bill.fromFire(element);
      bill.id = element.id;

      //get bill materials
      bill.materials=[];
      List<dynamic> list=element['materials'];
      list.forEach((value) async {
          Material material=await materialServices.getMaterialById(value['material'].id);
        Map<String,dynamic> matMap={
          "material":material,
          "exist":value['exist'],
          "quantity":value['quantity'],
          "total_price":value['total_price'],
        };
        bill.materials.add(matMap);
        
       });
     
      //get bill payment
      DocumentReference dr = element['payment'];
      Payment payment = Payment(name: '', id: dr.id, type: '');
      payment = await paymentServices.getPaymentById(payment.id);
      bill.payment = payment;


      bills.add(bill);
    });
    Future.delayed(Duration(seconds: 2),
(){
          print(bills.length);

}
    );
    return bills;
  }

  Future<Bill> getBillById(String id) async {
    Bill bill;
    DocumentSnapshot snapshot = await billsRef.doc(id).get();
    bill = Bill.fromFire(snapshot.data());
    bill.id = snapshot.id;

    //get materials
 bill.materials=[];
      List<dynamic> list=snapshot['materials'];
      list.forEach((value) async {
          Material material=await materialServices.getMaterialById(value['material'].id);
        Map<String,dynamic> matMap={
          "material":material,
          "exist":value['exist'],
          "quantity":value['quantity'],
          "total_price":value['total_price'],
        };
        bill.materials.add(matMap);
        
       });
    //get bill payment
    DocumentReference dr = snapshot['payment'];
    // Payment payment = Payment(name: '', id: dr.id);
    Payment payment = await paymentServices.getPaymentById(dr.id);
    bill.payment = payment;



    return bill;
  }
}
