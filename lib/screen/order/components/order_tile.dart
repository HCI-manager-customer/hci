import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_manager/models/pharmacyUser.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/order.dart';
import '../order.dart';

class OrderTile extends StatefulWidget {
  const OrderTile(this.order, this.user);

  final Order order;
  final PharmacyUser user;

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  var color = Colors.white;
  var formatter = NumberFormat('#,###');

  Color doneColor() {
    if (widget.order.status == 'Done') {
      return Colors.green;
    } else if (widget.order.status == 'Shipping') {
      return Colors.orange.shade300;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return InkWell(
        onTap: () {
          ref.read(orderLoadProvider.notifier).state = widget.order;
        },
        onHover: (v) {
          setState(() {
            color = v ? Colors.greenAccent.shade100 : Colors.white;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(20),
              color: color,
            ),
            child: Center(
              child: ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: 3),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(widget.user.imgUrl.toString()),
                ),
                title: Text(
                  widget.user.name!,
                  style: const TextStyle(color: Colors.blue, fontSize: 18),
                ),
                subtitle: Text(
                  '${formatter.format(widget.order.price)},000 VND - ${getCount()} items',
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Status: ${widget.order.status}',
                      style: TextStyle(color: doneColor()),
                    ),
                    Text(
                      'Order Date: ${DateFormat('dd-MM-yyyy').format(widget.order.date)}',
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
    });
  }

  int getCount() {
    int count = 0;
    for (var item in widget.order.listCart) {
      count += item.quantity;
    }
    return count;
  }

  void searchMap() async {
    final query =
        'https://www.google.com/maps/search/?api=1&query=${widget.order.user.addr}';
    final Uri url = Uri.parse(query);
    await launchUrl(url);
  }
}
