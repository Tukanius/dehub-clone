import 'dart:io';

import 'package:dehub/api/auth_api.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/camera_page/camera_page.dart';
import 'package:dehub/src/profile/components/card.dart';
import 'package:dehub/src/profile/components/editing_information.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfo extends StatefulWidget {
  static const routeName = '/personalinfo';

  const PersonalInfo({
    super.key,
  });

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  User user = User();
  bool isLoading = false;
  User dan = User();
  File? image;
  final picker = ImagePicker();
  String? imageName;
  User result = User();
  bool edit = false;

  danVerify() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    loading.loading(true);
    dan = await AuthApi().danVerify();
    loading.loading(false);
    await launchUrl(dan.url!);
  }

  getImage(ImageSource imageSource) async {
    XFile? file = await picker.pickImage(
        source: imageSource, imageQuality: 40, maxHeight: 1024);

    if (file != null) {
      setState(() {
        image = File(file.path);
        isLoading = true;
      });
      result = await AuthApi().upload(file, 'auth');
      await AuthApi().avatar(
        User(avatar: result.url.toString()),
      );
      await Provider.of<UserProvider>(context, listen: false).me(true);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text(
              'Зургийн сангаас',
              style: TextStyle(color: grey2, fontFamily: 'Montserrat'),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              getImage(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Зураг авах',
              style: TextStyle(color: grey2, fontFamily: 'Montserrat'),
            ),
            onPressed: () {
              // Navigator.of(context).pop();
              // getImage(ImageSource.camera);
              Navigator.of(context).pushNamed(CameraPage.routeName);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(
              color: grey2,
            ),
          )
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        GestureDetector(
                          onTap: showOptions,
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.grey,
                                  offset: Offset(0, 5),
                                ),
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.grey,
                                  offset: Offset(5, 0),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: user.avatar != null && image == null
                                  ? Image.network(
                                      '${user.avatar}',
                                      fit: BoxFit.cover,
                                    )
                                  : image != null
                                      ? Image.file(
                                          image!,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'images/avatar.png',
                                          fit: BoxFit.cover,
                                        ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -20,
                          right: -15,
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffC4C4C4),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      user.currentBusiness?.profileName ?? '',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: grey3),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${user.firstName}, ${user.phone}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: grey3,
                      ),
                    ),
                    const Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: const Text(
                    'Хувийн мэдээлэл',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: grey3,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditingInformation(
                        edit: edit,
                        name: "registerNo",
                        paddingVertical: 5,
                        labelText: 'Регистр №',
                        value: user.registerNo,
                      ),
                      InformationCard(
                        paddingVertical: 5,
                        labelText: 'Регистр №',
                        value: user.registerNo,
                      ),
                      InformationCard(
                        paddingVertical: 5,
                        labelText: "Бизнес код",
                        value: user.currentBusiness?.refCode,
                      ),
                      InformationCard(
                        paddingVertical: 5,
                        labelText: 'Ургын овог',
                        value: user.familyName,
                      ),
                      InformationCard(
                        paddingVertical: 5,
                        labelText: 'Эцэг/Эхийн нэр',
                        value: user.lastName,
                      ),
                      InformationCard(
                        paddingVertical: 5,
                        labelText: 'Өөрийн нэр',
                        value: user.firstName,
                      ),
                      const InformationCard(
                        paddingVertical: 5,
                        labelText: 'Харъяалах нэгж',
                        value: 'Борлуулалтын алба',
                      ),
                      const InformationCard(
                        paddingVertical: 5,
                        labelText: 'Албан тушаал',
                        value: 'Худалдааны төлөөлөгч',
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: const Text(
                          'Холбоо барих',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: grey3,
                          ),
                        ),
                      ),
                      InformationCard(
                        paddingVertical: 5,
                        labelText: 'Утасны дугаар №1',
                        value: '${user.phone}',
                      ),
                      InformationCard(
                        paddingVertical: 5,
                        labelText: 'И-мэйл хаяг №1',
                        value: '${user.email}',
                      ),
                      InformationCard(
                        paddingVertical: 5,
                        labelText: 'Утасны дугаар №2',
                        value: '${user.phone2}',
                      ),
                      InformationCard(
                        paddingVertical: 5,
                        labelText: 'И-мэйл хаяг №2',
                        value: '${user.email2}',
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
