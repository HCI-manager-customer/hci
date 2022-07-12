import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hci_manager/components/search.dart';
import 'package:hci_manager/constant/constant.dart';
import 'package:hci_manager/controllers/drug_controller.dart';
import 'package:hci_manager/models/prescription.dart';
import 'package:intl/intl.dart';

import '../../../controllers/global.dart';
import '../../../models/drug.dart';
import '../../drug/drug_view.dart';
import 'drug_tile_add.dart';

class MakeOrder extends ConsumerWidget {
  const MakeOrder(this.preS);

  final Prescription preS;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var formatter = NumberFormat('#,###');

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        height: 800,
        width: 1200,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    'Select Products',
                    style: GoogleFonts.kanit(color: Colors.green, fontSize: 30),
                  ),
                  const SearchBox(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        SortDateBox(),
                        SortBox(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<Drug>>(
                        future: getDrug(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView(
                            children: snapshot.data!
                                .map(
                                  (e) => MakeOrderDrugTile(preS.id, e),
                                )
                                .toList(),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('prescription')
                    .doc(preS.id)
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final data = Prescription.fromMap(
                      snapshot.data!.data() as Map<String, dynamic>);
                  final list = data.medicines;
                  if (list.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${preS.name}\'s Cart',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.kanit(
                              color: Colors.green, fontSize: 30),
                        ),
                        const Center(
                          child: Text('Cart Empty'),
                        ),
                        const SizedBox()
                      ],
                    );
                  } else {
                    int price = drugController.getTotalPrice(list);
                    return Column(
                      children: [
                        Text(
                          '${preS.name}\'s Cart',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.kanit(
                              color: Colors.green, fontSize: 30),
                        ),
                        Expanded(
                          child: ListView(
                            children: list.map((e) {
                              final med = drugController.drugs
                                  .firstWhere((element) => element.id == e);
                              return ListTile(
                                leading: Image.network(
                                  med.imgUrl,
                                  width: 120,
                                ),
                                title: Text(
                                  med.fullName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.kanit(),
                                ),
                                subtitle: Text(
                                  '${formatter.format(med.price)},000 VND',
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    removeFromCart(preS.id, med.id);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        if (price != 0)
                          SizedBox(
                            height: 50,
                            child: Text(
                              'Total ${formatter.format(price)},000 VND',
                              style: GoogleFonts.kanit(
                                color: Colors.blue,
                                fontSize: 25,
                              ),
                            ),
                          ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Drug>> getDrug() async {
    final DrugController drugsCtl = Get.find();
    return drugsCtl.drugs;
  }
}
