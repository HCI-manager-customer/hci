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
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: SizedBox(
            width: 500,
            child: ListTile(
              hoverColor: Colors.red,
              leading: Image.network(drug.imgUrl, width: 100, height: 130),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SizedBox(
                  width: 200,
                  child: Text(
                    drug.fullName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              subtitle: SizedBox(
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      drug.price.toStringAsFixed(3),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Spacer(),
                    Text(
                      '$ran in stock',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Spacer(),
                    Text(
                      'Con: ${drug.container}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              trailing: SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 100,
                      height: 30,
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
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
      ),
    );
  }
}
