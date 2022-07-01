import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../controllers/global.dart';
import '../../../models/drug.dart';

class MakeOrderDrugTile extends StatelessWidget {
  const MakeOrderDrugTile(this.id, this.drug);

  final Drug drug;
  final String id;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###');
    return ListTile(
      leading: Image.network(
        drug.imgUrl,
        width: 120,
      ),
      title: Text(
        drug.fullName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.kanit(color: Colors.black),
      ),
      subtitle: Text(
        '${formatter.format(drug.price)},000 VND',
        style: GoogleFonts.kanit(color: Colors.grey),
      ),
      trailing: TextButton(
        onPressed: () {
          addToCart(id, drug.id);
        },
        child: const Text('+1 >'),
      ),
    );
  }
}
