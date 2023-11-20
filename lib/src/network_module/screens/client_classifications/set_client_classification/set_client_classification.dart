import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/business_network.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../models/client_classification.dart';

class SetClientClassificationArguments {
  String id;
  ListenController listenController;
  SetClientClassificationArguments({
    required this.listenController,
    required this.id,
  });
}

class SetClientClassification extends StatefulWidget {
  final ListenController listenController;
  final String id;
  static const routeName = '/SetClientClassification';
  const SetClientClassification({
    Key? key,
    required this.id,
    required this.listenController,
  }) : super(key: key);

  @override
  State<SetClientClassification> createState() =>
      _SetClientClassificationState();
}

class _SetClientClassificationState extends State<SetClientClassification> {
  TextEditingController controller = TextEditingController();
  General general = General();
  String? className;
  String? classId;
  String? rankName;
  String? rankId;
  bool? isSubmit;
  List<ClientClassifications>? classList = [];

  list(bool isParent) {
    if (isParent == true) {
      classList = general.clientClassifications!
          .where((element) => element.isParent == true)
          .toList();
    } else {
      classList = general.clientClassifications!
          .where((element) => element.isParent == false)
          .toList();
    }
  }

  onSubmit() async {
    try {
      setState(() {
        isSubmit = true;
      });
      await BusinessApi().setClientClassification(
        BusinessNetwork(
          businessIds: [widget.id],
          classificationCategoryId: classId,
          classificationPriorityId: rankId,
          classificationDesc: controller.text,
        ),
      );
      showCustomDialog(
        context,
        "Амжилттай хадгаллааа",
        true,
        onPressed: () {
          Navigator.of(context).pop();
          widget.listenController.changeVariable('SetClassification');
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

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).businessGeneral;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: networkColor,
        title: Text(
          'Ангилал, зэрэглэл тохируулах',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          CustomCloseButton(),
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
              marginHorizontal: 15,
              marginVertical: 10,
              onClick: () {
                list(true);
                classification();
              },
              labelText: 'Ангилал',
              secondText: "${className == null ? "-" : className}",
              arrowColor: networkColor,
              secondTextColor: networkColor,
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              onClick: () {
                list(false);
                rank();
              },
              labelText: 'Зэрэглэл',
              secondText: "${rankName == null ? "-" : rankName}",
              arrowColor: networkColor,
              secondTextColor: networkColor,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
              child: Text(
                'Тайлбар',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.all(15),
              child: FormTextField(
                controller: controller,
                textAlign: TextAlign.left,
                name: 'description',
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: grey,
                    ),
                  ),
                  fillColor: white,
                  filled: true,
                  hintStyle: TextStyle(
                    color: grey2,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton(
              isLoading: isSubmit,
              textColor: white,
              labelText: 'Хадгалах',
              labelColor: networkColor,
              onClick: () {
                onSubmit();
              },
            ),
          ],
        ),
      ),
    );
  }

  classification() {
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
                    'Ангилал',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: classList!
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              className = e.name;
                              classId = e.id;
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

  rank() {
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
                    'Ангилал',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: classList!
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              rankName = e.name;
                              rankId = e.id;
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