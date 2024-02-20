import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/change_password/change_password.dart';
import 'package:dehub/src/entry_point/menu/suppliers/suppliers_page.dart';
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
  bool isLoading = false;

  logout() {
    setState(() {
      isLoading = true;
    });
    Provider.of<UserProvider>(context, listen: false).logout();
    Navigator.of(context).pushNamed(SplashPage.routeName);
    setState(() {
      isLoading = false;
    });
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
            child: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: white,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15, top: 20),
                            child: Row(
                              children: [
                                user.avatar != null && user.avatar != ''
                                    ? CircleAvatar(
                                        radius: 17,
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
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    user.lastName != null
                                        ? Text(
                                            '${user.lastName?[0]}. ${user.firstName}',
                                            style: const TextStyle(
                                              color: white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        : Text(
                                            '${user.firstName}',
                                            style: const TextStyle(
                                              color: white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                    Text(
                                      '${user.currentBusiness?.type ?? user.loginType}',
                                      style: const TextStyle(color: white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 50, left: 15),
                            child: const Text(
                              'Захиалга',
                              style: TextStyle(
                                color: white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/pie.svg',
                                      colorFilter: const ColorFilter.mode(
                                          white, BlendMode.srcIn),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Тайлан, дашбоард',
                                      style:
                                          TextStyle(fontSize: 14, color: white),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: white,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(SuppliersPage.routeName);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/apartment.svg',
                                        colorFilter: const ColorFilter.mode(
                                            white, BlendMode.srcIn),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      user.currentBusiness?.type == "BUYER"
                                          ? const Text(
                                              'Ханган нийлүүлэгчид',
                                              style: TextStyle(
                                                  fontSize: 14, color: white),
                                            )
                                          : const Text(
                                              'Худалдан авагчид',
                                              style: TextStyle(
                                                  fontSize: 14, color: white),
                                            )
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.add_shopping_cart,
                                        color: white,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: user.currentBusiness?.type ==
                                                "SUPPLIER"
                                            ? const Text(
                                                'Борлуулалтын захиалга',
                                                style: TextStyle(
                                                    fontSize: 14, color: white),
                                              )
                                            : const Text(
                                                'Худалдан авалтын захиалга',
                                                style: TextStyle(
                                                    fontSize: 14, color: white),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: white,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/huleen_avsan.svg',
                                      colorFilter: const ColorFilter.mode(
                                          white, BlendMode.srcIn),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Хүлээн авсан захиалгууд',
                                      style:
                                          TextStyle(fontSize: 14, color: white),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (user.hasPin == true) {
                                Navigator.of(context)
                                    .pushNamed(PinCode.routeName);
                              } else {
                                Navigator.of(context).pushNamed(
                                    NewPin.routeName,
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
                          const SizedBox(
                            height: 20,
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
