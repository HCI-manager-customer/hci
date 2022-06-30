import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/cart.dart';

class OrderDurgTile extends StatelessWidget {
  OrderDurgTile(this.cart);

  final Cart cart;
  var formatter = NumberFormat('#,###');

  var color = Colors.white;
  //return random number from range
  int ran = 1 + (Random().nextInt(10 - 1));
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: color,
            border: Border.all(),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: ListTile(
            hoverColor: Colors.red,
            leading: Image.network(cart.drug.imgUrl, width: 100),
            title: Text(
              cart.drug.title,
              style: const TextStyle(color: Colors.black),
            ),
            subtitle: Row(
              children: [
                Text(
                  '${formatter.format(cart.drug.price)},000 VND',
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  '$ran count',
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  'Container: ${cart.drug.container}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
