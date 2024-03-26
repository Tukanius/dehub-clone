import 'dart:io';
import 'package:after_layout/after_layout.dart';
import 'package:dehub/api/partner_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/selection_field/selection_field.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:provider/provider.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/src/partner_module/screens/update_business/sheets/select_business_sector.dart';
import 'package:dehub/src/partner_module/screens/update_business/sheets/select_business_sub_sector.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainInformation extends StatefulWidget {
  final TabController tabController;
  final Partner? data;
  final ListenController listenController;
  const MainInformation({
    super.key,
    this.data,
    required this.listenController,
    required this.tabController,
  });

  @override
  State<MainInformation> createState() => _MainInformationState();
}

class _MainInformationState extends State<MainInformation>
    with AfterLayoutMixin {
  General general = General();
  bool isDefault = false;
  int purchaseTypeRadio = 0;
  int productCategoryTypeRadio = 1;
  int serviceCategoryTypeRadio = 1;
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    source.clearData();
    if (widget.data != null) {
      if (widget.data?.businessSector != null) {
        source.selectBusinessSector(widget.data!.businessSector!.id!,
            widget.data!.businessSector!.name!);
      }
      if (widget.data?.businessSubSector != null) {
        source.selectBusinessSubSector(widget.data!.businessSubSector!.id!,
            widget.data!.businessSubSector!.name!);
      }
      if (widget.data?.purchaseType != null) {
        purchaseTypeRadio = general.purchaseTypes!.indexWhere(
            (element) => element.code == widget.data!.purchaseType!);
      }
      if ((purchaseTypeRadio == 0 || purchaseTypeRadio == 2) &&
          widget.data?.productCategoryType != null) {
        productCategoryTypeRadio = general.productCategoryTypes!.indexWhere(
            (element) => element.code == widget.data!.productCategoryType!);
      }
      if ((purchaseTypeRadio == 1 ||
          purchaseTypeRadio == 2 && widget.data?.serviceCategoryType != null)) {
        serviceCategoryTypeRadio = general.serviceCategoryTypes!.indexWhere(
            (element) => element.code == widget.data!.serviceCategoryType!);
      }
      isDefault = widget.data!.isDefault!;
    }
    setState(() {
      isLoading = false;
    });
  }

  onSubmit(bool next) async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      Partner source =
          Provider.of<PartnerProvider>(context, listen: false).partner;
      Partner data = Partner();
      data.businessSectorId = source.businessSectorId;
      data.businessSubSectorId = source.businessSubSectorId;
      data.purchaseType = general.purchaseTypes?[purchaseTypeRadio].code;
      data.productCategoryType =
          general.productCategoryTypes?[productCategoryTypeRadio].code;
      data.serviceCategoryType =
          general.serviceCategoryTypes?[serviceCategoryTypeRadio].code;
      loading.loading(true);
      await PartnerApi().updateBusiness(data, widget.data!.id!);
      widget.listenController.changeVariable('business');
      if (next == true) {
        setState(() {
          widget.tabController.index = 1;
        });
      } else {
        Navigator.of(context).pop();
      }
      loading.loading(false);
    } catch (e) {
      loading.loading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<PartnerProvider>(context, listen: true);
    general =
        Provider.of<GeneralProvider>(context, listen: true).partnerGeneral;
    return isLoading == true
        ? const SizedBox()
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectionField(
                    hintText: 'Нийлүүлэлт хийх сектор',
                    labelText: 'Нийлүүлэлт хийх сектор',
                    value: source.partner.businessSectorName,
                    onClick: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const SelectBusinessSector(),
                      );
                    },
                  ),
                  SelectionField(
                    hintText: 'Дэд сектор',
                    labelText: 'Дэд сектор',
                    value: source.partner.businessSubSectorName,
                    onClick: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const SelectBusinessSubSector(),
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Text('Үндсэн эсэх:   '),
                        if (Platform.isIOS)
                          CupertinoSwitch(
                            activeColor: partnerColor,
                            value: isDefault,
                            onChanged: (value) {
                              setState(() {
                                isDefault = value;
                              });
                            },
                          )
                        else
                          Switch(
                            activeColor: partnerColor,
                            thumbColor: const MaterialStatePropertyAll(white),
                            value: isDefault,
                            onChanged: (value) {
                              setState(() {
                                isDefault = value;
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Нийлүүлэлтийн төрөл: '),
                  ),
                  Column(
                    children: general.purchaseTypes!
                        .map(
                          (e) => Material(
                            color: white,
                            child: RadioListTile(
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              title: Text(
                                '${e.name}',
                                style:
                                    const TextStyle(color: dark, fontSize: 14),
                              ),
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => partnerColor),
                              value: general.purchaseTypes!.indexOf(e),
                              groupValue: purchaseTypeRadio,
                              onChanged: (value) {
                                setState(() {
                                  purchaseTypeRadio = value!;
                                });
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  if (purchaseTypeRadio == 0 || purchaseTypeRadio == 2)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: const Text('Бараа, бүтээгдэхүүний категори: '),
                        ),
                        Column(
                          children: general.productCategoryTypes!
                              .map(
                                (e) => Material(
                                  color: white,
                                  child: RadioListTile(
                                    visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    title: Text(
                                      '${e.name}',
                                      style: const TextStyle(
                                          color: dark, fontSize: 14),
                                    ),
                                    fillColor: MaterialStateColor.resolveWith(
                                        (states) => partnerColor),
                                    value: general.productCategoryTypes!
                                        .indexOf(e),
                                    groupValue: productCategoryTypeRadio,
                                    onChanged: (value) {
                                      setState(() {
                                        productCategoryTypeRadio = value!;
                                      });
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  if (productCategoryTypeRadio == 0)
                    SelectionField(
                      hintText: 'Барааны категори сонгох',
                      onClick: () {},
                    ),
                  if (purchaseTypeRadio == 1 || purchaseTypeRadio == 2)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: const Text('Ажил, үйлчилгээний категори: '),
                        ),
                        Column(
                          children: general.serviceCategoryTypes!
                              .map(
                                (e) => Material(
                                  color: white,
                                  child: RadioListTile(
                                    visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    title: Text(
                                      '${e.name}',
                                      style: const TextStyle(
                                          color: dark, fontSize: 14),
                                    ),
                                    fillColor: MaterialStateColor.resolveWith(
                                        (states) => partnerColor),
                                    value: general.serviceCategoryTypes!
                                        .indexOf(e),
                                    groupValue: serviceCategoryTypeRadio,
                                    onChanged: (value) {
                                      setState(() {
                                        serviceCategoryTypeRadio = value!;
                                      });
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  if (serviceCategoryTypeRadio == 0)
                    SelectionField(
                      hintText: 'Ажил, үйлчилгээний категори сонгох',
                      onClick: () {},
                    ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: CustomButton(
                          onClick: () {
                            onSubmit(false);
                          },
                          labelColor: partnerColor,
                          labelText: 'Хадгалах',
                          textColor: white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomButton(
                          onClick: () {
                            onSubmit(true);
                          },
                          borderColor: partnerColor,
                          labelText: 'Үргэлжлүүлэх',
                          textColor: partnerColor,
                          labelColor: white,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          );
  }
}
