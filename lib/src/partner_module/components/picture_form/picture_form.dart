import 'package:dehub/api/partner_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/partner_provider.dart';
import 'package:dehub/src/auth/camera_page/camera_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class PartnerPictureForm extends StatefulWidget {
  final GlobalKey? profileKey;
  const PartnerPictureForm({
    super.key,
    this.profileKey,
  });

  @override
  State<PartnerPictureForm> createState() => _PartnerPictureFormState();
}

class _PartnerPictureFormState extends State<PartnerPictureForm> {
  final picker = ImagePicker();
  bool isLoading = false;
  Partner user = Partner();
  Partner banner = Partner();
  XFile? bannerImage;
  final ImagePicker imagePicker = ImagePicker();
  ListenController listenController = ListenController();

  getImage(ImageSource imageSource) async {
    XFile? file = await picker.pickImage(
        source: imageSource, imageQuality: 40, maxHeight: 1024);
    final source = Provider.of<PartnerProvider>(context, listen: false);
    if (file != null) {
      setState(() {
        isLoading = true;
      });
      user = await PartnerApi().upload(file.path);
      source.profileImage(user.url.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  void getMultiplyImage() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      for (var i = 0; i < selectedImages.length; i++) {
        banner = await PartnerApi().upload(selectedImages[i].path);
        Provider.of<PartnerProvider>(context, listen: false)
            .bannerImages(Partner(url: banner.url, isMain: false));
      }
    }
  }

  @override
  void initState() {
    final source = Provider.of<PartnerProvider>(context, listen: false);
    listenController.addListener(() async {
      user = await PartnerApi().upload(listenController.value!);
      source.profileImage(user.url!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<PartnerProvider>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: const Text(
            'Нүүрэнд гарах зураг',
            style: TextStyle(
              color: grey3,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          key: widget.profileKey,
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
                    : source.partner.logo == null
                        ? const Center(
                            child: Icon(
                            Icons.add,
                            color: grey3,
                            size: 11,
                          ))
                        : Image.network(
                            '${source.partner.logo}',
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
                        : source.partner.logo == null
                            ? const Center(
                                child: Icon(
                                Icons.add,
                                color: grey3,
                                size: 11,
                              ))
                            : Image.network(
                                '${source.partner.logo}',
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
                        : source.partner.logo == null
                            ? const Center(
                                child: Icon(
                                  Icons.add,
                                  color: grey3,
                                  size: 11,
                                ),
                              )
                            : Image.network(
                                '${source.partner.logo}',
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
                getImage(ImageSource.gallery);
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
                        const ColorFilter.mode(partnerColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  CameraPage.routeName,
                  arguments:
                      CameraPageArguments(listenController: listenController),
                );
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
                        const ColorFilter.mode(partnerColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: const Text(
            'Баннерт гарах зураг',
            style: TextStyle(
              color: grey3,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          color: white,
          child: SizedBox(
            height: 130,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              children: source.partner.profileBanners != null &&
                      source.partner.profileBanners!.isNotEmpty
                  ? source.partner.profileBanners!.map((data) {
                      int index = source.partner.profileBanners!.indexOf(data);
                      int index1 = source.partner.profileBanners!
                          .indexWhere((element) => element.isMain == true);
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (index1 > -1) {
                                  source.partner.profileBanners?[index1]
                                      .isMain = false;
                                }
                                source.partner.profileBanners?[index].isMain =
                                    true;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: data.logo != "3" ? 7 : 0),
                              height: 130,
                              width: 260,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  width: data.isMain == false ? 1 : 3,
                                  color: data.isMain == false
                                      ? const Color(0xffD9D9D9)
                                      : partnerColor,
                                ),
                                color: const Color(0xffFAFAFA),
                              ),
                              child: Image.network(
                                data.url!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 15,
                            top: 10,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: white),
                              child: GestureDetector(
                                onTap: () {
                                  source.removeBannerImage(source
                                      .partner.profileBanners!
                                      .indexOf(data));
                                },
                                child: SvgPicture.asset(
                                  'assets/svg/close.svg',
                                  colorFilter: const ColorFilter.mode(
                                      partnerColor, BlendMode.srcIn),
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList()
                  : [1, 2]
                      .map(
                        (data) => Container(
                          margin: EdgeInsets.only(right: data != 2 ? 7 : 0),
                          height: 130,
                          width: 260,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: const Color(0xffD9D9D9),
                            ),
                            color: const Color(0xffFAFAFA),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: grey3,
                              size: 11,
                            ),
                          ),
                        ),
                      )
                      .toList(),
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
                getMultiplyImage();
              },
              child: Container(
                color: transparent,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
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
                        const ColorFilter.mode(partnerColor, BlendMode.srcIn),
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
