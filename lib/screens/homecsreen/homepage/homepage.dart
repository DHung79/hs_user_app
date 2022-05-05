import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/fonts.dart';
import '../../../config/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 24,
                      blurStyle: BlurStyle.outer,
                      color: Colors.grey),
                ],
                borderRadius: BorderRadius.vertical(
                    top: Radius.zero, bottom: Radius.circular(10))),
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [avatarHome(), helloContent(), notification()],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
          Expanded(
              child: Container(
            // color: Colors.white,
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dịch vụ',
                  style: FontStyle().serviceFont,
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x4F758C29).withOpacity(0.24),
                          blurRadius: 16)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                        child: Image.asset('assets/images/logodemo.png'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Dọn dẹp theo giờ',
                              style: FontStyle().titleFontService,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Bạn không có thời gian để dọn dẹp?\nHãy để II home giúp bạn với đội ngũ chuyên nghiệp',
                              maxLines: 5,
                            ),
                            const SizedBox(height: 16),
                            const Divider(
                              height: 2,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Trải nghiệm dịch vụ',
                          style: FontStyle().expService,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  ClipRRect avatarHome() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10), // Image border
      child: SizedBox.fromSize(
        size: const Size.fromRadius(20),
        // size: Size.fromRadius(40), // Image radius
        child: Image.asset('assets/images/logodemo.png', fit: BoxFit.cover),
      ),
    );
  }

  Column helloContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Xin chào, Nancy',
          style: FontStyle().serviceFont,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          'Đã 5 ngày tồi bạn chưa dọn dẹp',
          style: FontStyle().textHelloContent,
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 16,
          child: TextButton(
            style: ButtonStyle(
              // backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(0)),
            ),
            onPressed: () {},
            child: Text(
              'ĐĂNG NGAY',
              style: FontStyle().postNow,
            ),
          ),
        )
      ],
    );
  }

  Container notification() {
    return Container(
      height: 42,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
                blurRadius: 3, color: Colors.grey, blurStyle: BlurStyle.outer)
          ]),
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        SvgPicture.asset(
          'assets/icons/17073.svg',
          width: 20,
        ),
        const SizedBox(
          width: 13,
        ),
        const CircleAvatar(
          child: Text(
            '9+',
          ),
        )
      ]),
    );
  }
}
