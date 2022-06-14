import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../addons/responsive_layout.dart';
import '../../components/side_menu.dart';
import 'components/my_panel.dart';
import 'components/other_panel.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
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
            'Transfer Drug',
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
          children: const [
            Expanded(
              flex: 1,
              // child: Column(
              //   children: const [
              //     SizedBox(height: 20),
              //     // const Expanded(child: OrderPanel()),
              //     // SizedBox(
              //     //   width: 100,
              //     //   child: Row(
              //     //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     //     children: [
              //     //       Container(
              //     //         decoration: BoxDecoration(
              //     //           border: Border.all(),
              //     //         ),
              //     //         child: const Text(
              //     //           '1',
              //     //           style: TextStyle(color: Colors.black),
              //     //         ),
              //     //       ),
              //     //       const Text(
              //     //         '2',
              //     //         style: TextStyle(color: Colors.black),
              //     //       ),
              //     //       const Text(
              //     //         '3',
              //     //         style: TextStyle(color: Colors.black),
              //     //       ),
              //     //       const Text(
              //     //         '4',
              //     //         style: TextStyle(color: Colors.black),
              //     //       ),
              //     //     ],
              //     //   ),
              //     // ),
              //     SizedBox(
              //       height: 60,
              //     )
              //   ],
              // ),
              child: Center(
                child: MyPanel(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: OtherPanel(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
