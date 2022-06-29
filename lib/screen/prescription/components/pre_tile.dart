import 'package:flutter/material.dart';

class PreTitle extends StatelessWidget {
  const PreTitle(this.imgUrl, this.name, this.date, this.note);

  final String imgUrl;
  final String name;
  final String date;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                imgUrl,
                height: 150,
                width: 100,
                fit: BoxFit.fill,
              ),
            ),
            title: Text(
              name,
              style: const TextStyle(color: Colors.blue),
            ),
            subtitle: Text(
              'sent: $date',
              style: const TextStyle(color: Colors.black),
            ),
            trailing: SizedBox(
              // width: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {}, child: const Text('View'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
