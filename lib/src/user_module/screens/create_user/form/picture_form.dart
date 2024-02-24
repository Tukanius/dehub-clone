import 'package:dehub/providers/user_module_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:dehub/api/user_api.dart';
import 'package:dehub/models/user.dart';
import 'package:image_picker/image_picker.dart';

class UserPictureForm extends StatefulWidget {
  const UserPictureForm({super.key});

  @override
  State<UserPictureForm> createState() => _UserPictureFormState();
}

class _UserPictureFormState extends State<UserPictureForm> {
  bool isLoading = false;
  final picker = ImagePicker();
  User banner = User();
  XFile? bannerImage;
  final ImagePicker imagePicker = ImagePicker();

  getImage(ImageSource imageSource, String style) async {
    User user = User();
    XFile? file = await picker.pickImage(
        source: imageSource, imageQuality: 40, maxHeight: 1024);
    final source = Provider.of<UserModuleProvider>(context, listen: false);
    if (file != null) {
      setState(() {
        isLoading = true;
      });
      user = await UserApi().upload(file);
      if (style == "PROFILE") {
        source.profileImage(user.url.toString());
      } else if (style == "FRONT") {
        source.cardFront(user.url.toString());
      } else {
        source.cardBack(user.url.toString());
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<UserModuleProvider>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: const Text(
            'Профайл зураг',
            style: TextStyle(
              color: grey3,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          color: white,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130,
                width: 260,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: const Color(0xffD9D9D9)),
                  color: const Color(0xffFAFAFA),
                ),
                child: isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(color: grey3),
                      )
                    : source.user.avatar == null
                        ? const Center(
                            child: Icon(
                            Icons.add,
                            color: grey3,
                            size: 11,
                          ))
                        : Image.network(
                            '${source.user.avatar}',
                            fit: BoxFit.cover,
                          ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: const Color(0xffD9D9D9),
                      ),
                      color: const Color(0xffFAFAFA),
                    ),
                    child: isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator(color: grey3),
                          )
                        : source.user.avatar == null
                            ? const Center(
                                child: Icon(
                                Icons.add,
                                color: grey3,
                                size: 11,
                              ))
                            : Image.network(
                                '${source.user.avatar}',
                                fit: BoxFit.cover,
                              ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: const Color(0xffD9D9D9),
                      ),
                      color: const Color(0xffFAFAFA),
                    ),
                    child: isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator(color: grey3),
                          )
                        : source.user.avatar == null
                            ? const Center(
                                child: Icon(
                                  Icons.add,
                                  color: grey3,
                                  size: 11,
                                ),
                              )
                            : Image.network(
                                '${source.user.avatar}',
                                fit: BoxFit.cover,
                              ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                getImage(ImageSource.gallery, "PROFILE");
              },
              child: Container(
                color: transparent,
                padding: const EdgeInsets.only(
                    left: 15, right: 7.5, top: 10, bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffEAECEE),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/image_upload.svg',
                    colorFilter:
                        const ColorFilter.mode(userColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                getImage(ImageSource.camera, "PROFILE");
              },
              child: Container(
                color: transparent,
                padding: const EdgeInsets.only(
                    right: 15, left: 7.5, bottom: 10, top: 10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffEAECEE),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/camera_plus.svg',
                    colorFilter:
                        const ColorFilter.mode(userColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: const Text(
            'Иргэний үнэмлэх - Урд тал',
            style: TextStyle(
              color: grey3,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          color: white,
          width: MediaQuery.of(context).size.width,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: const Color(0xffD9D9D9),
              ),
              color: const Color(0xffFAFAFA),
            ),
            child: source.user.identityCardFront == null
                ? const Center(
                    child: Icon(
                      Icons.add,
                      color: grey3,
                      size: 11,
                    ),
                  )
                : Image.network(
                    "${source.user.identityCardFront}",
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                getImage(ImageSource.gallery, "FRONT");
              },
              child: Container(
                color: transparent,
                padding: const EdgeInsets.only(
                    left: 15, right: 7.5, top: 10, bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffEAECEE),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/image_upload.svg',
                    colorFilter:
                        const ColorFilter.mode(userColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                getImage(ImageSource.camera, "FRONT");
              },
              child: Container(
                color: transparent,
                padding: const EdgeInsets.only(
                    right: 15, left: 7.5, bottom: 10, top: 10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffEAECEE),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/camera_plus.svg',
                    colorFilter:
                        const ColorFilter.mode(userColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: const Text(
            'Иргэний үнэмлэх - Ард тал',
            style: TextStyle(
              color: grey3,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          color: white,
          width: MediaQuery.of(context).size.width,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: const Color(0xffD9D9D9),
              ),
              color: const Color(0xffFAFAFA),
            ),
            child: source.user.identityCardBack == null
                ? const Center(
                    child: Icon(
                      Icons.add,
                      color: grey3,
                      size: 11,
                    ),
                  )
                : Image.network(
                    '${source.user.identityCardBack}',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                getImage(ImageSource.gallery, "BACK");
              },
              child: Container(
                color: transparent,
                padding: const EdgeInsets.only(
                    left: 15, right: 7.5, top: 10, bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffEAECEE),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/image_upload.svg',
                    colorFilter:
                        const ColorFilter.mode(userColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                getImage(ImageSource.camera, "BACK");
              },
              child: Container(
                color: transparent,
                padding: const EdgeInsets.only(
                    right: 15, left: 7.5, bottom: 10, top: 10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffEAECEE),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/camera_plus.svg',
                    colorFilter:
                        const ColorFilter.mode(userColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
