import 'package:dehub/models/user.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/change_password/change_password.dart';
import 'package:dehub/src/auth/pin_code/new_pin.dart';
import 'package:dehub/src/auth/pin_code/pin_code.dart';
import 'package:dehub/src/splash/splash_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  static const routeName = '/menupage';
  const MenuPage({
    super.key,
  });

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  User user = User();

  logout() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      await Provider.of<UserProvider>(context, listen: false).logout();
      loading.loading(false);
      await Navigator.of(context).pushNamed(SplashPage.routeName);
    } catch (e) {
      loading.loading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height,
          color: menuBack,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            user.avatar != null && user.avatar != ''
                                ? CircleAvatar(
                                    radius: 35,
                                    backgroundImage:
                                        NetworkImage('${user.avatar}'),
                                    backgroundColor: grey,
                                  )
                                : const CircleAvatar(
                                    radius: 17,
                                    backgroundImage:
                                        AssetImage('images/avatar.png'),
                                    backgroundColor: grey,
                                  ),
                            const SizedBox(
                              height: 5,
                            ),
                            user.lastName != null
                                ? Text(
                                    '${user.lastName?[0]}. ${user.firstName}',
                                    style: const TextStyle(
                                      color: white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    '${user.firstName}',
                                    style: const TextStyle(
                                      color: white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Холбоо барих',
                                  style: TextStyle(
                                    color: lightGrey,
                                    fontSize: 12,
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: lightGrey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.mail_outline_outlined,
                                  color: white,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    '${user.email}',
                                    style: const TextStyle(color: white),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/viber.svg',
                                  colorFilter: const ColorFilter.mode(
                                      white, BlendMode.srcIn),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    '${user.phone}',
                                    style: const TextStyle(color: white),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Төлөв',
                                  style: TextStyle(
                                    color: lightGrey,
                                    fontSize: 12,
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: lightGrey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Хэрэглэгчийн төлөв: ',
                              style: TextStyle(
                                color: white,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: neonGreen,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: const Text(
                                'Идэвхтэй',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'И-мэйл баталгаажилт: ',
                              style: TextStyle(
                                color: white,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: user.isEmailVerified == true
                                    ? userColor
                                    : grey2,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Text(
                                user.isEmailVerified == true ? 'Тийм' : "Үгүй",
                                style: const TextStyle(
                                  color: white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Утас баталгаажилт: ',
                              style: TextStyle(
                                color: white,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: user.isPhoneVerified == true
                                    ? userColor
                                    : grey2,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Text(
                                user.isPhoneVerified == true ? 'Тийм' : "Үгүй",
                                style: const TextStyle(
                                  color: white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'ДАН систем баталгаажилт: ',
                              style: TextStyle(
                                color: white,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: user.isDanVerified == true
                                    ? userColor
                                    : grey2,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Text(
                                user.isDanVerified == true ? 'Тийм' : "Үгүй",
                                style: const TextStyle(
                                  color: white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (user.hasPin == true) {
                          Navigator.of(context).pushNamed(PinCode.routeName);
                        } else {
                          Navigator.of(context).pushNamed(NewPin.routeName,
                              arguments: NewPinArguments(oldPin: ''));
                        }
                      },
                      child: Container(
                        color: transparent,
                        padding: const EdgeInsets.only(
                            left: 15, bottom: 10, top: 10),
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.lock_circle_fill,
                              color: white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            user.hasPin == false
                                ? const Text(
                                    'Пин код үүсгэх',
                                    style: TextStyle(
                                      color: white,
                                    ),
                                  )
                                : const Text(
                                    'Пин код солих',
                                    style: TextStyle(
                                      color: white,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ChangePassword.routeName);
                      },
                      child: Container(
                        color: transparent,
                        padding: const EdgeInsets.only(
                            left: 15, bottom: 10, top: 10),
                        child: const Row(
                          children: [
                            Icon(
                              CupertinoIcons.lock_rotation,
                              color: white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Нууц үг солих',
                              style: TextStyle(color: white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        logout();
                      },
                      child: Container(
                        color: transparent,
                        padding: const EdgeInsets.only(
                            left: 15, bottom: 25, top: 10),
                        child: const Row(
                          children: [
                            Icon(
                              CupertinoIcons.power,
                              color: red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Системээс гарах',
                              style: TextStyle(
                                color: red,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
