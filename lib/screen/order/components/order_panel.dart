import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:hci_manager/controllers/order_controller.dart';
import 'package:hci_manager/models/pharmacyUser.dart';

import '../../../controllers/global.dart';
import 'order_tile.dart';

class OrderPanel extends StatelessWidget {
  const OrderPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GetX<OrderController>(
          init: OrderController(),
          builder: (orders) {
            if (orders.orders.isEmpty) {
              return const Center(
                child: Text('Empty Order'),
              );
            } else {
              return Consumer(builder: (ctx, ref, _) {
                // bool isDrawerOpen = ref.watch(isOpenAddDrugProvider);
                // int crossAxi = isDrawerOpen
                //     ? Responsive.isMobile(context)
                //         ? 1
                //         : 2
                //     : 3;
                // double childAspect = isDrawerOpen ? 4 : 4;
                int crossAxi = 2;
                double childAspect = 4;
                int count = 0;
                return SizedBox(
                  child: GridView(
                    controller: ScrollController(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxi,
                      childAspectRatio: childAspect,
                    ),
                    children: orders.orders.map((e) {
                      return AnimationConfiguration.staggeredList(
                        position: count++,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: FutureBuilder<PharmacyUser>(
                                future: getUserByMail(e.user.mail.toString()),
                                builder: (_, ff) {
                                  if (ff.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                                  } else {
                                    return OrderTile(e, ff.data!);
                                  }
                                }),
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
