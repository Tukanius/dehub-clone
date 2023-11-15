import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/invoice_additional_line/invoice_additional_line.dart';
import 'package:dehub/components/invoice_product_card/add_product_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/new_invoice/add_product/add_product.dart';
import 'package:dehub/screens/new_invoice/add_row/invoice_add_row.dart';
import 'package:dehub/screens/new_invoice/customer_choose/customer_choose.dart';
import 'package:dehub/screens/new_invoice/harah/harah.dart';
import 'package:dehub/screens/new_invoice/sector-choose/sector-choose.dart';
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
  static const routeName = '/NewInvoice';
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
  double shippingAmount = 0;
  double discountAmount = 0;
  var productKey = GlobalKey();
  var sectorKey = GlobalKey();
  var invoiceKey = GlobalKey();
  bool invoiceValidate = false;
  bool sectorValidate = false;
  bool productValidate = false;
  Map<String, List<Invoice>> duplicatedItems = {};

  List<String> list = <String>[
    "Хувиар",
    "Дүнгээр",
  ];

  @override
  afterFirstLayout(BuildContext context) {}

  @override
  void initState() {
    listenController.addListener(() {
      setState(() {
        invoice = listenController.invoice!;
        invoiceValidate = false;
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
        productValidate = false;
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
        sectorValidate = false;
      });
    });
    addRowController.addListener(() {
      setState(() {
        additionalRow = addRowController.invoiceAdditionalRow!;
        additionalRowList.add(additionalRow);
        double addrow = additionalRowList.fold(0,
            (previousValue, element) => previousValue + element.totalAmount!);
        additionalRowAmount = addrow.roundToDouble();
        finalAmount = amount + vatAmount + taxAmount + additionalRowAmount;
      });
    });
    super.initState();
  }

  validateCheck(bool value) {
    if (data.isEmpty) {
      Scrollable.ensureVisible(productKey.currentContext!,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        productValidate = true;
      });
    }
    if (sectorInvoice.name == null) {
      Scrollable.ensureVisible(sectorKey.currentContext!,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        sectorValidate = true;
      });
    }
    if (invoice.partner == null) {
      Scrollable.ensureVisible(invoiceKey.currentContext!,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        invoiceValidate = true;
      });
    }
    if (productValidate == false &&
        sectorValidate == false &&
        invoiceValidate == false) {
      onSubmit(value);
    }
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
          true,
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

  updateTotalAmount() {
    setState(() {
      finalAmount = totalAmount;
      finalAmount =
          finalAmount + (shippingAmount - discountAmount) + additionalRowAmount;
    });
  }

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
                                  Container(
                                    child: Icon(
                                      Icons.perm_contact_cal_outlined,
                                      color: invoiceValidate == true
                                          ? red
                                          : invoiceColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  invoice.partner?.businessName == null
                                      ? Text(
                                          'Харилцагч сонгох',
                                          style: TextStyle(
                                              color: invoiceValidate == true
                                                  ? red
                                                  : invoiceColor),
                                        )
                                      : Text(
                                          '${invoice.partner?.businessName}',
                                          style: TextStyle(color: invoiceColor),
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
                        marginHorizontal: 15,
                        marginVertical: 15,
                        arrowColor: black,
                        onClick: () {},
                        labelText: 'Хүргэлтийн хаяг',
                        secondText: partnerInvoice.name != null
                            ? "${partnerInvoice.name}"
                            : '-',
                        secondTextColor: invoiceColor,
                        color: white,
                      ),
                      FieldCard(
                        marginHorizontal: 15,
                        marginVertical: 15,
                        arrowColor: black,
                        onClick: () {},
                        labelText: 'Нэхэмжлэх илгээх',
                        secondText: invoice.partnerName != null
                            ? "${invoice.partnerName}"
                            : '-',
                        secondTextColor: invoiceColor,
                        color: white,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        child: Text(
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
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                      FieldCard(
                        marginHorizontal: 15,
                        marginVertical: 15,
                        arrowColor: black,
                        onClick: () {},
                        labelText: 'Партнерийн нэр',
                        secondText: user.user?.currentBusiness?.partnerName,
                        secondTextColor: invoiceColor,
                        color: white,
                      ),
                      FieldCard(
                        key: sectorKey,
                        validate: sectorValidate,
                        marginHorizontal: 15,
                        marginVertical: 15,
                        arrowColor: black,
                        onClick: () {
                          Navigator.of(context).pushNamed(
                            SectorChoose.routeName,
                            arguments: SectorChooseArguments(
                                sectorListenController: sectorListenController),
                          );
                        },
                        labelText: 'Салбарын нэр',
                        secondText: sectorInvoice.name != null
                            ? "${sectorInvoice.name}"
                            : "Салбар сонгох",
                        secondTextColor: invoiceColor,
                        color: white,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        child: Text(
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
                            }
                          }
                        },
                        child: Container(
                          key: productKey,
                          decoration: BoxDecoration(
                            color: white,
                            border: Border.all(
                                color:
                                    productValidate == true ? red : transparent,
                                width: productValidate == true ? 1 : 0),
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.download_for_offline_outlined,
                                      color: productValidate == true
                                          ? red
                                          : invoiceColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Бараа нэмэх',
                                    style: TextStyle(
                                        color: productValidate == true
                                            ? red
                                            : invoiceColor),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: productValidate == true ? red : black,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: inventory
                            .map(
                              (item) => AddProductCard(
                                readOnly: false,
                                closeClick: () {
                                  setState(() {
                                    inventory.removeWhere(
                                        (element) => element.id == item.id);
                                    data.removeWhere(
                                        (element) => element.id == item.id);
                                  });
                                  if (data.isEmpty) {
                                    setState(() {
                                      productValidate = true;
                                    });
                                  }
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
                                size: 14,
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
                                  size: 14,
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
                        textColor: invoiceColor,
                        textAlign: TextAlign.end,
                        readOnly: dropdownValue == "Сонгох",
                        onChanged: (value) {
                          if (dropdownValue == "Хувиар") {
                            setState(() {
                              discountAmount = totalAmount /
                                  100 *
                                  (double.tryParse(value.toString()) ?? 0);
                              print(discountAmount);
                            });
                          } else {
                            setState(() {
                              discountAmount =
                                  double.tryParse(value.toString()) ?? 0;
                            });
                          }
                          updateTotalAmount();
                        },
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
                      FieldCard(
                        marginHorizontal: 15,
                        marginVertical: 15,
                        arrowColor: black,
                        labelText: 'Тооцсон НӨАТ',
                        secondText: inventory.isNotEmpty
                            ? "${Utils().formatCurrency(vatAmount.toString())}₮"
                            : "0₮",
                        secondTextColor: invoiceColor,
                        color: white,
                      ),
                      FieldCard(
                        marginHorizontal: 15,
                        marginVertical: 15,
                        arrowColor: black,
                        labelText: 'Тооцсон НХАТ',
                        secondText: inventory.isNotEmpty
                            ? "${Utils().formatCurrency(taxAmount.toString())}₮"
                            : "0₮",
                        secondTextColor: invoiceColor,
                        color: white,
                      ),
                      FormTextField(
                        onChanged: (value) {
                          setState(() {
                            shippingAmount =
                                double.tryParse(value.toString()) ?? 0;
                          });
                          updateTotalAmount();
                        },
                        textColor: orderColor,
                        name: "shippingAmount",
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
                      FieldCard(
                        marginHorizontal: 15,
                        marginVertical: 15,
                        arrowColor: black,
                        labelText: 'Тооцсон НХАТ',
                        secondText: inventory.isNotEmpty
                            ? "${Utils().formatCurrency(additionalRowAmount.toString())}₮"
                            : "0₮",
                        secondTextColor: invoiceColor,
                        color: white,
                      ),
                      FieldCard(
                        marginHorizontal: 15,
                        marginVertical: 15,
                        arrowColor: black,
                        labelText: 'Нийт Төлбөр',
                        secondText:
                            inventory.isNotEmpty ? "${finalAmount}" : "0₮",
                        secondTextColor: invoiceColor,
                        color: white,
                        fontWeight: FontWeight.w600,
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
                                        validateCheck(false);
                                      }
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
                                      if (isSubmit == false) {
                                        validateCheck(true);
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
