import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/business_network.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/network_module/screens/distribution_areas/set_distribution_area/set_distribution_area.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class DistributionAreaDetailArguments {
  String id;
  ListenController listenController;
  DistributionAreaDetailArguments({
    required this.id,
    required this.listenController,
  });
}

class DistributionAreaDetail extends StatefulWidget {
  static const routeName = '/DistributionAreaDetail';
  final String id;
  final ListenController listenController;
  const DistributionAreaDetail({
    super.key,
    required this.listenController,
    required this.id,
  });

  @override
  State<DistributionAreaDetail> createState() => _DistributionAreaDetailState();
}

class _DistributionAreaDetailState extends State<DistributionAreaDetail>
    with AfterLayoutMixin {
  TextEditingController textController = TextEditingController();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  BusinessNetwork business = BusinessNetwork();
  bool isLoading = true;
  User user = User();

  @override
  afterFirstLayout(BuildContext context) async {
    business = await BusinessApi().networkGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    widget.listenController.addListener(() async {
      setState(() {
        isLoading = true;
      });
      business = await BusinessApi().networkGet(widget.id);
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).businessUser;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        leadingWidth: 150,
        leading: const CustomBackButton(color: networkColor),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: networkColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(left: 15, top: 15, bottom: 20),
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
                    labelText: "Партнерийн нэр",
                    secondText: '${business.partnerName}',
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: "Партнер код",
                    secondText: '${business.partner?.refCode}',
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: "Бизнесийн нэр",
                    secondText: '${business.partner?.businessName}',
                    secondTextColor: networkColor,
                  ),
                  FieldCard(
                    color: white,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: "Бизнес код",
                    secondText: '${business.refCode}',
                    secondTextColor: networkColor,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Статус',
                          style: TextStyle(
                            color: dark,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xff71717A).withOpacity(0.1),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          child: const Text(
                            'Идэвхтэй',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: const Text(
                      'Бүс, чиглэл тохируулах',
                      style: TextStyle(
                        color: grey3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      FieldCard(
                        color: white,
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        labelText: "Бүсийн нэр",
                        secondText: business.areaRegion?.name,
                        secondTextColor: networkColor,
                        arrowColor: networkColor,
                      ),
                      FieldCard(
                        color: white,
                        paddingHorizontal: 15,
                        paddingVertical: 10,
                        labelText: "Чиглэл",
                        secondText: business.areaDirection?.name,
                        secondTextColor: networkColor,
                        arrowColor: networkColor,
                      ),
                    ],
                  ),
                  if (Permission().check(user, "NET_AREA_SET"))
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(SetDistributionArea.routeName,
                                arguments: SetDistributionAreaArguments(
                                  listenController: widget.listenController,
                                  id: widget.id,
                                ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.5),
                        color: transparent,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(
                            right: 15, top: 10, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset('assets/svg/person-check.svg'),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Өөрчлөх',
                              style: TextStyle(
                                color: networkColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: const Text(
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
                    child: FormBuilder(
                      key: fbKey,
                      child: FormTextField(
                        readOnly: true,
                        controller: textController,
                        textAlign: TextAlign.left,
                        name: 'description',
                        maxLines: 5,
                        decoration: const InputDecoration(
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
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
    );
  }
}
