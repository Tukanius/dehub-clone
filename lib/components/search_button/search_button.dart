import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchButton extends StatefulWidget {
  final Color? color;
  final Function(String query)? onChange;

  const SearchButton({
    Key? key,
    this.color,
    this.onChange,
  }) : super(key: key);

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 5),
              height: 30,
              child: FormTextField(
                controller: textController,
                name: 'query',
                onChanged: (value) {
                  if (widget.onChange != null) {
                    widget.onChange!(value);
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: grey,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(bottom: 10, left: 15),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 30,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: SvgPicture.asset(
                'images/yuluur.svg',
                color: widget.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
