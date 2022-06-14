import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'pre_tile.dart';

class PrescriptPanel extends StatelessWidget {
  const PrescriptPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            int count = 0;
            return GridView(
              controller: ScrollController(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4,
              ),
              children: [
                preList(
                  count,
                  'https://4.bp.blogspot.com/-_kBJT0h6Spg/UdbTldpNbdI/AAAAAAAAAWA/18wS5P6bDY4/s1600/vio-2.jpg',
                  'Cao Chanh Duc',
                  '27/5/2021',
                  '',
                ),
                preList(
                  count,
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaiRjCpcSMjYpAg-jJnY2WWO2okfFbYvpT-g&usqp=CAU',
                  'Thuong Pham',
                  '27/5/2021',
                  '',
                ),
                preList(
                  count,
                  'https://4.bp.blogspot.com/-_kBJT0h6Spg/UdbTldpNbdI/AAAAAAAAAWA/18wS5P6bDY4/s1600/vio-2.jpg',
                  'Quoc Doanh',
                  '27/5/2021',
                  '',
                ),
              ],
            );
          }
        },
      ),
    );
  }

  AnimationConfiguration preList(int count, String img, name, date, note) {
    return AnimationConfiguration.staggeredList(
      position: count++,
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: PreTitle(img, name, date, note),
        ),
      ),
    );
  }
}
