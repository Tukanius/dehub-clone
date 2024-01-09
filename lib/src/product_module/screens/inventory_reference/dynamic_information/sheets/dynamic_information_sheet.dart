import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DynamicInformationSheet extends StatefulWidget {
  const DynamicInformationSheet({super.key});

  @override
  State<DynamicInformationSheet> createState() =>
      _DynamicInformationSheetState();
}

class _DynamicInformationSheetState extends State<DynamicInformationSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              border: Border(
                bottom: BorderSide(color: productColor),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    padding: const EdgeInsets.all(3),
                    color: transparent,
                    child: SvgPicture.asset(
                      'assets/svg/square-x.svg',
                      colorFilter: ColorFilter.mode(grey2, BlendMode.srcIn),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Динамик мэдээлэл',
                    style: TextStyle(
                      color: productColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                      color: productColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    height: 50,
                    child: Center(
                      child: Text(
                        'Хадгалах',
                        style: TextStyle(color: white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
