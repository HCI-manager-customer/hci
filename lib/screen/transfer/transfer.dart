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
          leading: Responsive.isDesktop(context)
              ? null
              : NeumorphicButton(
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
                ),
        ),
        body: LayoutBuilder(builder: ((context, constraints) {
          if (Responsive.isDesktop(context)) {
            return Row(
              children: const [
                Expanded(
                  flex: 1,
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
            );
          } else if (Responsive.isMobile(context)) {
            return const Center(
              child: Text(
                'No Mobile view yet',
                style: TextStyle(color: Colors.grey),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'No Tablet view yet',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
        })),
      ),
    );
  }
}
