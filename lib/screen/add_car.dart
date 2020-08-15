import 'package:flutter/material.dart';
import 'package:fb_demo/utils/app_navigator.dart';
import 'package:fb_demo/services/car_db.dart';
import 'package:fb_demo/models/car.dart';

class AddCar extends StatelessWidget {
  final Car oldCar;

  AddCar({this.oldCar});

  //
  final _formKey = GlobalKey<FormState>();

  //
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _millegeController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  //
  @override
  Widget build(BuildContext context) {
    //set old car data for modification
    if (oldCar != null) {
      _modelController.text = oldCar.model;
      _companyController.text = oldCar.company;
      _priceController.text = oldCar.price.toString();
      _millegeController.text = oldCar.millege.toString();
      _descController.text = oldCar.descreption;
    }

    return Scaffold(
      //
      appBar: AppBar(
        title: oldCar == null ? Text('Add Car') : Text('Edit Car'),
        actions: <Widget>[
          if (oldCar != null)
            IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                //
                deleteCarData(context);
              },
            ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              addCarData(context);
            },
          ),
        ],
      ),

      //
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            //car model
            TextFormField(
              controller: _modelController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'Car Model',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Car Model is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            //car company
            TextFormField(
              controller: _companyController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'Company',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Company is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            //car price
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Price',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Price is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            //car millete
            TextFormField(
              controller: _millegeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Millege',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Millege is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            //car descreption
            TextFormField(
              minLines: 8,
              maxLines: 8,
              controller: _descController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Descreption',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Descreption is required';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  void addCarData(BuildContext context) {
    if (_formKey.currentState.validate()) {
      String model = _modelController.text;
      String company = _companyController.text;
      int price = int.parse(_priceController.text);
      double millege = double.parse(_millegeController.text);
      String desc = _descController.text;

      Car car = Car(
        model: model,
        company: company,
        price: price,
        millege: millege,
        descreption: desc,
      );

      CarDB carDB = CarDB();

      if (oldCar == null) {
        // add new car to database
        carDB.addCar(car);
      } else {
        // edit car data to database
        car.id = oldCar.id;
        carDB.updateCar(car);
      }

      AppNavigator.pop(context);
    }
  }

  void deleteCarData(BuildContext context) {
    CarDB carDB = CarDB();
    carDB.deleteCar(oldCar);
    AppNavigator.pop(context);
  }
}
