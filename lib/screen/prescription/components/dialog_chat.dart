import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/note.dart';

class DialogChat extends StatelessWidget {
  const DialogChat(this.id);
  final String id;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('prescription')
          .doc(id)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          final notes = snapshot.data!.data()!['note'] as List<dynamic>;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView(
              children: notes.map((e) {
                final note = Note.fromMap(e);
                if (note.msg.startsWith('>')) {
                  return Column(
                    children: [
                      BubbleSpecialThree(
                        text: note.msg.substring(1),
                        isSender: false,
                        color: const Color(0xFFE8E8EE),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            DateFormat('yyyy-MM-dd – kk:mm').format(note.time),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (note.msg.startsWith('*/*')) {
                  return BubbleSpecialThree(
                    text: note.msg.substring(3),
                    color: Colors.red,
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 20),
                    isSender: false,
                    tail: false,
                  );
                }
                return Column(
                  children: [
                    BubbleSpecialThree(
                      text: note.msg.substring(1),
                      color: const Color(0xFF1B97F3),
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 16),
                      isSender: true,
                      tail: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          DateFormat('yyyy-MM-dd – kk:mm').format(note.time),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
