import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../components/side_menu.dart';
import '../../addons/responsive_layout.dart';
import '../drug/drug_view.dart';
import '../order/order.dart';
import 'components/pre_control.dart';
import 'components/pre_panel.dart';

class PrescriptionViewScreen extends StatefulWidget {
  const PrescriptionViewScreen({Key? key}) : super(key: key);

  @override
  State<PrescriptionViewScreen> createState() => _PrescriptionViewScreenState();
}

class _PrescriptionViewScreenState extends State<PrescriptionViewScreen> {
  final key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double sizePhone = size * 0.7;
    double sizeTablet = size * 0.3;
    return NeumorphicApp(
      home: Scaffold(
        drawer: Responsive.isDesktop(context)
            ? null
            : SideMenu(Responsive.isTablet(context) ? sizeTablet : sizePhone),
        key: key,
        backgroundColor: Colors.white,
        appBar: NeumorphicAppBar(
          title: const Text(
            'Prescription',
            style: TextStyle(color: Colors.grey),
          ),
          centerTitle: true,
          leading: Responsive.isTablet(context)
              ? NeumorphicButton(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(20)),
                      color: Colors.white38),
                  onPressed: () => key.currentState!.openDrawer(),
                  child: Center(
                    child: NeumorphicIcon(
                      Icons.menu,
                      size: 30,
                    ),
                  ),
                )
              : null,
        ),
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      SortDateBox(),
                      SortBox(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SearchBox(
                      key: UniqueKey(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Expanded(child: PrescriptPanel()),
                  SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: const Text(
                            '1',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const Text(
                          '2',
                          style: TextStyle(color: Colors.black),
                        ),
                        const Text(
                          '3',
                          style: TextStyle(color: Colors.black),
                        ),
                        const Text(
                          '4',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
            const Expanded(
              flex: 2,
              child: PrescriptionControll(),
            ),
          ],
        ),
      ),
    );
  }
}
