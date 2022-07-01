import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    bool isEnded = false;
    if (preS.note.last.msg.startsWith('*/*')) {
      isEnded = true;
    }
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
        CachedNetworkImage(
          imageUrl: preS.Imgurl,
          height: 600,
          width: 500,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 70,
              width: 150,
              child: RaisedButton(
                color: Colors.cyan,
                shape: const StadiumBorder(),
                onPressed: () {},
                child: const Text(
                  'Mark as Finished',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 70,
              width: 150,
              child: RaisedButton(
                color: Colors.green,
                shape: const StadiumBorder(),
                child: const Text(
                  'Chat',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  ref.read(preControllProvider.notifier).state =
                      ChatBody(isEnded);
                },
              ),
            ),
            SizedBox(
              height: 70,
              width: 150,
              child: RaisedButton(
                color: Colors.blue,
                shape: const StadiumBorder(),
                child: const Text(
                  'Make Order',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
