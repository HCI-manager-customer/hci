import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:hci_manager/controllers/drug_controller.dart';

import '../../../addons/responsive_layout.dart';
import '../../../models/drug.dart';
import 'add_drug.dart';
import 'drug_tile.dart';

final drugLoadProvider = StateProvider(((ref) => dummyDrug));

class DrugPanel extends StatelessWidget {
  const DrugPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GetX<DrugController>(
          init: DrugController(),
          builder: (drugs) {
            if (drugs.drugs.isEmpty) {
              return const Center(
                child: Text('Empty Drug'),
              );
            } else {
              return Consumer(builder: (ctx, ref, _) {
                bool isDrawerOpen = ref.watch(isOpenAddDrugProvider);
                int crossAxi = isDrawerOpen
                    ? Responsive.isMobile(context)
                        ? 1
                        : 2
                    : 3;
                double childAspect = isDrawerOpen ? 4 : 4;
                int count = 0;
                return SizedBox(
                  //height: MediaQuery.of(context).size.height * 0.8,
                  child: GridView(
                    controller: ScrollController(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxi,
                      childAspectRatio: childAspect,
                    ),
                    children: drugs.drugs.map((e) {
                      return AnimationConfiguration.staggeredList(
                        position: count++,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: DrugTile(e),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              });
            }
          }),
    );
  }
}
