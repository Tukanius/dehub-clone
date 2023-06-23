import 'package:flutter/material.dart';

class TakeGiveCard extends StatefulWidget {
  const TakeGiveCard({super.key});

  @override
  State<TakeGiveCard> createState() => _TakeGiveCardState();
}

class _TakeGiveCardState extends State<TakeGiveCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        border: Border.all(),
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('images/map.jpg'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
