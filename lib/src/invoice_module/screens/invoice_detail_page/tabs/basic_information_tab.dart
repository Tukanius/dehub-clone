import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/src/invoice_module/components/invoice_additional_line/invoice_additional_line.dart';
import 'package:dehub/src/invoice_module/components/invoice_product_card/invoice_product_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/invoice_module/screens/new_invoice/harah/harah.dart';
import 'package:dehub/src/invoice_module/screens/invoice_payment/payment_page.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BasicInformationTab extends StatefulWidget {
  final String id;
  final Invoice data;
  const BasicInformationTab({
    super.key,
    required this.data,
    required this.id,
  });
  @override
  State<BasicInformationTab> createState() => _BasicInformationTabState();
}

class _BasicInformationTabState extends State<BasicInformationTab> {
  General general = General();
  User user = User();
  TextEditingController controller = TextEditingController();

  approve(bool confirm) async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    Invoice approval = Invoice();
    try {
      loading.loading(true);
      approval = Invoice(
        confirm: confirm,
        respondText: controller.text,
      );
      await InvoiceApi().respond(widget.id, approval);
      loading.loading(false);
      showCustomDialog(
        context,
        confirm ? "Амжилттай баталлаа" : 'Амжилттай цуцаллаа',
        true,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      loading.loading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).invoiceMe;
    general =
        Provider.of<GeneralProvider>(context, listen: false).invoiceGeneral;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Нэхэмжлэх',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Нэхэмжлэл №",
            secondText: widget.data.refCode,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: Color(
                int.parse(invoiceStatus().color.substring(1, 7), radix: 16) +
                    0xff000000),
            labelText: "Нэхэмжлэл статус",
            secondText: invoiceStatus().name,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Төлбөрийн төлөв",
            secondText: invoicePaymentStatus().name,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Нийт дүн",
            secondText:
                Utils().formatCurrency(widget.data.totalAmount.toString()),
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Төлсөн дүн",
            secondText:
                Utils().formatCurrency(widget.data.paidAmount.toString()),
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Төлбөрийн үлдэгдэл",
            secondText:
                Utils().formatCurrency(widget.data.amountToPay.toString()),
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Төлөх огноо",
            secondText: widget.data.paymentDate == null
                ? "-"
                : DateFormat('yyyy-MM-dd').format(widget.data.paymentDate!),
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: Color(
                int.parse(overdueStatus().color.substring(1, 7), radix: 16) +
                    0xff000000),
            labelText: "Хугацаа хэтрэлт",
            secondText: overdueStatus().name,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Баталсан огноо",
            secondText: widget.data.confirmedDate == null
                ? '-'
                : DateFormat('yyyy-MM-dd').format(widget.data.confirmedDate!),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Худалдан авагч тал',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Татвар төлөгч дугаар",
            secondText: widget.data.receiverBusiness?.regNumber,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Партнер нэр",
            secondText: widget.data.receiverBusiness?.partner?.businessName,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Партнер код",
            secondText: widget.data.receiverBusiness?.partner?.refCode,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Бизнес нэр",
            secondText: widget.data.receiverBusiness?.profileName,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Бизнес код",
            secondText: widget.data.receiverBusiness?.refCode,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Төлбөрийн нөхцөл",
            secondText: widget.data.paymentTerm?.description,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Бизнесийн хаяг",
            secondText: widget.data.receiverBranch?.branchAddress,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Санхүүгийн ажилтан",
            secondText: widget.data.receiverFinUser?.firstName,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Дансны мэдээлэл",
            secondText:
                '${widget.data.receiverAcc?.number}, ${widget.data.receiverAcc?.bankName}',
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "PO дугаар",
            secondText: widget.data.purchaseCode,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: const Text(
              'Нийлүүлэгч тал',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Татвар төлөгч дугаар",
            secondText: widget.data.senderBusiness?.regNumber,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Партнер нэр",
            secondText: widget.data.senderBusiness?.partner?.businessName,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Партнер код",
            secondText: widget.data.senderBusiness?.partner?.refCode,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Бизнес нэр",
            secondText: widget.data.senderBusiness?.profileName,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Бизнес код",
            secondText: widget.data.senderBusiness?.refCode,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Нэхэмжлэх бичсэн",
            secondText: DateFormat('yyyy-MM-dd').format(widget.data.createdAt!),
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Бизнесийн хаяг",
            secondText: widget.data.senderBranch?.branchAddress,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Санхүүгийн ажилтан",
            secondText: widget.data.senderFinUser?.firstName,
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Дансны мэдээлэл",
            secondText:
                '${widget.data.senderAcc?.number}, ${widget.data.senderAcc?.bankName}',
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "SO дугаар",
            secondText: widget.data.salesCode,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.data.lines!.isNotEmpty)
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: const Text(
                    'БАРАА, ҮЙЛЧИЛГЭЭ',
                    style: TextStyle(
                      color: grey3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              Column(
                children: widget.data.lines!
                    .map(
                      (item) => InvoiceProductCard(
                        discountAmount: '',
                        shippingAmount: '',
                        readOnly: true,
                        data: item,
                      ),
                    )
                    .toList(),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                height: 125,
                color: white,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: grey3.withOpacity(0.3),
                    ),
                  ),
                  child: Text('${widget.data.description}'),
                ),
              ),
            ],
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Хөнгөлөлт",
            secondText:
                Utils().formatCurrency(widget.data.discountAmount.toString()),
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Тооцсон НӨАТ",
            secondText:
                Utils().formatCurrency(widget.data.vatAmount.toString()),
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Тооцсон НХАТ",
            secondText:
                Utils().formatCurrency(widget.data.taxAmount.toString()),
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Хүргэлт төлбөр",
            secondText:
                Utils().formatCurrency(widget.data.shippingAmount.toString()),
          ),
          FieldCard(
            color: white,
            paddingHorizontal: 15,
            paddingVertical: 15,
            secondTextColor: invoiceColor,
            labelText: "Нийт төлбөр",
            secondText:
                Utils().formatCurrency(widget.data.totalAmount.toString()),
          ),
          if (widget.data.additionalLines!.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                'НЭМЭЛТЭЭР',
                style: TextStyle(
                  color: grey3,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          Column(
            children: widget.data.additionalLines!
                .map(
                  (e) => InvoiceAdditionalLine(
                    newInvoice: false,
                    discountAmount: '',
                    shippingAmount: '',
                    index: widget.data.additionalLines!.indexOf(e),
                    data: e,
                  ),
                )
                .toList(),
          ),
          if (widget.data.attachments!.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                'Хавсралт файл',
                style: TextStyle(
                  color: grey3,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          Column(
            children: widget.data.attachments!
                .map(
                  (e) => Container(
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: const Row(
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
          const SizedBox(
            height: 70,
          ),
          if (Permission().check(user, "INV_RES"))
            user.currentBusiness?.type == "BUYER"
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              Harah.routeName,
                              arguments: HarahArguments(
                                isNewInvoice: false,
                                invoice: widget.data,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            color: transparent,
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
                        ),
                        widget.data.invoiceStatus == "CONFIRMED"
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    InvoicePaymentPage.routeName,
                                    arguments: InvoicePaymentPageArguments(
                                      data: widget.data,
                                      id: widget.data.id.toString(),
                                    ),
                                  );
                                },
                                child: Container(
                                  color: transparent,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      SvgPicture.asset(
                                        'assets/svg/tuloh.svg',
                                        height: 14,
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text(
                                        'Төлөх',
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 10,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  approve(true);
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  color: transparent,
                                  child: const Column(
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
                              ),
                        GestureDetector(
                          onTap: () {
                            cancel();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            color: transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/cancel.svg',
                                  height: 17,
                                  width: 17,
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
                          invoice: widget.data,
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
                        child: const Row(
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
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget buildSheet() => DraggableScrollableSheet(
        minChildSize: 0.5,
        maxChildSize: 1,
        initialChildSize: 1,
        builder: (context, innerBoxIsScrolled) => InvoicePaymentPage(
          id: widget.id,
          data: widget.data,
        ),
      );
  overdueStatus() {
    final res = general.overdueStatus!
        .firstWhere((element) => element.code == widget.data.overdueStatus);
    return res;
  }

  invoicePaymentStatus() {
    final res = general.invoicePaymentStatus!
        .firstWhere((element) => element.code == widget.data.paymentStatus);
    return res;
  }

  invoiceStatus() {
    final res = general.invoiceStatus!
        .firstWhere((element) => element.code == widget.data.invoiceStatus);
    return res;
  }

  cancel() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 20, bottom: 50),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Тайлбар оруулна уу',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: grey2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                onClick: () {
                  Navigator.of(ctx).pop();
                  approve(false);
                },
                labelText: 'Цуцлах',
                labelColor: invoiceColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
