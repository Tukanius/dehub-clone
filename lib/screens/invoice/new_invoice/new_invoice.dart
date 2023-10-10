import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/invoice_additional_line/invoice_additional_line.dart';
import 'package:dehub/components/invoice_product_card/add_product_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/invoice/new_invoice/add_product/add_product.dart';
import 'package:dehub/screens/invoice/new_invoice/add_row/invoice_add_row.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/harah.dart';
import 'package:dehub/screens/invoice/new_invoice/sector-choose/sector-choose.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:after_layout/after_layout.dart';

class NewInvoice extends StatefulWidget {
  static const routeName = '/newinvoice';
  const NewInvoice({
    Key? key,
  }) : super(key: key);

  @override
  State<NewInvoice> createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  ListenController listenController = ListenController();
  ListenController partnerListenController = ListenController();
  ListenController goodsListenController = ListenController();
  ListenController sectorListenController = ListenController();
  TextEditingController textController = TextEditingController();
  TextEditingController shippingAmountController = TextEditingController();
  TextEditingController discountAmountController = TextEditingController();
  ListenController addRowController = ListenController();
  List<Invoice> additionalRowList = [];
  Invoice additionalRow = Invoice();
  Invoice invoice = Invoice();
  Invoice createInvoice = Invoice();
  Invoice partnerInvoice = Invoice();
  Invoice sectorInvoice = Invoice();
  Invoice goodsInvoice = Invoice();
  bool isLoading = false;
  List<Invoice> inventory = [];
  List<Invoice> data = [];
  bool isSubmit = false;
  Partner user = Partner();
  String dropdownValue = "Сонгох";
  double amount = 0;
  double vatAmount = 0;
  double taxAmount = 0;
  double totalAmount = 0;
  double finalAmount = 0;
  double additionalRowAmount = 0;

  List<String> list = <String>[
    "Хувиар",
    "Дүнгээр",
  ];

  @override
  afterFirstLayout(BuildContext context) {
    shippingAmountController.text = "0";
  }

  @override
  void initState() {
    listenController.addListener(() {
      setState(() {
        invoice = listenController.invoice!;
      });
    });
    goodsListenController.addListener(() {
      goodsInvoice = goodsListenController.goodsInvoice!;
      setState(() {
        inventory.add(goodsInvoice);
        data.add(goodsInvoice);
        double eachAmount = inventory.fold(0,
            (previousValue, element) => previousValue + element.totalAmount!);
        amount = eachAmount.roundToDouble();
        double vat = inventory
            .map((e) => e.quantity! * e.vatAmount!)
            .reduce((value, element) => value + element);
        vatAmount = vat.roundToDouble();
        double tax = inventory.fold(
            0, (previousValue, element) => previousValue + element.taxAmount!);
        taxAmount = tax.roundToDouble();
        totalAmount = amount + vatAmount + taxAmount + additionalRowAmount;
        finalAmount = totalAmount;
      });
    });
    partnerListenController.addListener(() {
      setState(() {
        partnerInvoice = partnerListenController.partnerInvoice!;
      });
    });
    sectorListenController.addListener(() {
      setState(() {
        sectorInvoice = sectorListenController.sectorInvoice!;
      });
    });
    addRowController.addListener(() {
      setState(() {
        additionalRow = addRowController.invoiceAdditionalRow!;
        additionalRowList.add(additionalRow);
        double addrow = additionalRowList.fold(0,
            (previousValue, element) => previousValue + element.totalAmount!);
        additionalRowAmount = addrow.roundToDouble();
        totalAmount = amount + vatAmount + taxAmount + additionalRowAmount;
      });
    });
    super.initState();
  }

  onSubmit(bool value) async {
    setState(() {
      isSubmit = true;
    });
    try {
      if (fbKey.currentState!.saveAndValidate()) {
        for (var i = 0; i < inventory.length; i++) {
          data[i] = Invoice();
          data[i].variantId = inventory[i].id;
          data[i].quantity = inventory[i].quantity;
        }
        createInvoice.senderBranchId = sectorInvoice.id;
        createInvoice.receiverBranchId = partnerInvoice.id;
        createInvoice.receiverBusinessId = invoice.id;
        createInvoice.send = value;
        createInvoice.lines = data;
        createInvoice.additionalLines = additionalRowList;
        createInvoice.description = textController.text;
        await InvoiceApi().createInvoice(createInvoice);
        showCustomDialog(
          context,
          value == true
              ? 'Нэхэмжлэл амжилттай илгээгдлээ'
              : "Нэхэмжэл амжилттай хадгалагдлаа",
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      }
      setState(() {
        isSubmit = false;
      });
    } catch (e) {
      setState(() {
        isSubmit = false;
      });
    }
  }

  // amount(String? amount) {
  //   print(amount);
  //   // totalAmount = Utils().formatCurrency((inventory
  //   //     .map((e) => e.totalAmount)
  //   //     .reduce((value, element) => value! + element!)
  //   //     .toString()));
  //   asdf = inventory.reduce(
  //     (value, element) => Invoice(
  //         totalAmount: (value.totalAmount! + element.vatAmount!) +
  //             (value.taxAmount! + element.taxAmount!) +
  //             (value.vatAmount! + element.vatAmount!)),
  //   );
  //   print(asdf.totalAmount);

  //   if (amount != '') {
  //     d1 = asdf.totalAmount! + double.parse(amount!);
  //   } else {
  //     d1 = asdf.totalAmount! + 0;
  //   }

  //   return d1 == null ? asdf.totalAmount : d1;
  // }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).partnerUser;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: invoiceColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
        ),
        title: Text(
          'Шинэ нэхэмжлэл',
          style: TextStyle(
            color: white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: isLoading == false
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          'ХАРИЛЦАГЧ',
                          style: TextStyle(
                            color: grey3,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            CustomerChoose.routeName,
                            arguments: CustomerChooseArguments(
                              listenController: listenController,
                              partnerListenController: partnerListenController,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          color: white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.perm_contact_cal_outlined,
                                      color: invoiceColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  invoice.partner?.businessName == null
                                      ? Text(
                                          'Харилцагч сонгох',
                                          style: TextStyle(color: invoiceColor),
                                        )
                                      : Text(
                                          '${invoice.partner?.businessName}',
                                          style: TextStyle(color: invoiceColor),
                                        )
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        color: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'Хүргэлтийн хаяг',
                              ),
                            ),
                            partnerInvoice.name == null
                                ? Row(
                                    children: [
                                      Text('-'),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ],
                                  )
                                : Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${partnerInvoice.name}',
                                            style: TextStyle(
                                              color: invoiceColor,
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        color: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'Нэхэмжлэх илгээх',
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  invoice.partnerName == null
                                      ? Expanded(
                                          child: Text(
                                            '-',
                                            textAlign: TextAlign.end,
                                          ),
                                        )
                                      : Expanded(
                                          child: Text(
                                            invoice.partnerName.toString(),
                                            style: TextStyle(
                                              color: invoiceColor,
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Text(
                          'НЭХЭМЖЛЭГЧ',
                          style: TextStyle(
                            color: grey3,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        color: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.perm_contact_cal_outlined,
                                    color: invoiceColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${user.user?.currentBusiness?.profileName}',
                                  style: TextStyle(color: invoiceColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        color: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Партнерийн нэр',
                            ),
                            Row(
                              children: [
                                Text(
                                  '${user.user?.currentBusiness?.partnerName}',
                                  style: TextStyle(color: invoiceColor),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            SectorChoose.routeName,
                            arguments: SectorChooseArguments(
                                sectorListenController: sectorListenController),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          color: white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Салбарын нэр',
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    sectorInvoice.name == null
                                        ? Expanded(
                                            child: Text(
                                              'Салбар сонгох',
                                              style: TextStyle(
                                                color: invoiceColor,
                                              ),
                                              textAlign: TextAlign.end,
                                            ),
                                          )
                                        : Expanded(
                                            child: Text(
                                              '${sectorInvoice.name}',
                                              style: TextStyle(
                                                color: invoiceColor,
                                              ),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Text(
                          'БАРАА, ҮЙЛЧИЛГЭЭ',
                          style: TextStyle(
                            color: grey3,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (invoice.id != null && partnerInvoice.id != null) {
                            Navigator.of(context).pushNamed(
                              AddProduct.routeName,
                              arguments: AddProductArguments(
                                data: inventory,
                                businessId: invoice.id!,
                                goodsListenController: goodsListenController,
                              ),
                            );
                          } else {
                            if (invoice.id == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: invoiceColor,
                                  shape: StadiumBorder(),
                                  content: Center(
                                    child: Text('Харилцагч сонгоно уу!'),
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: invoiceColor,
                                  shape: StadiumBorder(),
                                  content: Center(
                                    child: Text('Салбар сонгоно уу!'),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                          color: white,
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.download_for_offline_outlined,
                                      color: invoiceColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Бараа нэмэх',
                                    style: TextStyle(color: invoiceColor),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: inventory
                            .map(
                              (item) => AddProductCard(
                                readOnly: true,
                                closeClick: () {
                                  setState(() {
                                    inventory.removeWhere((element) =>
                                        element.variantId == item.variantId);
                                    data.removeWhere((element) =>
                                        element.variantId == item.variantId);
                                  });
                                },
                                data: item,
                                onClick: () {
                                  print(item.toJson());
                                },
                              ),
                            )
                            .toList(),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        child: Text(
                          'НЭМЭЛТЭЭР',
                          style: TextStyle(
                            color: grey3,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            InvoiceAddRow.routeName,
                            arguments: InvoiceAddRowArguments(
                              additionalRowsListenController: addRowController,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          color: white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Мөр нэмэх',
                                style: TextStyle(color: invoiceColor),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: additionalRowList
                            .map(
                              (e) => InvoiceAdditionalLine(
                                data: e,
                              ),
                            )
                            .toList(),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 15, bottom: 10, top: 10),
                        child: Text(
                          'НИЙТ ТӨЛБӨР',
                          style: TextStyle(
                            color: grey3,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15),
                        color: white,
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
                                    style: TextStyle(
                                        color: invoiceColor, fontSize: 14),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: black,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  hintStyle: TextStyle(
                                      color: invoiceColor, fontSize: 14),
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
                      FormTextField(
                        // maxLenght: dropdownValue == 'Хувиар' ? 2 : null,
                        // showCounter: false,
                        textColor: networkColor,
                        textAlign: TextAlign.end,
                        readOnly: dropdownValue == "Сонгох",
                        onChanged: (value) {
                          if (dropdownValue == "Хувиар") {
                            if (discountAmountController.text == '')
                              setState(() {
                                discountAmountController.text = '0';
                              });
                            setState(() {
                              totalAmount = totalAmount -
                                  (totalAmount *
                                      double.parse(discountAmountController.text
                                          .toString()) /
                                      100);
                            });
                          } else {
                            if (discountAmountController.text == "")
                              setState(() {
                                discountAmountController.text = "0";
                              });
                            setState(() {
                              totalAmount = totalAmount -
                                  double.parse(
                                      discountAmountController.text.toString());
                            });
                          }
                        },
                        controller: discountAmountController,
                        name: 'discountAmount',
                        inputType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 15, left: 15),
                            child: Text(
                              'Хөнгөлөлтийн дүн',
                              style: TextStyle(color: dark),
                            ),
                          ),
                          isDense: true,
                          suffixIcon: dropdownValue == 'Хувиар'
                              ? Icon(
                                  Icons.percent,
                                  size: 15,
                                  color: invoiceColor,
                                )
                              : dropdownValue == 'Дүнгээр'
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
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
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 1),
                          hintStyle: TextStyle(color: invoiceColor),
                          hintText: 'Дүн оруулна уу',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        color: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'Тооцсон НӨАТ',
                              ),
                            ),
                            Row(
                              children: [
                                inventory.isNotEmpty
                                    ? Text(
                                        '${Utils().formatCurrency(vatAmount.toString())}₮',
                                        style: TextStyle(color: invoiceColor),
                                      )
                                    : Text(
                                        '0₮',
                                        style: TextStyle(color: invoiceColor),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        color: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'Тооцсон НХАТ',
                              ),
                            ),
                            inventory.isNotEmpty
                                ? Text(
                                    '${inventory.map((e) => e.quantity! * e.taxAmount!).join("")}₮',
                                    style: TextStyle(color: invoiceColor),
                                  )
                                : Text(
                                    '0₮',
                                    style: TextStyle(color: invoiceColor),
                                  ),
                          ],
                        ),
                      ),
                      FormTextField(
                        onChanged: (value) {
                          setState(() {
                            finalAmount = totalAmount;
                            finalAmount = finalAmount +
                                (double.tryParse(
                                        shippingAmountController.text) ??
                                    0);
                          });
                        },
                        textColor: orderColor,
                        name: "shippingAmount",
                        controller: shippingAmountController,
                        textAlign: TextAlign.end,
                        inputType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            padding: const EdgeInsets.only(
                                top: 15, left: 15, bottom: 15),
                            child: Text(
                              'Хүргэлтийн төлбөр',
                              style: TextStyle(color: dark),
                            ),
                          ),
                          suffixIcon: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              '₮',
                              style: TextStyle(
                                color: invoiceColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          fillColor: white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          hintStyle: TextStyle(color: invoiceColor),
                          hintText: 'Дүн оруулна уу',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        color: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Нэмэлтээр',
                            ),
                            Row(
                              children: [
                                inventory.isNotEmpty
                                    ? Text(
                                        "${Utils().formatCurrency(additionalRowAmount.toString())}₮",
                                        style: TextStyle(
                                          color: invoiceColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : Text(
                                        '0 ₮',
                                        style: TextStyle(
                                          color: invoiceColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        color: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'Нийт Төлбөр',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                inventory.isNotEmpty
                                    ? Text(
                                        "${finalAmount}₮",
                                        style: TextStyle(
                                          color: invoiceColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Text(
                                        '0 ₮',
                                        style: TextStyle(
                                          color: invoiceColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        child: Text(
                          'Нэмэлт Тэмдэглэл',
                          style: TextStyle(
                            color: grey3,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        color: white,
                        padding: const EdgeInsets.all(15),
                        child: FormBuilder(
                          key: fbKey,
                          child: FormTextField(
                            controller: textController,
                            textAlign: TextAlign.left,
                            name: 'description',
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              fillColor: white,
                              filled: true,
                              hintStyle: TextStyle(
                                color: orderColor,
                              ),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: 'Тэмдэглэл оруулна уу')
                            ]),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   margin: const EdgeInsets.only(left: 15),
                      //   child: Text(
                      //     'ТӨЛБӨРИЙН МЭДЭЭЛЭЛ',
                      //     style: TextStyle(
                      //       color: grey3,
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.all(15),
                      //   color: white,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Container(
                      //         child: Text(
                      //           'Нэхэмжлэх үлдэгдэл',
                      //         ),
                      //       ),
                      //       Row(
                      //         children: [
                      //           Text(
                      //             '00.00 ₮',
                      //             style: TextStyle(color: invoiceColor),
                      //           ),
                      //           SizedBox(
                      //             width: 10,
                      //           ),
                      //           Icon(
                      //             Icons.arrow_forward_ios,
                      //             size: 12,
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.all(15),
                      //   color: white,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Container(
                      //         child: Text(
                      //           'Төлбөл зохих',
                      //         ),
                      //       ),
                      //       Row(
                      //         children: [
                      //           Text(
                      //             '00.00 ₮',
                      //             style: TextStyle(color: invoiceColor),
                      //           ),
                      //           SizedBox(
                      //             width: 10,
                      //           ),
                      //           Icon(
                      //             Icons.arrow_forward_ios,
                      //             size: 12,
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.all(15),
                      //   color: white,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Container(
                      //         child: Text(
                      //           'Төлөх хугацаа',
                      //         ),
                      //       ),
                      //       Row(
                      //         children: [
                      //           Text(
                      //             '2021-12-02',
                      //           ),
                      //           SizedBox(
                      //             width: 10,
                      //           ),
                      //           Icon(
                      //             Icons.arrow_forward_ios,
                      //             size: 12,
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.all(15),
                      //   color: white,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         'Төлбөрийн төлөв',
                      //       ),
                      //       Row(
                      //         children: [
                      //           Text('Төлөлт хүлээж буй'),
                      //           SizedBox(
                      //             width: 10,
                      //           ),
                      //           Icon(
                      //             Icons.arrow_forward_ios,
                      //             size: 12,
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.all(15),
                      //   color: white,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         'Нэхэмжлэх дүн',
                      //       ),
                      //       Row(
                      //         children: [
                      //           Text(
                      //             '00.00 ₮',
                      //             style: TextStyle(color: invoiceColor),
                      //           ),
                      //           SizedBox(
                      //             width: 10,
                      //           ),
                      //           Icon(
                      //             Icons.arrow_forward_ios,
                      //             size: 12,
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.all(15),
                      //   color: white,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         'Нэхэмжлэх төлөх',
                      //       ),
                      //       Row(
                      //         children: [
                      //           Text(
                      //             '2021-12-02',
                      //           ),
                      //           SizedBox(
                      //             width: 10,
                      //           ),
                      //           Icon(
                      //             Icons.arrow_forward_ios,
                      //             size: 12,
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.all(15),
                      //   color: white,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         'Хугацаа хэтрэлт',
                      //       ),
                      //       Row(
                      //         children: [
                      //           Text(
                      //             'Хэвийн',
                      //           ),
                      //           SizedBox(
                      //             width: 10,
                      //           ),
                      //           Icon(
                      //             Icons.arrow_forward_ios,
                      //             size: 12,
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 70,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 30),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: black,
                        ),
                        child: isSubmit == true
                            ? Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: white,
                                    strokeWidth: 1,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        Harah.routeName,
                                        arguments: HarahArguments(
                                          totalAmount: totalAmount,
                                          invoice: invoice,
                                          data: inventory,
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.visibility_outlined,
                                          color: white,
                                          size: 20,
                                        ),
                                        Text(
                                          'Харах',
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 10,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (isSubmit == false) {
                                        onSubmit(false);
                                      } else {}
                                    },
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/save.svg',
                                          height: 20,
                                        ),
                                        Text(
                                          'Хадгалах',
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 10,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (data.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: invoiceColor,
                                            shape: StadiumBorder(),
                                            content: Center(
                                              child: Text('Бараа нэмнэ үү'),
                                            ),
                                          ),
                                        );
                                      } else if (sectorInvoice.name == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: invoiceColor,
                                            shape: StadiumBorder(),
                                            content: Center(
                                              child: Text(
                                                  'Нэхэмжлэгч салбар сонгоно уу'),
                                            ),
                                          ),
                                        );
                                      } else {
                                        if (isSubmit == false) {
                                          onSubmit(true);
                                        }
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.send,
                                          color: white,
                                          size: 20,
                                        ),
                                        Text(
                                          'Илгээх',
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 10,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/cancel.svg',
                                          height: 20,
                                        ),
                                        Text(
                                          'Цуцлах',
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: invoiceColor,
                ),
              ),
      ),
    );
  }
}
