// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_services_provider/app/Network/MaterialNetwork.dart';
import 'package:home_services_provider/app/Network/PaymentNetwork.dart';
import 'package:home_services_provider/app/models/MaterialMod.dart';
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
      bill.materials = [];
      List<dynamic> list = element['materials'];
      list.forEach((value) async {
        MaterialMod material =
            await materialServices.getMaterialById(value['material'].id);
        Map<String, dynamic> matMap = {
          "material": material,
          "exist": value['exist'],
          "quantity": value['quantity'],
          "total_price": value['total_price'],
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
    Future.delayed(Duration(seconds: 2), () {
      print(bills.length);
    });
    return bills;
  }

  Future<Bill> getBillById(String id) async {
    Bill bill;
    DocumentSnapshot snapshot = await billsRef.doc(id).get();
    bill = Bill.fromFire(snapshot.data());
    bill.id = snapshot.id;

    //get materials
    QuerySnapshot getmat = await billsRef.doc(id).collection('Material').get();
    bill.materials = [];
    // List<dynamic> list = snapshot['materials'];
    getmat.docs.forEach((value) async {
      MaterialMod material =
          await materialServices.getMaterialById(value['material'].id);
      Map<String, dynamic> matMap = {
        "material": material,
        // "exist": value['exist'],
        "name": value['name'],
        "quantity": value['count'],
        "total_price": value['price'],
      };
      bill.materials.add(matMap);
    });
    //get bill payment
    // DocumentReference dr = snapshot['payment'];
    // // Payment payment = Payment(name: '', id: dr.id);
    // Payment payment = await paymentServices.getPaymentById(dr.id);
    // bill.payment = payment;

    return bill;
  }

  addBill(Bill bill) async {
    try {
      print('helllo 1');
      Map<String, dynamic> mapdata = bill.tofire();
      DocumentReference dr = await billsRef.add(mapdata).then((value) {
        bill.materials.forEach((element) {
          print(element);
          // Map<String, dynamic> matdata = element;
          billsRef.doc(value.id).collection('Material').add(element);
        });
        return value;
      });
      // print('helllo 2');
      // print(bill.materials.length);
      // bill.materials.forEach((element) {
      //   print(element);
      //   // Map<String, dynamic> matdata = element;
      //   billsRef.doc(billsRef.id).collection('Material').add(element);
      // });

      // mapdata.addAll(serviceProvider.tofire());
      // print('our user is ' + UserNetwork.dr.id);
      // mapdata['user'] = UserNetwork.dr;
      // mapdata['categories'] = cat;
      print('helllo 1');

      print(dr.id);
      return dr;
      // then((value) {
      //   print('provider added');
      //   print("new user is " + value.id);
      //   return value;
      // branchServices.addBranch(serviceProvider.branches.first, value.id);
      // });
    } catch (e) {
      print("add bill error " + e);
    }
  }
}
