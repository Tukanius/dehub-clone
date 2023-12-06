import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/utils/currency_formatter.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InvoiceAddRowArguments {
  ListenController additionalRowsListenController;
  InvoiceAddRowArguments({
    required this.additionalRowsListenController,
  });
}

class InvoiceAddRow extends StatefulWidget {
  final ListenController additionalRowsListenController;

  static const routeName = '/InvoiceAddRow';
  const InvoiceAddRow({
    Key? key,
    required this.additionalRowsListenController,
  }) : super(key: key);

  @override
  State<InvoiceAddRow> createState() => _AddRowState();
}

class _AddRowState extends State<InvoiceAddRow> {
  String dropdownValue = "Сонгох";
  String dropdownValue1 = "Сонгох";
  Invoice row = Invoice();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  double? totalAmount;

  List<String> list = <String>[
    "Хувиар",
    "Дүнгээр",
  ];

  List<String> data = <String>[
    "Литр",
    "Ширхэг",
    "Лааз",
    "Килограм",
    "Грам",
  ];

  @override
  void dispose() {
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  onSubmit() async {
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        row = Invoice.fromJson(fbKey.currentState!.value);
        row.discountType = dropdownValue == "Хувиар"
            ? "PERCENT"
            : dropdownValue == "Дүнгээр"
                ? "AMOUNT"
                : null;
        row.unit = dropdownValue1;
        row.totalAmount = totalAmount;
        widget.additionalRowsListenController.invoiceAddRow(row);
        Navigator.of(context).pop();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void getTotalAmount() {
    double price;
    double quantity;

    price = double.tryParse(priceController.text) ?? 0;
    quantity = double.tryParse(quantityController.text) ?? 0;

    setState(() {
      totalAmount = quantity * price;
    });
  }

// isVatPayer
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        surfaceTintColor: white,
        backgroundColor: white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: invoiceColor,
          ),
        ),
        title: Text(
          'Мөр нэмэх',
          style: TextStyle(
            color: buttonColor,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: fbKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              FormTextField(
                textAlign: TextAlign.end,
                name: 'name',
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: white,
                  filled: true,
                  hintText: 'Энд оруулна уу',
                  hintStyle: TextStyle(
                    color: invoiceColor,
                  ),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Нэр',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Нэр оруулна уу',
                  ),
                ]),
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                color: white,
                padding: const EdgeInsets.all(10),
                child: FormTextField(
                  textAlign: TextAlign.left,
                  name: 'description',
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Энд тайлбар оруулна уу",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: grey, width: 0.5),
                    ),
                    fillColor: white,
                    filled: true,
                    hintStyle: TextStyle(
                      color: Color(0xff657786),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                color: white,
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Хэмжих нэгж',
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        onChanged: (value) {
                          setState(() {
                            dropdownValue1 = "${value}";
                          });
                          ;
                        },
                        dropdownColor: white,
                        borderRadius: BorderRadius.circular(10),
                        isExpanded: false,
                        hint: Container(
                          width: 135,
                          child: Text(
                            "Сонгох",
                            style: TextStyle(color: invoiceColor, fontSize: 14),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: invoiceColor,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          hintStyle:
                              TextStyle(color: invoiceColor, fontSize: 14),
                          filled: true,
                          fillColor: white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: data
                            .map(
                              (item) => DropdownMenuItem(
                                enabled: true,
                                value: item,
                                child: Container(
                                  width: 130,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "${item}",
                                      style: TextStyle(
                                        color: invoiceColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3,
              ),
              FormTextField(
                onChanged: (value) {
                  getTotalAmount();
                },
                controller: priceController,
                textColor: invoiceColor,
                textAlign: TextAlign.end,
                name: 'price',
                inputType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: white,
                  filled: true,
                  hintText: 'Энд оруулна уу',
                  hintStyle: TextStyle(
                    color: invoiceColor,
                  ),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Нэгж үнэ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Нэгж үнэ оруулна уу',
                  ),
                ]),
              ),
              SizedBox(
                height: 2,
              ),
              FormTextField(
                onChanged: (value) {
                  getTotalAmount();
                },
                textColor: invoiceColor,
                controller: quantityController,
                textAlign: TextAlign.end,
                name: 'quantity',
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: white,
                  filled: true,
                  hintText: 'Энд оруулна уу',
                  hintStyle: TextStyle(
                    color: invoiceColor,
                  ),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Тоо хэмжээ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Тоо хэмжээ оруулна уу',
                  ),
                ]),
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                color: white,
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Хөнгөлөлт',
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = "${value}";
                          });
                          ;
                        },
                        dropdownColor: white,
                        borderRadius: BorderRadius.circular(10),
                        isExpanded: false,
                        hint: Container(
                          width: 135,
                          child: Text(
                            "Сонгох",
                            style: TextStyle(color: invoiceColor, fontSize: 14),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: invoiceColor,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          hintStyle:
                              TextStyle(color: invoiceColor, fontSize: 14),
                          filled: true,
                          fillColor: white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: list
                            .map(
                              (item) => DropdownMenuItem(
                                enabled: true,
                                value: item,
                                child: Container(
                                  width: 130,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "${item}",
                                      style: TextStyle(
                                        color: invoiceColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3,
              ),
              FormTextField(
                inputFormatters: [
                  CurrencyInputFormatter(),
                ],
                maxLenght: dropdownValue == 'Хувиар'
                    ? 2
                    : dropdownValue == "Сонгох"
                        ? 1
                        : null,
                showCounter: false,
                textColor: invoiceColor,
                textAlign: TextAlign.end,
                name: 'discountValue',
                inputType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Container(
                    padding: const EdgeInsets.only(
                      bottom: 15,
                      left: 15,
                      top: 15,
                    ),
                    child: Text(
                      'Хөнгөлөлтийн дүн',
                      style: TextStyle(color: dark),
                    ),
                  ),
                  suffixIcon: dropdownValue == 'Хувиар'
                      ? Icon(
                          Icons.percent,
                          size: 15,
                          color: invoiceColor,
                        )
                      : dropdownValue == 'Дүнгээр'
                          ? Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                '₮',
                                style: TextStyle(
                                  color: invoiceColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : null,
                  fillColor: white,
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  hintStyle: TextStyle(color: invoiceColor),
                  hintText: 'Дүн оруулна уу',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  'Нийт',
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                color: white,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Үнийн дүн"),
                    totalAmount == null
                        ? Text(
                            'Үнийн дүн',
                            style: TextStyle(color: invoiceColor),
                          )
                        : Expanded(
                            child: Text(
                              '${Utils().formatCurrency(totalAmount.toString())}₮',
                              style: TextStyle(color: invoiceColor),
                              textAlign: TextAlign.end,
                              maxLines: 1,
                            ),
                          )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                color: white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Нийт тоо ширхэг',
                      style: TextStyle(color: buttonColor),
                    ),
                    Text(
                      '... ширхэг',
                      style: TextStyle(
                        color: invoiceColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomButton(
                  labelColor: invoiceColor,
                  onClick: () {
                    onSubmit();
                  },
                  labelText: "Болсон. Нэмье",
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
