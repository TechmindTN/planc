import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_services_provider/app/models/Payment.dart';

class Bill {
  String id;
  Payment payment;
  double service_fee;
  double workforce_fee;
  double study_fee;
  double discount;
  Timestamp date;
  String state;
  final double total_price;
  List<Map<String, dynamic>> materials;

  Bill(
      {this.id,
      this.payment,
      this.service_fee,
      this.workforce_fee,
      this.study_fee,
      this.discount,
      this.date,
      this.state,
      this.materials,
      this.total_price});

  Bill.fromFire(fire)
      : service_fee = fire['service_fee'].toDouble(),
        workforce_fee = fire['workforce_fee'].toDouble(),
        study_fee = fire['study_fee'].toDouble(),
        discount = fire['discount'].toDouble(),
        date = fire['date'],
        state = fire['state'],
        total_price = fire['total_price'].toDouble(),
        id = null;

  Map<String, dynamic> tofire() => {
        'service_fee': service_fee,
        'workforce_fee': workforce_fee,
        'study_fee': study_fee,
        'discount': discount,
        'date': date ?? Timestamp.now(),
        'state': state ?? "pending",
        'total_price':
            total_price 
            ?? workforce_fee + service_fee + study_fee - discount
            ,
        // 'materials': materials
      };

  printBill() {
    print(this.id);

    this.payment.printPayment();
    print(this.service_fee);
    print(this.workforce_fee);
    print(this.study_fee);
    print(this.discount);
    print(this.date);
    print(this.state);
    print(this.total_price);
    // print(materials!.length);
    Future.delayed(Duration(seconds: 2), () {
      materials.forEach((element) {
        element.forEach((key, value) {
          print(key + ' : ' + value.toString());
        });
      });
    });
  }
}
