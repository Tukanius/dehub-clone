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
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class SetClientStaffArguments {
  String id;
  ListenController listenController;
  SetClientStaffArguments({
    required this.listenController,
    required this.id,
  });
}

class SetClientStaff extends StatefulWidget {
  final String id;
  final ListenController listenController;
  static const routeName = '/SetClientStaff';
  const SetClientStaff({
    Key? key,
    required this.id,
    required this.listenController,
  }) : super(key: key);

  @override
  State<SetClientStaff> createState() => _SetClientStaffState();
}

class _SetClientStaffState extends State<SetClientStaff> {
  TextEditingController textController = TextEditingController();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  String? clientStaff;
  String? coClientStaff;
  String? clientStaffId;
  String? coClientStaffId;
  General general = General();
  bool isSubmit = false;

  onSubmit() async {
    try {
      setState(() {
        isSubmit = true;
      });
      await BusinessApi().setClientStaff(
        BusinessNetwork(
          businessIds: [widget.id],
          businessStaffId: clientStaffId,
          businessStaff2Id: coClientStaffId,
          businessStaffDesc: textController.text,
        ),
      );
      showCustomDialog(
        context,
        "Амжилттай хадгаллаа",
        true,
        onPressed: () {
          widget.listenController.changeVariable('setClientStaff');
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

  @override
  Widget build(BuildContext context) {
    print(clientStaff);
    print(coClientStaff);
    general =
        Provider.of<GeneralProvider>(context, listen: true).businessGeneral;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: networkColor,
        title: Text(
          'Ажилтан хариуцуулах',
          style: TextStyle(
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
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Хариуцсан",
              onClick: () {
                show();
              },
              arrowColor: networkColor,
              secondText: "${clientStaff == null ? '-' : clientStaff}",
              secondTextColor: networkColor,
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Орлох ажилтан",
              onClick: () {
                coStaff();
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
              labelColor: clientStaff == null
                  ? networkColor.withOpacity(0.3)
                  : networkColor,
              isLoading: isSubmit,
              onClick: () {
                clientStaff == null ? () {} : onSubmit();
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
                  children: general.staffs!
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              clientStaff = "${e.lastName} ${e.firstName}";
                              clientStaffId = e.id.toString();
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: transparent,
                            child: Row(
                              children: [
                                e.avatar == null
                                    ? CircleAvatar(
                                        radius: 12,
                                        backgroundImage:
                                            AssetImage('images/map.jpg'),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: grey2,
                                        radius: 12,
                                        backgroundImage:
                                            NetworkImage('${e.avatar}'),
                                      ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${e.lastName} ${e.firstName}',
                                  style: TextStyle(
                                    color: black.withOpacity(0.7),
                                  ),
                                )
                              ],
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

  coStaff() {
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
                    'Орлох ажилтан сонгох',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Column(
                  children: general.staffs!
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              coClientStaff = "${e.lastName} ${e.firstName}";
                              coClientStaffId = e.id.toString();
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: transparent,
                            child: Row(
                              children: [
                                e.avatar == null
                                    ? CircleAvatar(
                                        radius: 12,
                                        backgroundImage:
                                            AssetImage('images/map.jpg'),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: grey2,
                                        radius: 12,
                                        backgroundImage:
                                            NetworkImage('${e.avatar}'),
                                      ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${e.lastName} ${e.firstName}',
                                  style: TextStyle(
                                    color: black.withOpacity(0.7),
                                  ),
                                )
                              ],
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