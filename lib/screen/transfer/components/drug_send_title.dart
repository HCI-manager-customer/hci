import 'dart:math';

import 'package:flutter/material.dart';

import '../../../models/drug.dart';

class DrugSendTile extends StatelessWidget {
  const DrugSendTile(this.drug);

  final Drug drug;

  @override
  Widget build(BuildContext context) {
    int ran = 1 + (Random().nextInt(10 - 1));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: ListTile(
            hoverColor: Colors.red,
            leading: Image.network(drug.imgUrl, width: 100),
            title: Text(
              drug.title,
              style: const TextStyle(color: Colors.black),
            ),
            subtitle: Row(
              children: [
                Text(
                  drug.price.toStringAsFixed(3),
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  '$ran count',
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  'Container: ${drug.container}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 50,
                    height: 30,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          //Outline border type for TextFeild
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}