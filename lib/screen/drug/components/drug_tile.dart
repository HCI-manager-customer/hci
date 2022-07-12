import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_manager/addons/responsive_layout.dart';
import 'package:hci_manager/screen/drug/drug_view.dart';

import '../../../models/drug.dart';
import 'drug_panel.dart';

class DrugTile extends ConsumerStatefulWidget {
  const DrugTile(this.drug);

  final Drug drug;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DrugTileState();
}

class _DrugTileState extends ConsumerState<DrugTile> {
  var color = Colors.white;
  int ran = 0 + (Random().nextInt(30 - 0));
  @override
  Widget build(BuildContext context) {
    return goodWid(context);
  }

  InkWell goodWid(BuildContext context) {
    return InkWell(
      onTap: () {
        if (Responsive.isDesktop(context)) {
          ref.read(drugLoadProvider.notifier).state = widget.drug;
        } else {
          ref
              .read(DrawerKeyProvider.notifier)
              .state
              .currentState!
              .openEndDrawer();
          ref.read(drugLoadProvider.notifier).state = widget.drug;
        }
      },
      onHover: (v) {
        setState(() {
          color = v ? Colors.greenAccent.shade100 : Colors.white;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: color,
              border: Border.all(),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: ListTile(
              hoverColor: Colors.red,
              leading: Image.network(widget.drug.imgUrl,
                  width: Responsive.isMobile(context) ? 70 : 100),
              title: Text(
                widget.drug.title,
                style: const TextStyle(color: Colors.black),
              ),
              subtitle: Row(
                children: [
                  Text(
                    '${widget.drug.price.toStringAsFixed(3)} VND',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  Text(
                    '$ran in stock',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  Text(
                    'Con: ${widget.drug.container}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
