import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/side_menu.dart';
import '../../responsive_layout.dart';
import 'add_drug.dart';
import 'drug_panel.dart';

final DrawerKeyProvider = StateProvider((_) => GlobalKey<ScaffoldState>());

class DrugViewScreen extends ConsumerStatefulWidget {
  const DrugViewScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DrugViewScreenState();
}

class _DrugViewScreenState extends ConsumerState<DrugViewScreen> {
  @override
  Widget build(BuildContext context) {
    final drawerKey = ref.watch(DrawerKeyProvider);
    return NeumorphicApp(
      color: Colors.white,
      home: Scaffold(
        drawer: Responsive.isDesktop(context)
            ? null
            : SideMenu(MediaQuery.of(context).size.width * 0.3),
        key: drawerKey,
        backgroundColor: Colors.white,
        endDrawer: Responsive.isDesktop(context) ? null : const AddDrug(),
        appBar: NeumorphicAppBar(
          title: const Text(
            'Drug',
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            !Responsive.isDesktop(context)
                ? NeumorphicButton(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(20),
                      ),
                      color: Colors.white38,
                    ),
                    pressed: true,
                    onPressed: () => drawerKey.currentState!.openEndDrawer(),
                    child: Center(
                      child: NeumorphicIcon(
                        Icons.add_box_rounded,
                        size: 30,
                      ),
                    ),
                  )
                : Container(),
          ],
          centerTitle: true,
          leading: Responsive.isTablet(context)
              ? NeumorphicButton(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(20),
                    ),
                    color: Colors.white38,
                  ),
                  pressed: true,
                  onPressed: () => drawerKey.currentState!.openDrawer(),
                  child: Center(
                    child: NeumorphicIcon(
                      Icons.menu,
                      size: 30,
                    ),
                  ),
                )
              : null,
        ),
        body: LayoutBuilder(
          builder: (context, dimen) {
            if (Responsive.isDesktop(context)) {
              return Row(
                children: const [
                  Expanded(
                    flex: 3,
                    child: DrugPanel(),
                  ),
                  Expanded(
                    flex: 0,
                    child: AddDrug(),
                  ),
                ],
              );
            }
            if (Responsive.isTablet(context)) {
              return const Center(
                child: Text('Drug'),
              );
            }
            if (Responsive.isMobile(context)) {}
            return Container();
          },
        ),
      ),
    );
  }
}
