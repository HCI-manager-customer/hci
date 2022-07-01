// ignore_for_file: deprecated_member_use

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hci_manager/screen/prescription/components/pre_detail.dart';

import '../prescription.dart';

class PrescriptionControll extends ConsumerStatefulWidget {
  const PrescriptionControll({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PrescriptionControllState();
}

class _PrescriptionControllState extends ConsumerState<ConsumerStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final preS = ref.watch(preLoadProvider);
    final panel = ref.watch(preControllProvider);
    if (preS.name.length < 2) {
      return Center(
        child: Text(
          'Select an prescription Bill',
          style: GoogleFonts.kanit(color: Colors.grey, fontSize: 30),
        ),
      );
    }
    return Neumorphic(
      style: const NeumorphicStyle(
        depth: 5,
        color: Colors.white,
        lightSource: LightSource.right,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: Column(
          children: [
            IconButton(
                onPressed: () {
                  if (panel != const DetailPanel()) {
                    ref.read(preControllProvider.notifier).state =
                        const DetailPanel();
                  }
                },
                icon: const Icon(Icons.arrow_back)),
            Expanded(child: panel),
          ],
        ),
      ),
    );
  }
}
