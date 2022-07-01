// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../models/drug.dart';
import '../../order/order.dart';
import 'drug_rev_tile.dart';

class OtherPanel extends StatelessWidget {
  const OtherPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance.collection('drugs');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Transfer Destination',
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: SelectPharmacy(),
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: SearchBox(
            key: UniqueKey(),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              int count = 0;
              return SizedBox(
                width: 500,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.sublist(5, 8).map((e) {
                    return AnimationConfiguration.staggeredList(
                      position: count++,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: DrugRevTile(
                              Drug.fromMap(e.data() as Map<String, dynamic>)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }
          },
          stream: db.snapshots(),
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
                  'Reset Selection',
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
                  'Parcel Ready',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
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
      mainAxisAlignment: MainAxisAlignment.center,
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
