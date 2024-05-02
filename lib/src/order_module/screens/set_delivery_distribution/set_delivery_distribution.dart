import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class SetDeliveryDistributionArguments {
  Order data;
  ListenController listenController;
  SetDeliveryDistributionArguments({
    required this.data,
    required this.listenController,
  });
}

class SetDeliveryDistribution extends StatefulWidget {
  final Order data;
  final ListenController listenController;
  static const routeName = '/SetDeliveryDistribution';
  const SetDeliveryDistribution({
    super.key,
    required this.listenController,
    required this.data,
  });

  @override
  State<SetDeliveryDistribution> createState() =>
      _SetDeliveryDistributionState();
}

class _SetDeliveryDistributionState extends State<SetDeliveryDistribution>
    with AfterLayoutMixin {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime shipmentDate = DateTime.now();
  General general = General();
  Result staff = Result(count: 0, rows: []);
  String staffName = 'Сонгох';
  bool isLoading = true;
  String? staffId;

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      if (staffId != null) {
        loading.loading(true);
        Order data = Order();
        data.startDate = startDate.toString();
        data.deliveryDate = shipmentDate.toString();
        data.loadingDate = endDate.toString();
        data.staffId = staffId;
        await OrderApi().deliveryManagementAssign(data, widget.data.id!);
        loading.loading(false);
        widget.listenController.changeVariable('asdf');
        showCustomDialog(
          context,
          "Амжилттай хуваариллаа",
          true,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      } else {
        showCustomDialog(
            context, 'Хүргэлт хариуцсан ажилтан сонгоно уу', false);
      }
    } catch (e) {
      loading.loading(false);
    }
  }

  @override
  afterFirstLayout(BuildContext context) async {
    staff = await OrderApi().staffSelect(widget.data.businessId!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).businessGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        elevation: 0,
        leadingWidth: 130,
        leading: const CustomBackButton(color: orderColor),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: orderColor,
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
                      'Харилцагчийн мэдээлэл',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: "Худалдан авагч",
                    secondText:
                        '${widget.data.receiverBusiness?.partner?.businessName}',
                    secondTextColor: orderColor,
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: "Хүлээн авах салбар",
                    secondText:
                        '${widget.data.order?.receiverBranch?.branchAddress}',
                    secondTextColor: orderColor,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: const Text(
                      'Хүргэлт',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: "Эхлэх огноо",
                    secondText: DateFormat('yyyy-MM-dd').format(startDate),
                    secondTextColor: orderColor,
                    onClick: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return Container(
                            color: white,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Болсон',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: black,
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: CupertinoDatePicker(
                                    minimumDate: startDate
                                        .subtract(const Duration(hours: 1)),
                                    initialDateTime: startDate,
                                    mode: CupertinoDatePickerMode.date,
                                    use24hFormat: true,
                                    showDayOfWeek: true,
                                    onDateTimeChanged: (DateTime newDate) {
                                      setState(() {
                                        startDate = newDate;
                                        if (startDate
                                                .difference(endDate)
                                                .inHours >
                                            12) {
                                          setState(() {
                                            endDate = newDate;
                                          });
                                        }
                                        if (startDate
                                                .difference(shipmentDate)
                                                .inHours >
                                            12) {
                                          setState(() {
                                            shipmentDate = newDate;
                                          });
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    arrowColor: orderColor,
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: "Хүлээлгэж өгөх",
                    secondText: DateFormat('yyyy-MM-dd').format(endDate),
                    secondTextColor: orderColor,
                    onClick: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return Container(
                            color: white,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Болсон',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: black,
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: CupertinoDatePicker(
                                    minimumDate: startDate,
                                    initialDateTime: startDate,
                                    mode: CupertinoDatePickerMode.date,
                                    use24hFormat: true,
                                    showDayOfWeek: true,
                                    onDateTimeChanged: (DateTime newDate) {
                                      setState(() => endDate = newDate);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    arrowColor: orderColor,
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: "Ачилт хийх",
                    secondText: DateFormat('yyyy-MM-dd').format(shipmentDate),
                    secondTextColor: orderColor,
                    onClick: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return Container(
                            color: white,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Болсон',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: black,
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: CupertinoDatePicker(
                                    minimumDate: startDate,
                                    initialDateTime: startDate,
                                    mode: CupertinoDatePickerMode.date,
                                    use24hFormat: true,
                                    showDayOfWeek: true,
                                    onDateTimeChanged: (DateTime newDate) {
                                      setState(() => shipmentDate = newDate);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    arrowColor: orderColor,
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: "Хүргэлт хариуцсан",
                    secondText: staffName,
                    secondTextColor: orderColor,
                    onClick: () {
                      show();
                    },
                    arrowColor: orderColor,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        onSubmit();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 15),
                        width: 150,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(color: orderColor),
                          borderRadius: BorderRadius.circular(5),
                          color: white,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/zahialga.svg',
                              colorFilter: const ColorFilter.mode(
                                  orderColor, BlendMode.srcIn),
                              height: 17,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            const Text(
                              'Хуваарилах',
                              style: TextStyle(
                                color: orderColor,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  show() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      useSafeArea: true,
      backgroundColor: white,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25, bottom: 20),
                  child: const Text(
                    'Хариуцсан ажилтан сонгох',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Column(
                  children: staff.rows!
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              staffName = e.lastName != null
                                  ? "${e.lastName} ${e.firstName}"
                                  : e.firstName;
                              staffId = e.id.toString();
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: transparent,
                            child: Row(
                              children: [
                                if (e.avatar != null)
                                  CircleAvatar(
                                    backgroundColor: grey2,
                                    radius: 12,
                                    backgroundImage:
                                        NetworkImage('${e.avatar}'),
                                  ),
                                const SizedBox(
                                  width: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      color: black.withOpacity(0.7),
                                    ),
                                    children: [
                                      TextSpan(text: "${e.lastName} "),
                                      TextSpan(text: e.firstName),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
