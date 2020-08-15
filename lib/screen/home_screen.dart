import 'package:fb_demo/screen/add_car.dart';
import 'package:fb_demo/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:fb_demo/models/car.dart';
import 'package:fb_demo/services/car_db.dart';
import 'package:fb_demo/utils/app_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  final CarDB carDB = CarDB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('My Cars'),
      ),

      //
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //
          AppNavigator.push(context, AddCar());
        },
      ),

      //
      body: StreamBuilder(
        stream: carDB.selectAllCars(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data.documents.length == 0) {
            return Center(
              child: Text('No Cars to show'),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              Car car =
                  Car.fromDocumentSnapshot(snapshot.data.documents[index]);

              return CarCard(car: car);
            },
          );
        },
      ),
    );
  }
}
