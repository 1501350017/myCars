import 'package:fb_demo/models/car.dart';
import 'package:fb_demo/screen/add_car.dart';
import 'package:fb_demo/utils/app_navigator.dart';
import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final Car car;

  CarCard({this.car});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //
      onTap: () {
        //
        AppNavigator.push(
          context,
          AddCar(
            oldCar: car,
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'images/car.png',
                color: Colors.blue,
               // width: 150,
                height: 100,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      car.model,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('From ${car.company}'),
                    SizedBox(height: 8),
                    Text(car.descreption ?? 'No descreption available'),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '\u20b9${car.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text('${car.millege} Km/ltr')
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
