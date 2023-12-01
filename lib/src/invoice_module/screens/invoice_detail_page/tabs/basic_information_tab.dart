import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/invoice_additional_line/invoice_additional_line.dart';
import 'package:dehub/components/invoice_product_card/invoice_product_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/harah/harah.dart';
import 'package:dehub/src/invoice_module/screens/invoice_payment/payment_page.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';

class BasicInformationTab extends StatefulWidget {
  final String id;
  BasicInformationTab({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<BasicInformationTab> createState() => _BasicInformationTabState();
}

class _BasicInformationTabState extends State<BasicInformationTab>
    with AfterLayoutMixin {
  Invoice invoice = Invoice();
  General general = General();
  bool isLoading = true;
  User user = User();

  @override
  afterFirstLayout(BuildContext context) async {
    invoice = await InvoiceApi().getInvoice(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  approve(bool confirm) async {
    Invoice approval = Invoice();
    try {
      approval = Invoice(
        confirm: confirm,
        respondText: '',
      );
      await InvoiceApi().respond(widget.id, approval);
      showCustomDialog(
        context,
        "Амжилттай баталлаа",
        true,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      debugPrint('=========err=========');
      debugPrint(e.toString());
      debugPrint('=========err=========');
    }
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: false).general;
    user = Provider.of<UserProvider>(context, listen: false).invoiceMe;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        child: isLoading == true
            ? Container(
                margin: const EdgeInsets.only(top: 20),
                child: Center(
                  child: CircularProgressIndicator(
                    color: invoiceColor,
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Нэхэмжлэх',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Нэхэмжлэл №",
                    secondText: invoice.refCode,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: Color(int.parse(
                            invoiceStatus().color.substring(1, 7),
                            radix: 16) +
                        0xff000000),
                    labelText: "Нэхэмжлэл статус",
                    secondText: invoiceStatus().name,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Төлбөрийн төлөв",
                    secondText: invoicePaymentStatus().name,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Нийт дүн",
                    secondText:
                        Utils().formatCurrency(invoice.totalAmount.toString()),
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Төлсөн дүн",
                    secondText:
                        Utils().formatCurrency(invoice.paidAmount.toString()),
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Төлбөрийн үлдэгдэл",
                    secondText:
                        Utils().formatCurrency(invoice.amountToPay.toString()),
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Төлөх огноо",
                    secondText: invoice.paymentDate == null
                        ? "-"
                        : DateFormat('yyyy-MM-dd').format(invoice.paymentDate!),
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: Color(int.parse(
                            overdueStatus().color.substring(1, 7),
                            radix: 16) +
                        0xff000000),
                    labelText: "Хугацаа хэтрэлт",
                    secondText: overdueStatus().name,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Баталсан огноо",
                    secondText: invoice.confirmedDate == null
                        ? '-'
                        : DateFormat('yyyy-MM-dd')
                            .format(invoice.confirmedDate!),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Худалдан авагч тал',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Татвар төлөгч дугаар",
                    secondText: invoice.receiverBusiness?.regNumber,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Партнер нэр",
                    secondText: invoice.receiverBusiness?.partner?.businessName,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Партнер код",
                    secondText: invoice.receiverBusiness?.partner?.refCode,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Бизнес нэр",
                    secondText: invoice.receiverBusiness?.profileName,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Бизнес код",
                    secondText: invoice.receiverBusiness?.refCode,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Төлбөрийн нөхцөл",
                    secondText: invoice.paymentTerm?.description,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Бизнесийн хаяг",
                    secondText: invoice.receiverBranch?.branchAddress,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Санхүүгийн ажилтан",
                    secondText: invoice.receiverFinUser?.firstName,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Дансны мэдээлэл",
                    secondText:
                        '${invoice.receiverAcc?.number}, ${invoice.receiverAcc?.bankName}',
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "PO дугаар",
                    secondText: invoice.purchaseCode,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Нийлүүлэгч тал',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Татвар төлөгч дугаар",
                    secondText: invoice.senderBusiness?.regNumber,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Партнер нэр",
                    secondText: invoice.senderBusiness?.partner?.businessName,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Партнер код",
                    secondText: invoice.senderBusiness?.partner?.refCode,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Бизнес нэр",
                    secondText: invoice.senderBusiness?.profileName,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Бизнес код",
                    secondText: invoice.senderBusiness?.refCode,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Нэхэмжлэх бичсэн",
                    secondText: invoice.createdAt.toString(),
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Бизнесийн хаяг",
                    secondText: invoice.senderBranch?.branchAddress,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Санхүүгийн ажилтан",
                    secondText: invoice.senderFinUser?.firstName,
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Дансны мэдээлэл",
                    secondText:
                        '${invoice.senderAcc?.number}, ${invoice.senderAcc?.bankName}',
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "SO дугаар",
                    secondText: invoice.salesCode,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      invoice.lines!.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                'БАРАА, ҮЙЛЧИЛГЭЭ',
                                style: TextStyle(
                                  color: grey3,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : SizedBox(),
                      Column(
                        children: invoice.lines!
                            .map(
                              (item) => InvoiceProductCard(
                                readOnly: true,
                                data: item,
                              ),
                            )
                            .toList(),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
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
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        height: 125,
                        color: white,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: grey3.withOpacity(0.3),
                            ),
                          ),
                          child: Text('${invoice.description}'),
                        ),
                      ),
                    ],
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Хөнгөлөлт",
                    secondText: Utils()
                        .formatCurrency(invoice.discountAmount.toString()),
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Тооцсон НӨАТ",
                    secondText:
                        Utils().formatCurrency(invoice.vatAmount.toString()),
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Тооцсон НХАТ",
                    secondText:
                        Utils().formatCurrency(invoice.taxAmount.toString()),
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Хүргэлт төлбөр",
                    secondText: Utils()
                        .formatCurrency(invoice.shippingAmount.toString()),
                  ),
                  FieldCard(
                    color: white,
                    marginHorizontal: 15,
                    marginVertical: 15,
                    secondTextColor: invoiceColor,
                    labelText: "Нийт төлбөр",
                    secondText:
                        Utils().formatCurrency(invoice.totalAmount.toString()),
                  ),
                  invoice.additionalLines!.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            'НЭМЭЛТЭЭР',
                            style: TextStyle(
                              color: grey3,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : SizedBox(),
                  Column(
                    children: invoice.additionalLines!
                        .map(
                          (e) => InvoiceAdditionalLine(
                            data: e,
                          ),
                        )
                        .toList(),
                  ),
                  invoice.attachments!.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            'Хавсралт файл',
                            style: TextStyle(
                              color: grey3,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : SizedBox(),
                  Column(
                    children: invoice.attachments!
                        .map(
                          (e) => Container(
                            color: white,
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Файлын нэр',
                                  style: TextStyle(color: invoiceColor),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: grey3,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  user.currentBusiness?.type == "BUYER"
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 37),
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
                                      isNewInvoice: false,
                                      invoice: invoice,
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
                              invoice.invoiceStatus == "CONFIRMED"
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          InvoicePaymentPage.routeName,
                                          arguments:
                                              InvoicePaymentPageArguments(
                                            data: invoice,
                                            id: invoice.id.toString(),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 3,
                                          ),
                                          SvgPicture.asset(
                                            'assets/svg/tuloh.svg',
                                            height: 14,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            'Төлөх',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 10,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        approve(true);
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Icon(
                                            Icons.approval,
                                            color: white,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            'Батлах',
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/cancel.svg',
                                      height: 17,
                                      width: 17,
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
                              GestureDetector(
                                onTap: () {},
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/cancel.svg',
                                      height: 17,
                                      width: 17,
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
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              Harah.routeName,
                              arguments: HarahArguments(
                                isNewInvoice: false,
                                invoice: invoice,
                              ),
                            );
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 130,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              margin: const EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: black,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.visibility_outlined,
                                    color: white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Харах',
                                    style: TextStyle(color: white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildSheet() => DraggableScrollableSheet(
        minChildSize: 0.5,
        maxChildSize: 1,
        initialChildSize: 1,
        builder: (context, innerBoxIsScrolled) => InvoicePaymentPage(
          id: widget.id,
          data: invoice,
        ),
      );
  overdueStatus() {
    final res = general.overdueStatus!
        .firstWhere((element) => element.code == invoice.overdueStatus);
    return res;
  }

  invoicePaymentStatus() {
    final res = general.invoicePaymentStatus!
        .firstWhere((element) => element.code == invoice.paymentStatus);
    return res;
  }

  invoiceStatus() {
    final res = general.invoiceStatus!
        .firstWhere((element) => element.code == invoice.invoiceStatus);
    return res;
  }
}
