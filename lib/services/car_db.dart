import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_demo/models/car.dart';

class CarDB {
  //
  static CollectionReference cars = Firestore.instance.collection('cars');

  //insert
  String addCar(Car car) {
    cars
        .add(car.toMap())
        .then((result) => 'Car added succesfully')
        .catchError((error) => 'Error while adding car $error');

    return '';
  }

  //delete
  String deleteCar(Car car) {
    cars
        .document(car.id)
        .delete()
        .then((result) => 'Car deleted succesfully')
        .catchError((error) => 'Error while deleting car $error');

    return '';
  }

  //update
  String updateCar(Car car) {
    cars
        .document(car.id)
        .updateData(car.toMap())
        .then((result) => 'Car updated succesfully')
        .catchError((error) => 'Error while updating car $error');

    return '';
  }

  //select all
  Stream<QuerySnapshot> selectAllCars() {
    return cars
        .orderBy(
          'millege',
          descending: true
        )
        .snapshots();
  }
}
