import 'package:flutter/material.dart';

class PartnerTab extends StatefulWidget {
  const PartnerTab({super.key});

  @override
  PartnerTabState createState() => PartnerTabState();
}

class PartnerTabState extends State<PartnerTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, top: 5),
              child: const Text(
                'Харилцагч',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // for (var i = 0; i < 10; i++)
            //   PartnerCard(

            //     type: false,
            //   ),
          ],
        ),
      ),
    );
  }
}
