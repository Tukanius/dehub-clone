import 'dart:io';

import 'package:dehub/api/auth_api.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfo extends StatefulWidget {
  static const routeName = '/personalinfo';

  PersonalInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  User user = User();
  bool isLoading = false;
  User dan = User();
  bool isSubmit = false;
  Partner partner = Partner();
  File? image;
  final picker = ImagePicker();
  String? imageName;
  Uri? result;

  danVerify() async {
    setState(() {
      isSubmit = true;
    });
    dan = await AuthApi().danVerify();
    await launchUrl(dan.url!);
    setState(() {
      isSubmit = false;
    });
  }

  getImage(ImageSource imageSource) async {
    XFile? file = await picker.pickImage(
        source: imageSource, imageQuality: 40, maxHeight: 1024);

    if (file != null) {
      setState(() {
        image = File(file.path);
        isLoading = true;
      });
      result = await AuthApi().upload(file);
      await AuthApi().avatar(
        User(avatar: result.toString()),
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
            child: Text(
              'Зургийн сангаас',
              style: TextStyle(color: grey2, fontFamily: 'Montserrat'),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              getImage(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Зураг авах',
              style: TextStyle(color: grey2, fontFamily: 'Montserrat'),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              getImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;
    partner = Provider.of<UserProvider>(context, listen: true).partnerUser;
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(
              color: grey2,
            ),
          )
        : SingleChildScrollView(
            child: Container(
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
                                boxShadow: [
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
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // image == null
                          //     ? GestureDetector(
                          //         onTap: showOptions,
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(3),
                          //             color: buttonColor,
                          //           ),
                          //           padding: const EdgeInsets.symmetric(
                          //               vertical: 3, horizontal: 5),
                          //           child: Text(
                          //             'Зураг солих',
                          //             style: TextStyle(color: white),
                          //           ),
                          //         ),
                          //       )
                          //     : GestureDetector(
                          //         onTap: changeAvatar,
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(3),
                          //             color: buttonColor,
                          //           ),
                          //           padding: const EdgeInsets.symmetric(
                          //               vertical: 3, horizontal: 5),
                          //           child: Text(
                          //             'Өөрчлөх',
                          //             style: TextStyle(color: white),
                          //           ),
                          //         ),
                          //       ),
                          Positioned(
                            bottom: -23,
                            right: -15,
                            child: InkWell(
                              onTap: () async {
                                // await AuthApi().avatar(
                                //   User(avatar: imageName),
                                // );
                                // await AuthApi().upload(image);
                              },
                              child: Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffC4C4C4),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        '${partner.user?.currentBusiness?.profileNameEng}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: grey3),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${user.firstName}, ${user.phone}',
                        style: TextStyle(
                          fontSize: 16,
                          color: grey3,
                        ),
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Хувийн мэдээлэл',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: grey3,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Хэрэглэгчийн нэр',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: grey3),
                            ),
                            child: user.username != null
                                ? Text(
                                    user.username.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: grey3,
                                    ),
                                  )
                                : Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: grey3,
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Регист №',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: grey3),
                              ),
                              child: user.registerNo != null
                                  ? Text(
                                      '${user.registerNo}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: grey3,
                                      ),
                                    )
                                  : Text(
                                      '-',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: grey3,
                                      ),
                                    )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Ургын овог',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: grey3),
                            ),
                            child: user.familyName != null
                                ? Text(
                                    "${user.familyName}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: grey3,
                                    ),
                                  )
                                : Text(
                                    "-",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: grey3,
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Эцэг/Эхийн нэр',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: grey3),
                            ),
                            child: user.lastName != null
                                ? Text(
                                    '${user.lastName}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: grey3,
                                    ),
                                  )
                                : Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: grey3,
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Өөрийн нэр',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: grey3),
                            ),
                            child: Text(
                              '${user.firstName}',
                              style: TextStyle(
                                fontSize: 14,
                                color: grey3,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Харъяалах нэгж',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: grey3),
                            ),
                            child: Text(
                              'Борлуулалтын алба',
                              style: TextStyle(
                                fontSize: 14,
                                color: grey3,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Албан тушаал',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: grey3),
                            ),
                            child: Text(
                              'Худалдааны төлөөлөгч',
                              style: TextStyle(
                                fontSize: 14,
                                color: grey3,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Text(
                              'Холбоо барих',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: grey3,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Утасны дугаар №1',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: grey3),
                                ),
                                child: Text(
                                  '${user.phone}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: grey3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'И-мэйл хаяг №1',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: grey3),
                                ),
                                child: Text(
                                  '${user.email}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: grey3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Утасны дугаар №2',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: grey3),
                                ),
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: grey3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'И-мэйл хаяг №2',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: grey3),
                                ),
                                child: Text(
                                  '${user.email}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: grey3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
