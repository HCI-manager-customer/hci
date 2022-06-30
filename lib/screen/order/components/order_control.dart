// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_manager/controllers/order_controller.dart';
import 'package:hci_manager/screen/order/order.dart';
import 'package:intl/intl.dart';

import 'drug_order_tile.dart';

class OrderControl extends ConsumerStatefulWidget {
  const OrderControl();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderControlState();
}

class _OrderControlState extends ConsumerState<ConsumerStatefulWidget> {
  bool isCancelled = false;

  @override
  Widget build(BuildContext context) {
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

    var stream = FirebaseFirestore.instance
        .collection('orders')
        .doc(order.id)
        .snapshots();

    String doneOrder(st) {
      String done = 'Date: ${DateFormat('dd-MM-yyyy').format(order.date)}';
      if (st == "Done") {
        done += '(Order Completed)';
      }
      return done;
    }

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final data = snapshot.data!.data();
        if (data!['status'] == 'Cancelled') {
          isCancelled = true;
        }
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
                doneOrder(data['status']),
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
                    'Status: ${data['status']}',
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
              //3 ElevatedButton in a row with 3 different colors
              isCancelled
                  ? const Center(
                      child: Text(
                        'User Cancelled this Order!!',
                        style: TextStyle(color: Colors.red, fontSize: 25),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 70,
                          width: 150,
                          child: RaisedButton(
                            color: Colors.red,
                            shape: const StadiumBorder(),
                            onPressed: () {
                              OrderService().orderStatus('NewOrder', order.id);
                            },
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
                              'Parcel Shipped',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              OrderService().orderStatus('Shipping', order.id);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          width: 150,
                          child: RaisedButton(
                            color: Colors.blue,
                            shape: const StadiumBorder(),
                            child: const Text(
                              'Order Complete',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              OrderService().orderStatus('Done', order.id);
                            },
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}
