import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hci_manager/screen/prescription/components/pre_panel.dart';
import 'package:lottie/lottie.dart';

import '../../../components/popup.dart';
import '../../../controllers/global.dart';
import '../prescription.dart';
import 'chat_body.dart';

class DetailPanel extends ConsumerStatefulWidget {
  const DetailPanel({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailPanelState();
}

class _DetailPanelState extends ConsumerState<ConsumerStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final preS = ref.watch(preLoadProvider);
    // if (preS.note.last.msg.startsWith('*/*')) {
    //   isEnded = true;
    // }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Patient Name: ${preS.name}',
          style: const TextStyle(color: Colors.blue, fontSize: 25),
        ),
        Text(
          'Address: ${preS.addr}',
          style: const TextStyle(color: Colors.blue, fontSize: 25),
        ),
        Text(
          'Status: ${preS.status}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.blue, fontSize: 20),
        ),
        GestureDetector(
          onTap: () => popUpImage(preS.imgurl, ''),
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: preS.imgurl,
            placeholder: (_, url) => Lottie.asset(
              'assets/json-gif/image-loading.json',
              height: 100,
              alignment: Alignment.center,
              fit: BoxFit.fill,
            ),
            errorWidget: (_, url, er) => Lottie.asset(
              'assets/json-gif/image-loading.json',
              alignment: Alignment.center,
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 70,
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Finish this prescription?',
                    content: const Text(
                        'You want to end support for this prescription?'),
                    cancel: TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Cancel'),
                    ),
                    confirm: ElevatedButton(
                      onPressed: () {
                        markAsFinish(preS.id);
                        Get.back();
                      },
                      child: const Text('Confirm, End this support'),
                    ),
                  );
                },
                child: const Text(
                  'Mark as Finished',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 70,
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  'Chat',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  ref.read(preControllProvider.notifier).state = ChatBody();
                },
              ),
            ),
            SizedBox(
              height: 70,
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  'Make Order',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  const PrescriptPanel().makeOrder(context, preS);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
