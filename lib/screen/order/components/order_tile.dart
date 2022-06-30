import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_manager/models/pharmacyUser.dart';
import 'package:hci_manager/screen/order/order.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/order.dart';

class OrderTile extends ConsumerWidget {
  const OrderTile(this.order, this.user);

  final Order order;
  final PharmacyUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var formatter = NumberFormat('#,###');
    return InkWell(
      onTap: () {
        ref.read(orderLoadProvider.notifier).state = order;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: ListTile(
              dense: true,
              visualDensity: const VisualDensity(vertical: 3),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(user.imgUrl.toString()),
              ),
              title: Text(
                user.name!,
                style: const TextStyle(color: Colors.blue, fontSize: 18),
              ),
              subtitle: Text(
                '${formatter.format(order.price)},000 VND - ${getCount()} items',
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Status: ${order.status}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    'Order Date: ${DateFormat('dd-MM-yyyy').format(order.date)}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  TextButton(
                      onPressed: () {
                        searchMap();
                      },
                      child: const Text('Click to view map')),
                ],
              ),
            ),
          ),
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

  void searchMap() async {
    final query =
        'https://www.google.com/maps/search/?api=1&query=${order.user.addr}';
    final Uri url = Uri.parse(query);
    await launchUrl(url);
  }
}
