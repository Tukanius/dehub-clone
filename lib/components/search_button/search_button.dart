import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchButton extends StatefulWidget {
  final Color color;
  final Function(String query)? onChange;
  final Color? textColor;
  final Color? borderColor;
  final String? initialValue;
  const SearchButton({
    super.key,
    this.initialValue,
    this.borderColor,
    this.textColor,
    required this.color,
    this.onChange,
  });

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
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
                initialValue: widget.initialValue,
                textColor: widget.textColor ?? black,
                name: 'query',
                onChanged: (value) {
                  if (widget.onChange != null) {
                    widget.onChange!(value);
                  }
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.borderColor ?? Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.borderColor ?? Colors.grey,
                    ),
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: SvgPicture.asset('assets/svg/search.svg'),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: grey,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(
                    bottom: 10,
                    left: 15,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.borderColor ?? Colors.grey,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: SvgPicture.asset(
                'assets/svg/yuluur.svg',
                colorFilter: ColorFilter.mode(widget.color, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
