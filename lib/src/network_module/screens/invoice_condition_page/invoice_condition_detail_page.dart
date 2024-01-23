import 'package:dehub/api/business_api.dart';
import 'package:dehub/models/reference_information_get.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class InvoiceConditionDetailPageArguments {
  String id;
  InvoiceConditionDetailPageArguments({
    required this.id,
  });
}

class InvoiceConditionDetailPage extends StatefulWidget {
  final String id;
  static const routeName = 'InvoiceConditionDetailPage';
  const InvoiceConditionDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<InvoiceConditionDetailPage> createState() =>
      _InvoiceConditionDetailPageState();
}

class _InvoiceConditionDetailPageState extends State<InvoiceConditionDetailPage>
    with AfterLayoutMixin {
  ReferenceInformationGet referenceGet = ReferenceInformationGet();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    referenceGet = await BusinessApi().paymentTermGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        elevation: 0,
        iconTheme: const IconThemeData(color: networkColor),
        title: const Text(
          'Нэхэмжлэх нөхцөл',
          style: TextStyle(
            color: networkColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: networkColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text(
                      'Тохиргоо',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Нөхцөл нэр',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${referenceGet.termRule}',
                          style: const TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Код',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${referenceGet.refCode}',
                          style: const TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Тайлбар',
                          style: TextStyle(color: dark),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            '${referenceGet.description}',
                            style: const TextStyle(color: networkColor),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Хоног',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${referenceGet.expireDayCount}',
                          style: const TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Сар',
                          style: TextStyle(color: dark),
                        ),
                        referenceGet.month != null
                            ? Text(
                                '${referenceGet.month}',
                                style: const TextStyle(color: networkColor),
                              )
                            : const Text(
                                '-',
                                style: TextStyle(color: networkColor),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Өдөр',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '-',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text(
                      'Системийн мэдээлэл',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Статус',
                          style: TextStyle(color: dark),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xff01D462).withOpacity(0.1),
                          ),
                          child: const Text(
                            'Идэвхтэй',
                            style: TextStyle(
                              color: Color(0xff01D462),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бүртгэсэн ажилтан',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'Username',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'И-мэйл хаяг',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          'Email',
                          style: TextStyle(color: networkColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Default эсэх',
                          style: TextStyle(color: dark),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: networkColor,
                            // Color(0xff01D462).withOpacity(0.1),
                          ),
                          child: const Text(
                            'Тийм',
                            style: TextStyle(
                              color: white,
                              //  Color(0xff01D462),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'DeHUB стандарт',
                          style: TextStyle(color: dark),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: networkColor,
                            // Color(0xff01D462).withOpacity(0.1),
                          ),
                          child: const Text(
                            'Тийм',
                            style: TextStyle(
                              color: white,
                              // Color(0xff01D462),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
