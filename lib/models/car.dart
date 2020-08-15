import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  String id;      // documnetId stored as unique data on firestore
  String model;
  String company;
  int price;
  double millege;
  String descreption;

  Car({
    this.model,
    this.company,
    this.price,
    this.millege,
    this.descreption,
  });

  Car.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.id = documentSnapshot.documentID;
    this.model = documentSnapshot['model'];
    this.company = documentSnapshot['company'];
    this.price = documentSnapshot['price'];
    this.millege = documentSnapshot['millege'];
    this.descreption = documentSnapshot['descreption'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['model'] = this.model;
    map['company'] = this.company;
    map['price'] = this.price;
    map['millege'] = this.millege;
    map['descreption'] = this.descreption;

    return map;
  }
}
