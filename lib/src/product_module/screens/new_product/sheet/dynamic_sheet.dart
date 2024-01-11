import 'package:dehub/api/inventory_api.dart';
import 'package:dehub/providers/inventory_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:dehub/models/result.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DynamicSheet extends StatefulWidget {
  const DynamicSheet({super.key});

  @override
  State<DynamicSheet> createState() => _DynamicSheetState();
}

class _DynamicSheetState extends State<DynamicSheet> with AfterLayoutMixin {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  bool isLoading = true;
  Result dynamic = Result(count: 0, rows: []);

  @override
  afterFirstLayout(BuildContext context) async {
    dynamic = await InventoryApi().sectionSelect();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<InventoryProvider>(context, listen: false);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
            color: productColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Сонголт хийнэ үү',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isLoading == true
                    ? SizedBox()
                    : Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text(
                          'Бүртгэлтэй динамик мэдээлэл',
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: productColor,
                        ),
                      )
                    : Column(
                        children: dynamic.rows!
                            .map(
                              (data) => InkWell(
                                onTap: () {
                                  source.section(data, true);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${data.name}'),
                                      SvgPicture.asset(
                                        'assets/svg/double-check.svg',
                                        colorFilter: ColorFilter.mode(
                                            source == data
                                                ? productColor
                                                : grey3,
                                            BlendMode.srcIn),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 20, bottom: 40),
                  child: Text(
                    'Жагсаалтад тохирох өгөгдөл олдохгүй бол та шинээр нэмсний дараа сонголт хийнэ үү.',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
