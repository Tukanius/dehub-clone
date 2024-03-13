import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/src/invoice_module/components/invoice_additional_line/invoice_additional_line.dart';
import 'package:dehub/src/invoice_module/components/invoice_product_card/invoice_product_card.dart';
import 'package:dehub/components/scaffold_messenger/scaffold_messenger.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/invoice_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/pin_check/pin_check.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/add_product/add_product.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/add_row/invoice_add_row.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/customer_choose/customer_choose.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/harah/harah.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/sector-choose/sector_choose.dart';
import 'package:dehub/utils/currency_formatter.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class NewInvoiceArguments {
  Invoice? data;
  NewInvoiceArguments({
    this.data,
  });
}

class NewInvoice extends StatefulWidget {
  static const routeName = '/NewInvoice';
  final Invoice? data;
  const NewInvoice({
    super.key,
    this.data,
  });

  @override
  State<NewInvoice> createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> with AfterLayoutMixin {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  String shippingAmount = '';
  User user = User();
  bool isLoading = true;
  var productKey = GlobalKey();
  var sectorKey = GlobalKey();
  var invoiceKey = GlobalKey();
  bool invoiceValidate = false;
  bool sectorValidate = false;
  List<String> list = <String>[
    "Хувиар",
    "Дүнгээр",
  ];

  @override
  afterFirstLayout(BuildContext context) {
    final source = Provider.of<InvoiceProvider>(context, listen: false);
    source.clearData();
    if (widget.data != null) {
      for (var i = 0; i < widget.data!.lines!.length; i++) {
        widget.data!.lines![i].vatAmount = widget.data!.lines![i].vatAmount! /
            widget.data!.lines![i].quantity!;
      }
      source.partnerChoose(widget.data!.receiverBusiness!);
      source.branchChoose(Invoice(branch: widget.data!.receiverBranch!));
      source.sectorChoose(Invoice(branch: widget.data!.senderBranch!));
      source.products = widget.data!.lines!;
      source.additionalLines = widget.data!.additionalLines!;
      shippingAmount = widget.data!.shippingAmount != 0
          ? widget.data!.shippingAmount!.toInt().toString()
          : '';
      discountController.text = widget.data!.discountValue!.toInt().toString();
      descriptionController.text = widget.data!.description.toString();
      source.discountType(
          widget.data?.discountType == "PERCENTAGE"
              ? "Хувиар"
              : widget.data?.discountType == "AMOUNT"
                  ? "Дүнгээр"
                  : "Сонгох",
          widget.data!.discountAmount.toString(),
          widget.data!.shippingAmount.toString());
      source.totalAmountInvoice(discountController.text, shippingAmount);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final invoice = Provider.of<InvoiceProvider>(context, listen: true);
    user = Provider.of<UserProvider>(context, listen: true).invoiceMe;
    if (invoice.newInvoice.partner != null) {
      setState(() {
        invoiceValidate = false;
      });
    }
    if (invoice.newInvoice.senderBranch != null) {
      setState(() {
        sectorValidate = false;
      });
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: invoiceColor,
          surfaceTintColor: invoiceColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: white,
            ),
          ),
          title: Text(
            widget.data == null ? 'Шинэ нэхэмжлэл' : "Нэхэмжлэх засах",
            style: const TextStyle(
              color: white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: isLoading == true
            ? const SizedBox()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15, top: 10),
                      child: const Text(
                        'ХАРИЛЦАГЧ',
                        style: TextStyle(
                          color: grey3,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          CustomerChoose.routeName,
                        );
                      },
                      child: Container(
                        key: invoiceKey,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: white,
                          border: Border.all(
                              color:
                                  invoiceValidate == true ? red : transparent,
                              width: invoiceValidate == true ? 1 : 0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.perm_contact_cal_outlined,
                                  color: invoiceValidate == true
                                      ? red
                                      : invoiceColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                invoice.newInvoice.partner?.profileName == null
                                    ? Text(
                                        'Харилцагч сонгох',
                                        style: TextStyle(
                                            color: invoiceValidate == true
                                                ? red
                                                : invoiceColor),
                                      )
                                    : Text(
                                        '${invoice.newInvoice.partner?.profileName}',
                                        style: const TextStyle(
                                            color: invoiceColor),
                                      )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: invoiceValidate == true ? red : black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    FieldCard(
                      paddingHorizontal: 15,
                      paddingVertical: 15,
                      arrowColor: black,
                      onClick: () {},
                      labelText: 'Хүргэлтийн хаяг',
                      secondText: invoice.newInvoice.receiverBranch != null
                          ? "${invoice.newInvoice.receiverBranch?.name}"
                          : '-',
                      secondTextColor: invoiceColor,
                      color: white,
                    ),
                    FieldCard(
                      paddingHorizontal: 15,
                      paddingVertical: 15,
                      arrowColor: black,
                      onClick: () {},
                      labelText: 'Нэхэмжлэх илгээх',
                      secondText: invoice
                                  .newInvoice.partner?.partner?.businessName !=
                              null
                          ? "${invoice.newInvoice.partner?.partner?.businessName}"
                          : '-',
                      secondTextColor: invoiceColor,
                      color: white,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: const Text(
                        'НЭХЭМЖЛЭГЧ',
                        style: TextStyle(
                          color: grey3,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      color: white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.perm_contact_cal_outlined,
                                color: invoiceColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${user.currentBusiness?.profileName}',
                                style: const TextStyle(color: invoiceColor),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                    FieldCard(
                      paddingHorizontal: 15,
                      paddingVertical: 15,
                      arrowColor: black,
                      onClick: () {},
                      labelText: 'Партнерийн нэр',
                      secondText: user.currentBusiness?.partnerName,
                      secondTextColor: invoiceColor,
                      color: white,
                    ),
                    FieldCard(
                      key: sectorKey,
                      validate: sectorValidate,
                      paddingHorizontal: 15,
                      paddingVertical: 15,
                      arrowColor: black,
                      onClick: () {
                        Navigator.of(context).pushNamed(SectorChoose.routeName);
                      },
                      labelText: 'Салбарын нэр',
                      secondText: invoice.newInvoice.senderBranch != null
                          ? "${invoice.newInvoice.senderBranch?.name}"
                          : "Салбар сонгох",
                      secondTextColor: invoiceColor,
                      color: white,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: const Text(
                        'БАРАА, ҮЙЛЧИЛГЭЭ',
                        style: TextStyle(
                          color: grey3,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (invoice.newInvoice.partner?.id != null &&
                            invoice.newInvoice.receiverBranch?.id != null) {
                          Navigator.of(context).pushNamed(
                            AddProduct.routeName,
                            arguments: AddProductArguments(
                              shippingAmount: shippingAmount,
                              discountAmount: discountController.text,
                              businessId: invoice.newInvoice.partner!.id!,
                            ),
                          );
                        } else {
                          customScaffoldMessenger(
                            context,
                            color: invoiceColor,
                            labelText: 'Харилцагч сонгоно уу',
                          );
                        }
                      },
                      child: Container(
                        key: productKey,
                        decoration: const BoxDecoration(
                          color: white,
                        ),
                        padding: const EdgeInsets.all(15),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.download_for_offline_outlined,
                                  color: invoiceColor,
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
                              size: 14,
                              color: black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: invoice.products
                          .map(
                            (item) => InvoiceProductCard(
                              readOnly: false,
                              discountAmount: discountController.text,
                              shippingAmount: shippingAmount,
                              closeClick: () {
                                invoice.removeCart(item,
                                    discountController.text, shippingAmount);
                              },
                              data: item,
                              onClick: () {
                                FocusScope.of(context).unfocus();
                              },
                            ),
                          )
                          .toList(),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: const Text(
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
                              discountAmount: discountController.text,
                              shippingAmount: shippingAmount),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        color: white,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Мөр нэмэх',
                              style: TextStyle(color: invoiceColor),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: invoice.additionalLines
                          .map(
                            (e) => InvoiceAdditionalLine(
                              shippingAmount: shippingAmount,
                              discountAmount: discountController.text,
                              newInvoice: true,
                              index: invoice.additionalLines.indexOf(e),
                              data: e,
                            ),
                          )
                          .toList(),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 15, bottom: 10, top: 10),
                      child: const Text(
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
                          const Expanded(
                            child: Text(
                              'Хөнгөлөлт',
                            ),
                          ),
                          Expanded(
                            child: DropdownButtonFormField(
                              onChanged: (value) {
                                invoice.discountType(value.toString(),
                                    discountController.text, shippingAmount);
                              },
                              dropdownColor: white,
                              borderRadius: BorderRadius.circular(10),
                              isExpanded: false,
                              hint: SizedBox(
                                width: 135,
                                child: Text(
                                  "${invoice.newInvoice.discountType}",
                                  style: const TextStyle(
                                      color: invoiceColor, fontSize: 14),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: black,
                              ),
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
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
                                      child: SizedBox(
                                        width: 130,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
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
                      textColor: invoiceColor,
                      controller: discountController,
                      textAlign: TextAlign.end,
                      readOnly: invoice.newInvoice.discountType == "Сонгох",
                      onChanged: (value) {
                        invoice.totalAmountInvoice(
                            discountController.text, shippingAmount);
                      },
                      name: 'discountAmount',
                      inputType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 15),
                          child: const Text(
                            'Хөнгөлөлтийн дүн',
                            style: TextStyle(color: dark),
                          ),
                        ),
                        isDense: true,
                        suffixIcon: invoice.newInvoice.discountType == 'Хувиар'
                            ? const Icon(
                                Icons.percent,
                                size: 15,
                                color: invoiceColor,
                              )
                            : invoice.newInvoice.discountType == 'Дүнгээр'
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: const Text(
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
                        hintStyle: const TextStyle(color: invoiceColor),
                        hintText: 'Дүн оруулна уу',
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                    FieldCard(
                      paddingHorizontal: 15,
                      paddingVertical: 15,
                      arrowColor: black,
                      labelText: 'Тооцсон НӨАТ',
                      secondText: invoice.products.isNotEmpty
                          ? "${Utils().formatCurrency(invoice.totalVatAmount.toString())}₮"
                          : "0₮",
                      secondTextColor: invoiceColor,
                      color: white,
                    ),
                    FieldCard(
                      paddingHorizontal: 15,
                      paddingVertical: 15,
                      color: white,
                      labelText: "Нэмэлтээр",
                      secondText:
                          "${Utils().formatCurrency(invoice.addtionalRowAmount.toString())}₮",
                      secondTextColor: orderColor,
                      arrowColor: orderColor,
                    ),
                    FieldCard(
                      paddingHorizontal: 15,
                      paddingVertical: 15,
                      arrowColor: black,
                      labelText: 'Тооцсон НХАТ',
                      secondText: invoice.products.isNotEmpty
                          ? "${Utils().formatCurrency(invoice.totalTaxAmount.toString())}₮"
                          : "0₮",
                      secondTextColor: invoiceColor,
                      color: white,
                    ),
                    FormTextField(
                      onChanged: (value) {
                        setState(() {
                          shippingAmount = Utils().parseCurrency(value);
                        });
                        invoice.totalAmountInvoice(
                            discountController.text, shippingAmount);
                      },
                      inputFormatters: [
                        CurrencyInputFormatter(),
                      ],
                      textColor: orderColor,
                      name: "shippingAmount",
                      textAlign: TextAlign.end,
                      inputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          padding: const EdgeInsets.only(
                              top: 15, left: 15, bottom: 15),
                          child: const Text(
                            'Хүргэлтийн төлбөр',
                            style: TextStyle(color: dark),
                          ),
                        ),
                        suffixIcon: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: const Text(
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
                        hintStyle: const TextStyle(color: invoiceColor),
                        hintText: 'Дүн оруулна уу',
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    FieldCard(
                      paddingHorizontal: 15,
                      paddingVertical: 15,
                      arrowColor: black,
                      labelText: 'Нийт дүн',
                      secondText:
                          "${Utils().formatCurrency(invoice.amount.toString())}₮",
                      secondTextColor: invoiceColor,
                      color: white,
                    ),
                    FieldCard(
                      paddingHorizontal: 15,
                      paddingVertical: 15,
                      arrowColor: black,
                      labelText: 'Нийт Төлбөр',
                      secondText:
                          "${Utils().formatCurrency(invoice.finalAmount.toString())}₮",
                      secondTextColor: invoiceColor,
                      color: white,
                      fontWeight: FontWeight.w600,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: const Text(
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
                      child: FormTextField(
                        controller: descriptionController,
                        textAlign: TextAlign.left,
                        name: 'description',
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          fillColor: white,
                          filled: true,
                          hintStyle: TextStyle(
                            color: orderColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                Harah.routeName,
                                arguments: HarahArguments(
                                  isNewInvoice: true,
                                  invoice: Invoice(
                                    createdAt: DateTime.now(),
                                    lines: invoice.products,
                                    vatAmount: invoice.totalVatAmount,
                                    taxAmount: invoice.totalTaxAmount,
                                    totalAmount: invoice.totalAmount,
                                    shippingAmount:
                                        double.tryParse(shippingAmount) ?? 0,
                                    discountAmount: double.tryParse(
                                            discountController.text) ??
                                        0,
                                    itemsTotal: invoice.amount,
                                    receiverBusiness:
                                        invoice.newInvoice.partner,
                                    senderBusiness: Invoice(),
                                  ),
                                ),
                              );
                            },
                            child: const Column(
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
                              validateCheck(false);
                            },
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/save.svg',
                                  height: 20,
                                ),
                                const Text(
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
                              validateCheck(true);
                            },
                            child: const Column(
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
                                const Text(
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
      ),
    );
  }

  validateCheck(bool value) {
    final invoice = Provider.of<InvoiceProvider>(context, listen: false);
    if (invoice.products.isEmpty) {
      Scrollable.ensureVisible(productKey.currentContext!,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
    if (invoice.newInvoice.senderBranch?.id == null) {
      Scrollable.ensureVisible(sectorKey.currentContext!,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        sectorValidate = true;
      });
    }
    if (invoice.newInvoice.partner == null) {
      Scrollable.ensureVisible(invoiceKey.currentContext!,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        invoiceValidate = true;
      });
    }
    if (sectorValidate == false &&
        invoiceValidate == false &&
        invoice.products.isNotEmpty) {
      Navigator.of(context).pushNamed(
        PinCheckScreen.routeName,
        arguments: PinCheckScreenArguments(
          onSubmit: () {
            onSubmit(value);
          },
          color: invoiceColor,
          labelText: value ? "Нэхэмжлэл илгээх" : 'Нэхэмжлэх хадгалах',
        ),
      );
    }
  }

  onSubmit(bool value) async {
    final invoice = Provider.of<InvoiceProvider>(context, listen: false);
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      List<Invoice> data = [];
      for (var i = 0; i < invoice.products.length; i++) {
        data.add(
          Invoice(
            variantId: invoice.products[i].variantId ?? invoice.products[i].id,
            quantity: invoice.products[i].quantity,
          ),
        );
      }
      Invoice asdf = Invoice(
        description: descriptionController.text,
        senderBranchId: invoice.newInvoice.senderBranch?.id,
        receiverBranchId: invoice.newInvoice.receiverBranch?.id,
        receiverBusinessId: invoice.newInvoice.partner?.id,
        send: value,
        lines: data,
        additionalLines: invoice.additionalLines,
        discountType: invoice.newInvoice.discountType == "Хувиар"
            ? "PERCENTAGE"
            : invoice.newInvoice.discountType == "Дүнгээр"
                ? "AMOUNT"
                : null,
        discountValue: double.tryParse(discountController.text),
        shippingAmount: double.tryParse(shippingAmount),
      );
      if (widget.data == null) {
        await InvoiceApi().createInvoice(asdf);
      } else {
        await InvoiceApi().updateInvoice(asdf, widget.data!.id!);
      }
      await loading.loading(false);
      showCustomDialog(
        context,
        value == true
            ? 'Нэхэмжлэл амжилттай илгээгдлээ'
            : "Нэхэмжэл амжилттай хадгалагдлаа",
        true,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      loading.loading(false);
    }
  }
}
