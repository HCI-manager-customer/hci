import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../order/order.dart';

class OtherPanel extends StatelessWidget {
  const OtherPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance.collection('drugs');
    return Container(
      child: Column(
        children: const [
          SelectPharmacy(),
          SearchBox(),
        ],
      ),
    );
  }
}

class SelectPharmacy extends StatefulWidget {
  const SelectPharmacy({Key? key}) : super(key: key);

  @override
  State<SelectPharmacy> createState() => _SelectPharmacyState();
}

class _SelectPharmacyState extends State<SelectPharmacy> {
  String phar = 'Pharmacy....';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Select Pharmacy:  ',
          style: TextStyle(color: Colors.black),
        ),
        Container(
          width: 300,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(25),
              border: Border.all()),
          child: DropdownButton(
            dropdownColor: Colors.white,
            isExpanded: true,
            style: const TextStyle(color: Colors.black),
            hint: Text(
              phar,
              style: const TextStyle(color: Colors.black),
            ),
            onChanged: (v) {
              setState(() {
                phar = v.toString();
              });
            },
            items: const [
              DropdownMenuItem(
                value: 'Pharmacy District 9',
                child: Text('Pharmacy District 9'),
              ),
              DropdownMenuItem(
                value: 'Pharmacy District 2',
                child: Text('Pharmacy District 2'),
              ),
              DropdownMenuItem(
                value: 'Pharmacy District Thu Duc',
                child: Text('Pharmacy District Thu Duc'),
              ),
              DropdownMenuItem(
                value: 'Pharmacy District Go Vap',
                child: Text('Pharmacy District Go Vap'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
