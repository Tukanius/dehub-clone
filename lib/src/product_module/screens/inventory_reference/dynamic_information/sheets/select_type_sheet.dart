import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SelectTypeSheet extends StatefulWidget {
  const SelectTypeSheet({super.key});

  @override
  State<SelectTypeSheet> createState() => _SelectTypeSheetState();
}

class _SelectTypeSheetState extends State<SelectTypeSheet> {
  General general = General();

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).inventoryGeneral;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: productColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Төрөл сонгох',
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    color: transparent,
                    child: SvgPicture.asset('assets/svg/square-x.svg'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: general.fieldTypes!
                    .map(
                      (e) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            e == "CHECKBOX"
                                ? Text(
                                    'Checkbox',
                                    style: TextStyle(color: dark),
                                  )
                                : e == "NUMBER"
                                    ? Text(
                                        'Тоон утга',
                                        style: TextStyle(color: dark),
                                      )
                                    : e == "TEXT"
                                        ? Text(
                                            'Текст утга',
                                            style: TextStyle(color: dark),
                                          )
                                        : Text(
                                            'Сонголтот утга',
                                            style: TextStyle(color: dark),
                                          ),
                            SvgPicture.asset(
                              'assets/svg/double-check.svg',
                              colorFilter: ColorFilter.mode(
                                  grey3.withOpacity(0.5), BlendMode.srcIn),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
