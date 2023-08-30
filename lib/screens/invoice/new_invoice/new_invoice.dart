import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/invoice_product_card/add_product_card.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/invoice/new_invoice/add_product/add_product.dart';
import 'package:dehub/screens/invoice/new_invoice/customer_choose/customer_choose.dart';
import 'package:dehub/screens/invoice/new_invoice/harah/harah.dart';
import 'package:dehub/screens/invoice/new_invoice/sector-choose/sector-choose.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:moment_dart/moment_dart.dart';

class NewInvoice extends StatefulWidget {
  static const routeName = '/newinvoice';
  const NewInvoice({
    Key? key,
  }) : super(key: key);

  @override
  State<NewInvoice> createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  ListenController listenController = ListenController();
  ListenController partnerListenController = ListenController();
  ListenController goodsListenController = ListenController();
  ListenController sectorListenController = ListenController();
  TextEditingController textController = TextEditingController();
  Invoice invoice = Invoice();
  Invoice createInvoice = Invoice();
  Invoice partnerInvoice = Invoice();
  Invoice sectorInvoice = Invoice();
  Invoice goodsInvoice = Invoice();
  bool isLoading = false;
  List<Invoice> inventory = [];
  List<Invoice> data = [];
  int quantity = 0;
  bool isSubmit = false;
  Partner user = Partner();
  String dropdownValue = "Сонгох";
  List<Invoice> newList = [];
  bool? el;

  List<String> list = <String>[
    "Хувиар",
    "Дүнгээр",
  ];

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
    super.initState();
  }

  onSubmit(bool value) async {
    setState(() {
      isSubmit = true;
    });
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
      createInvoice.items = data;
      createInvoice.description = textController.text;
      await InvoiceApi().createInvoice(createInvoice);
      Navigator.of(context).pop();
    }
    setState(() {
      isSubmit = false;
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
                        margin: const EdgeInsets.only(left: 15, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                '${user.partner?.refCode}',
                                style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Text(
                                'Үүссэн: ${Moment.parse(DateTime.now().toString()).format('YYYY-MM-DD HH:mm')}',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
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
                          padding: const EdgeInsets.only(left: 20),
                          color: white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              style: TextStyle(
                                                  color: invoiceColor),
                                            )
                                          : Text(
                                              '${invoice.partner?.businessName}',
                                              style: TextStyle(
                                                  color: invoiceColor),
                                            )
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 12,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Text(
                                              '${partnerInvoice.name}',
                                              style: TextStyle(
                                                  color: invoiceColor),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 12,
                                              ),
                                            ),
                                          ],
                                        )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      'Нэхэмжлэх илгээх',
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      invoice.partnerName == null
                                          ? Text('-')
                                          : Text(
                                              invoice.partnerName.toString(),
                                              style: TextStyle(
                                                color: invoiceColor,
                                              ),
                                            ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Container(
                              //       child: Text(
                              //         'Нэхэмжлэх статус',
                              //       ),
                              //     ),
                              //     Row(
                              //       children: [
                              //         Text(
                              //           'Үүссэн',
                              //           style: TextStyle(color: invoiceColor),
                              //         ),
                              //         IconButton(
                              //           onPressed: () {},
                              //           icon: Icon(
                              //             Icons.arrow_forward_ios,
                              //             size: 12,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Container(
                              //       child: Text(
                              //         'Баталсан',
                              //       ),
                              //     ),
                              //     Row(
                              //       children: [
                              //         Text('-'),
                              //         IconButton(
                              //           onPressed: () {},
                              //           icon: Icon(
                              //             Icons.arrow_forward_ios,
                              //             size: 12,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),
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
                        padding: const EdgeInsets.only(left: 20),
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
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        color: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'Партнерийн нэр',
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${user.user?.currentBusiness?.partnerName}',
                                  style: TextStyle(color: invoiceColor),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                  ),
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
                          padding: const EdgeInsets.only(left: 20),
                          color: white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  'Салбарын нэр',
                                ),
                              ),
                              Row(
                                children: [
                                  sectorInvoice.name == null
                                      ? Text(
                                          'Салбар сонгох',
                                          style: TextStyle(color: invoiceColor),
                                        )
                                      : Text(
                                          '${sectorInvoice.name}',
                                          style: TextStyle(color: invoiceColor),
                                        ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                    ),
                                  ),
                                ],
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
                          'ЗАХИАЛГА',
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
                        padding: const EdgeInsets.only(left: 20),
                        color: white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'PO дугаар',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '-',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'SO дугаар',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '-',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Борлуулагч',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '-',
                                      style: TextStyle(color: buttonColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Row(
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
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // goodsValidate == false
                      //     ? SizedBox()
                      //     : Container(
                      //         child: Text(
                      //           'Бараа сонгоно уу',
                      //           style: TextStyle(color: red),
                      //         ),
                      //       ),
                      Column(
                        children: inventory
                            .map(
                              (item) => AddProductCard(
                                hasCount: true,
                                closeClick: () {
                                  setState(() {
                                    inventory.removeWhere((element) =>
                                        element.variantId == item.variantId);
                                    data.removeWhere((element) =>
                                        element.variantId == item.variantId);
                                  });
                                },
                                index: inventory.indexOf(item),
                                data: item,
                                isCheck: false,
                                onClick: () {
                                  print(item.quantity);
                                },
                                color: invoiceColor,
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Text(
                          'НИЙТ ТӨЛБӨР',
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
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        color: white,
                        child: Column(
                          children: [
                            Row(
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                                alignment:
                                                    Alignment.centerRight,
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
                            FormTextField(
                              maxLenght: dropdownValue == 'Хувиар'
                                  ? 2
                                  : dropdownValue == "Сонгох"
                                      ? 1
                                      : null,
                              showCounter: false,
                              textColor: networkColor,
                              textAlign: TextAlign.end,
                              name: 'name',
                              inputType: TextInputType.number,
                              decoration: InputDecoration(
                                prefixIcon: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
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
                                    horizontal: 15, vertical: 15),
                                hintStyle: TextStyle(color: invoiceColor),
                                hintText: 'Дүн оруулна уу',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Тооцсон НӨАТ',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(
                                        '00.00₮',
                                        style: TextStyle(color: invoiceColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Тооцсон НХАТ',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(
                                        '00.00₮',
                                        style: TextStyle(color: invoiceColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Хөнгөлөлт',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Нэмэх',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
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
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(
                                        '00.00₮',
                                        style: TextStyle(
                                          color: invoiceColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
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
                          'Нэмэлт Тэмдэглэл',
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
                      FormBuilder(
                        key: fbKey,
                        child: FormTextField(
                          controller: textController,
                          name: 'description',
                          decoration: InputDecoration(
                            fillColor: white,
                            hintText: 'Тайлбар оруулна уу',
                            hintStyle:
                                TextStyle(color: invoiceColor, fontSize: 14),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                          ),
                          validators: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: "Заавал оруулна"),
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Text(
                          'ТӨЛБӨРИЙН МЭДЭЭЛЭЛ',
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
                        padding: const EdgeInsets.only(left: 20),
                        color: white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Нэхэмжлэх үлдэгдэл',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '00.00 ₮',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Төлбөл зохих',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '00.00 ₮',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Төлөх хугацаа',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '2021-12-02',
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Төлбөрийн төлөв',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text('Төлөлт хүлээж буй'),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Нэхэмжлэх дүн',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '00.00 ₮',
                                      style: TextStyle(color: invoiceColor),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Нэхэмжлэх төлөх',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '2021-12-02',
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Хугацаа хэтрэлт',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Хэвийн',
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  Harah.routeName,
                                  arguments: HarahArguments(
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
                                    'images/save.svg',
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
                                if (data == []) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: invoiceColor,
                                      shape: StadiumBorder(),
                                      content: Center(
                                        child: Text('Бараа сонгоно уу'),
                                      ),
                                    ),
                                  );
                                } else {
                                  onSubmit(true);
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
                                    'images/cancel.svg',
                                    height: 20,
                                  ),
                                  Text(
                                    'Цуцлах',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 10,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
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
