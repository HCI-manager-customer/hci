import 'package:concentric_transition/page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hci_manager/components/side_menu.dart';
import 'package:hci_manager/addons/responsive_layout.dart';
import 'package:hci_manager/screen/drug/drug_view.dart';
import 'package:hci_manager/screen/prescription/prescription.dart';
import 'package:hci_manager/screen/transfer/transfer.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

import '../../controllers/drug_controller.dart';
import '../../controllers/order_controller.dart';
import '../../controllers/prescription_controller.dart';
import '../../provider/general_provider.dart';
import '../lockscreen/lockscreen.dart';
import '../order/order.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int duration = 500;
  @override
  void initState() {
    super.initState();
    OrderController orderController = Get.put(OrderController());
    PreScripController preScriptController = Get.put(PreScripController());
    DrugController drugController = Get.put(DrugController());

    Get.delete<OrderController>();
    Get.delete<PreScripController>();

    orderController = Get.put(OrderController());
    preScriptController = Get.put(PreScripController());
  }

  @override
  Widget build(BuildContext context) {
    final sessionConfig = SessionConfig(
        invalidateSessionForAppLostFocus: const Duration(seconds: 15),
        invalidateSessionForUserInactiviity: const Duration(minutes: 5));
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        Navigator.push(context, ConcentricPageRoute(builder: (ctx) {
          return const LockScreen();
        }));
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        Navigator.push(context, ConcentricPageRoute(builder: (ctx) {
          return const LockScreen();
        }));
      }
    });
    return Responsive(
      MobileView(AnimatedSwitcher(
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        duration: Duration(milliseconds: duration),
        child: getScreen(),
      )),
      TabletView(AnimatedSwitcher(
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        duration: Duration(milliseconds: duration),
        child: getScreen(),
      )),
      SessionTimeoutManager(
        sessionConfig: sessionConfig,
        child: WebView(AnimatedSwitcher(
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          duration: Duration(milliseconds: duration),
          child: getScreen(),
        )),
      ),
    );
  }

  Widget getScreen() {
    final currentScreen = ref.watch(ScreenProvider);
    switch (currentScreen) {
      case MenuItems.drug:
        return const DrugViewScreen(key: Key('DrugView'));
      case MenuItems.orders:
        return const OrderViewScreen(key: Key('OrderView'));
      case MenuItems.prescrip:
        return const PrescriptionViewScreen(key: Key('PresView'));
      case MenuItems.transfer:
        return const TransferScreen(key: Key('Transfer'));
      default:
        return const DrugViewScreen(key: Key('DrugView'));
    }
  }
}

class WebView extends StatelessWidget {
  const WebView(this.child);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 2, child: SideMenu(0)),
        Expanded(flex: 8, child: child),
      ],
    );
  }
}

class TabletView extends StatelessWidget {
  const TabletView(this.child);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: child),
      ],
    );
  }
}

class MobileView extends StatelessWidget {
  const MobileView(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: child),
      ],
    );
  }
}
