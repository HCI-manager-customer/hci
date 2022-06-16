import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hci_manager/screen/order/order.dart';

import '../../../models/drug.dart';
import 'drug_send_title.dart';

class MyPanel extends StatelessWidget {
  const MyPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance.collection('drugs');
    return Container(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Your Current Stock',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
          ),
          SearchBox(key: UniqueKey()),
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
                    children: snapshot.data!.docs.sublist(0, 5).map((e) {
                      return AnimationConfiguration.staggeredList(
                        position: count++,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: DrugSendTile(
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
        ],
      ),
    );
  }
}
