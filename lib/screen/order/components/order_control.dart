// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_manager/screen/order/order.dart';
import 'package:intl/intl.dart';

import '../../../models/drug.dart';
import 'drug_order_tile.dart';

class OrderControl extends ConsumerWidget {
  const OrderControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = FirebaseFirestore.instance.collection('drugs');

    Future<List<Drug>> getListDrug() async {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('drugs').limit(10).get();
      return snapshot.docs.map((e) {
        return Drug.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    }

    final order = ref.watch(orderLoadProvider);

    if (order.listCart.isEmpty) {
      return Neumorphic(
        style: const NeumorphicStyle(
          depth: 5,
          color: Colors.white,
          lightSource: LightSource.right,
        ),
        child: const Center(
          child: Text(
            'Select an order',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    int getCount() {
      int count = 0;
      for (var item in order.listCart) {
        count += item.quantity;
      }
      return count;
    }

    var formatter = NumberFormat('#,###');

    return Neumorphic(
      style: const NeumorphicStyle(
        depth: 5,
        color: Colors.white,
        lightSource: LightSource.right,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            order.user.name!,
            style: const TextStyle(color: Colors.blue, fontSize: 25),
          ),
          Text(
            'Address: ${order.user.addr!}',
            style: const TextStyle(color: Colors.blue, fontSize: 25),
          ),
          Text(
            'Date: ${DateFormat('dd-MM-yyyy').format(order.date)}',
            style: const TextStyle(color: Colors.blue, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Price: ${formatter.format(order.price)},000 VND',
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                '${getCount()} Items',
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                'Status: ${order.status}',
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade300),
                  borderRadius: BorderRadius.circular(25)),
              height: 500,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: order.listCart.length,
                itemBuilder: (cx, i) => OrderDurgTile(order.listCart[i]),
              ),
            ),
          ),

          // StreamBuilder<QuerySnapshot>(
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState != ConnectionState.active) {
          //       return const Center(
          //         child: CircularProgressIndicator.adaptive(),
          //       );
          //     } else {
          //       int count = 0;
          //       return ListView(
          //         shrinkWrap: true,
          //         physics: const NeverScrollableScrollPhysics(),
          //         children: snapshot.data!.docs.sublist(0, 5).map((e) {
          //           return AnimationConfiguration.staggeredList(
          //             position: count++,
          //             duration: const Duration(milliseconds: 500),
          //             child: SlideAnimation(
          //               verticalOffset: 50.0,
          //               child: FadeInAnimation(
          //                 child: OrderDurgTile(order.listCart),
          //               ),
          //             ),
          //           );
          //         }).toList(),
          //       );
          //     }
          //   },
          //   stream: db.snapshots(),
          // ),
          //3 ElevatedButton in a row with 3 different colors
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
                    'Parcel Ready',
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
                    'Parcel Shipped',
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
