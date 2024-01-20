import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

void updateSheet(BuildContext context,
    {VoidCallback? updateClick, VoidCallback? deleteClick}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (ctx) {
      return Container(
        height: 130,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: updateClick,
                  child: Container(
                    color: transparent,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Icon(
                          Icons.edit_note_sharp,
                          color: productColor,
                        ),
                        Text(
                          'Засах',
                          style: TextStyle(color: productColor),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: deleteClick,
                  child: Container(
                    color: transparent,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Icon(
                          Icons.delete_outline_outlined,
                          color: red,
                        ),
                        Text(
                          'Устгах',
                          style: TextStyle(color: red),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
