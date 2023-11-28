import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/profile/components/card.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  Partner partnerUser = Partner();

  @override
  Widget build(BuildContext context) {
    partnerUser = Provider.of<UserProvider>(context, listen: false).partnerUser;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            child: Text(
              'Холбоо барих мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InformationCard(
            labelText: 'Вэб сайтын хаяг',
            value: partnerUser.partner?.web,
            marginVertical: 5,
          ),
          InformationCard(
            labelText: 'И-мэйл хаяг №1',
            value: partnerUser.partner?.email,
            marginVertical: 5,
          ),
          InformationCard(
            labelText: 'И-мэйл хаяг №2',
            value: partnerUser.partner?.email2,
            marginVertical: 5,
          ),
          InformationCard(
            labelText: 'Утаны дугаар №1',
            value: partnerUser.partner?.phone,
            marginVertical: 5,
          ),
          InformationCard(
            labelText: 'Утаны дугаар №2',
            value: partnerUser.partner?.phone2,
            marginVertical: 5,
          ),
          InformationCard(
            labelText: 'Facebook хаяг',
            value: partnerUser.partner?.phone2,
            marginVertical: 5,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Байршлын мэдээлэл',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: grey3,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Image(
            image: AssetImage(
              'images/map.jpg',
            ),
          ),
          SizedBox(
            height: 90,
          )
        ],
      ),
    );
  }
}
