import 'package:dehub/models/business_network.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ClientClassificationCard extends StatefulWidget {
  final bool startAnimation;
  final int index;
  final Function()? onClick;
  final BusinessNetwork? data;
  const ClientClassificationCard({
    super.key,
    this.onClick,
    this.data,
    required this.index,
    required this.startAnimation,
  });

  @override
  State<ClientClassificationCard> createState() =>
      _ClientClassificationCardState();
}

class _ClientClassificationCardState extends State<ClientClassificationCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        curve: Curves.ease,
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        transform: Matrix4.translationValues(
            widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
            0,
            0),
        margin: const EdgeInsets.only(bottom: 3),
        padding: const EdgeInsets.all(15),
        color: white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      widget.data?.logo != null || widget.data?.logo == ''
                          ? CircleAvatar(
                              backgroundColor: grey,
                              radius: 18,
                              backgroundImage:
                                  NetworkImage('${widget.data?.logo}'),
                            )
                          : const CircleAvatar(
                              backgroundColor: grey,
                              radius: 18,
                              backgroundImage: AssetImage('images/avatar.png'),
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.data?.profileName}',
                              style: const TextStyle(
                                color: networkColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${widget.data?.refCode}',
                              style: const TextStyle(
                                color: dark,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: networkColor,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ангилал:',
                        style: TextStyle(
                          color: grey2.withOpacity(0.7),
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      widget.data?.classificationCategory?.name == null
                          ? const Text(
                              '-',
                              style: TextStyle(
                                color: grey2,
                                fontSize: 12,
                              ),
                            )
                          : Text(
                              '${widget.data?.classificationCategory?.name}',
                              style: const TextStyle(
                                color: grey2,
                                fontSize: 12,
                              ),
                            ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Зэрэглэл',
                        style: TextStyle(
                          color: grey2.withOpacity(0.7),
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      widget.data?.classificationPriority?.name == null
                          ? const Text(
                              '-',
                              style: TextStyle(
                                color: grey2,
                                fontSize: 12,
                              ),
                            )
                          : Text(
                              '${widget.data?.classificationPriority?.name}',
                              style: const TextStyle(
                                color: grey2,
                                fontSize: 12,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
