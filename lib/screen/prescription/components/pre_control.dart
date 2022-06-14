// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class PrescriptionControll extends StatelessWidget {
  const PrescriptionControll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'Cao Chanh Duc',
            style: TextStyle(color: Colors.blue, fontSize: 25),
          ),
          const Text(
            'Address: 123 ABC District ABC, TP.HCM',
            style: TextStyle(color: Colors.blue, fontSize: 25),
          ),
          const Text(
            'Date: May 27, 2021',
            style: TextStyle(color: Colors.blue, fontSize: 20),
          ),
          Image.network(
            'https://4.bp.blogspot.com/-_kBJT0h6Spg/UdbTldpNbdI/AAAAAAAAAWA/18wS5P6bDY4/s1600/vio-2.jpg',
            height: 300,
            width: 300,
            fit: BoxFit.fill,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 70,
                width: 150,
                child: RaisedButton(
                  color: Colors.red,
                  shape: const StadiumBorder(),
                  onPressed: () {},
                  child: const Text(
                    'Accpect Order',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
                width: 150,
                child: RaisedButton(
                  color: Colors.green,
                  shape: const StadiumBorder(),
                  child: const Text(
                    'Call',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 70,
                width: 150,
                child: RaisedButton(
                  color: Colors.blue,
                  shape: const StadiumBorder(),
                  child: const Text(
                    'Parvel Shipped',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
