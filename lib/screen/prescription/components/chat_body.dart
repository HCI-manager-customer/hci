import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/global.dart';
import '../prescription.dart';
import 'dialog_chat.dart';

class ChatBody extends StatelessWidget {
  ChatBody();
  var textCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final preS = ref.watch(preLoadProvider);
      final bool isSupport = preS.status != 'FINISH';
      return Column(
        children: [
          Expanded(child: DialogChat(preS.id)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(),
                color: Colors.white38,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.attach_file,
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.start,
                      enabled: isSupport,
                      controller: textCtl,
                      style: GoogleFonts.kanit(color: Colors.black),
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(top: 10),
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: isSupport
                            ? 'Type your message here'
                            : 'Support for this prescription has ended',
                      ),
                      maxLength: 250,
                      maxLines: null,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue, size: 30),
                    onPressed: () {
                      if (!isSupport) {
                        Get.snackbar('You can not send message',
                            'This Presciption support has ended',
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      } else if (textCtl.text.trim().isEmpty) {
                        Get.snackbar('Type Something',
                            'You need to type something in chat',
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      } else {
                        sendMsgChat(preS.id, textCtl.text.trim());
                        textCtl.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
