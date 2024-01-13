import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';

class EditingInformation extends StatefulWidget {
  final String labelText;
  final double paddingVertical;
  final String? value;
  final String name;
  final bool edit;
  const EditingInformation({
    super.key,
    this.value,
    required this.edit,
    required this.name,
    required this.paddingVertical,
    required this.labelText,
  });

  @override
  State<EditingInformation> createState() => _EditingInformationState();
}

class _EditingInformationState extends State<EditingInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: widget.paddingVertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.labelText}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: grey3,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Row(
          // children: [
          // Expanded(
          //   child:
          FormTextField(
            readOnly: !widget.edit,
            initialValue: widget.value,
            name: widget.name,
            textColor: grey3,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              hintText: 'Регистр №',
              hintStyle: TextStyle(color: grey3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: grey3),
              ),
            ),
          ),
          // ),
          // ],
          // ),
        ],
      ),
    );
  }
}
