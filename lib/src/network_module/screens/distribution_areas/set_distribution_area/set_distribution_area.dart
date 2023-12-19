import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/business_network.dart';
import 'package:dehub/models/distribution_areas.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class SetDistributionAreaArguments {
  String id;
  ListenController listenController;
  SetDistributionAreaArguments({
    required this.listenController,
    required this.id,
  });
}

class SetDistributionArea extends StatefulWidget {
  final String id;
  final ListenController listenController;
  static const routeName = '/SetDistributionArea';
  const SetDistributionArea({
    Key? key,
    required this.id,
    required this.listenController,
  }) : super(key: key);

  @override
  State<SetDistributionArea> createState() => _SetDistributionAreaState();
}

class _SetDistributionAreaState extends State<SetDistributionArea> {
  TextEditingController textController = TextEditingController();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  String? distributionArea;
  String? coClientStaff;
  String? areaRegionId;
  String? coClientStaffId;
  General general = General();
  List<DistributionAreas> parentList = [];
  bool isSubmit = false;

  onSubmit() async {
    try {
      setState(() {
        isSubmit = true;
      });
      await BusinessApi().setDistributionArea(
        BusinessNetwork(
          businessIds: [widget.id],
          areaRegionId: areaRegionId,
          areaDirectionId: coClientStaffId,
          areaDesc: textController.text,
        ),
      );
      showCustomDialog(
        context,
        "Амжилттай хадгаллаа",
        true,
        onPressed: () {
          widget.listenController.changeVariable('SetDistributionArea');
          Navigator.of(context).pop();
        },
      );
      setState(() {
        isSubmit = false;
      });
    } catch (e) {
      setState(() {
        isSubmit = false;
      });
    }
  }

  dArea(bool isParent) {
    if (isParent == true) {
      parentList = general.distributionAreas!
          .where((element) => element.isParent == true)
          .toList();
    } else {
      parentList = general.distributionAreas!
          .where((element) => element.isParent == false)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).businessGeneral;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: networkColor,
        surfaceTintColor: networkColor,
        title: Text(
          'Чиглэл, бүсчлэл тохируулах',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CustomCloseButton(
            color: networkColor,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            FieldCard(
              color: white,
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: "Бүсийн нэр",
              onClick: () {
                dArea(true);
                show();
              },
              arrowColor: networkColor,
              secondText:
                  "${distributionArea == null ? '-' : distributionArea}",
              secondTextColor: networkColor,
            ),
            FieldCard(
              color: white,
              paddingHorizontal: 15,
              paddingVertical: 10,
              labelText: "Чиглэлийн нэр",
              onClick: () {
                dArea(false);
                area();
              },
              arrowColor: networkColor,
              secondText: "${coClientStaff == null ? '-' : coClientStaff}",
              secondTextColor: networkColor,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
              child: Text(
                'Тайлбар',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: grey3,
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
                    hintText: 'Энд оруулна уу',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: grey),
                    ),
                    fillColor: white,
                    filled: true,
                    hintStyle: TextStyle(
                      color: grey2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton(
              labelText: "Хадгалах",
              labelColor: distributionArea == null
                  ? networkColor.withOpacity(0.3)
                  : networkColor,
              isLoading: isSubmit,
              onClick: () {
                distributionArea == null ? () {} : onSubmit();
              },
            ),
          ],
        ),
      ),
    );
  }

  show() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
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
                  child: Text(
                    'Хариуцсан ажилтан сонгох',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: parentList
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              distributionArea = "${e.name}";
                              areaRegionId = e.id.toString();
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              color: transparent,
                              child: Text(
                                '${e.name}',
                                style: TextStyle(
                                  color: black.withOpacity(0.7),
                                ),
                              )),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  area() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
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
                  child: Text(
                    'Хариуцсан ажилтан сонгох',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: parentList
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              coClientStaff = "${e.name}";
                              coClientStaffId = e.id.toString();
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: transparent,
                            child: Text(
                              '${e.name}',
                              style: TextStyle(
                                color: black.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(
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
