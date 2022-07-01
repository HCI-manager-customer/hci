import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/prescription_controller.dart';
import '../prescription.dart';
import 'dialog_make_order.dart';
import 'pre_tile.dart';

class PrescriptPanel extends StatelessWidget {
  const PrescriptPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GetX<PreScripController>(
        init: PreScripController(),
        builder: (preS) {
          if (preS.prescriptions.isEmpty) {
            return const Center(
              child: Text(
                'No Prescription',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            int count = 0;
            return GridView(
              controller: ScrollController(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4,
              ),
              children: preS.prescriptions
                  .map(
                    (e) => AnimationConfiguration.staggeredList(
                      position: count++,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Consumer(builder: (context, ref, _) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  ref.read(preLoadProvider.notifier).state = e;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          e.Imgurl,
                                        ),
                                      ),
                                      title: Text(
                                        e.name,
                                        style: GoogleFonts.kanit(
                                            color: Colors.black),
                                      ),
                                      subtitle: Text(
                                        e.status,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      trailing: TextButton(
                                        child: const Text('Make Order'),
                                        onPressed: () {
                                          showGeneralDialog(
                                            context: context,
                                            barrierLabel: "Barrier",
                                            barrierDismissible: true,
                                            barrierColor:
                                                Colors.black.withOpacity(0.5),
                                            transitionDuration: const Duration(
                                                milliseconds: 400),
                                            pageBuilder: (_, __, ___) {
                                              return MakeOrder(e);
                                            },
                                            transitionBuilder:
                                                (_, anim, __, child) {
                                              Tween<Offset> tween;
                                              if (anim.status ==
                                                  AnimationStatus.reverse) {
                                                tween = Tween(
                                                    begin: const Offset(-1, 0),
                                                    end: Offset.zero);
                                              } else {
                                                tween = Tween(
                                                    begin: const Offset(1, 0),
                                                    end: Offset.zero);
                                              }
                                              return SlideTransition(
                                                position: tween.animate(anim),
                                                child: FadeTransition(
                                                  opacity: anim,
                                                  child: child,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  )
                  .toList(),
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
