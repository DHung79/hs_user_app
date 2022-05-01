import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_services/config/fonts.dart';

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
          SizedBox(
            height: 224,
            child: Stack(
              children: [
                Image.asset('assets/images/logodemo.png'),
                Positioned(
                    width: 382,
                    bottom: 35,
                    left: 5,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      constraints:  const BoxConstraints(
                        maxWidth: 382,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [BoxShadow(
                              color: const Color(0x4F758C29).withOpacity(0.24),
                              blurRadius: 16
                          )],
                        ),
                      child: Container(
                        padding: const EdgeInsets.all(19),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/17082.svg', width: 20, color: ColorApp.purpleColor,),
                            const SizedBox(width: 14.5,),
                            Text('Chọn địa chỉ', style: FontStyle().pickMapFont,),
                          ],
                        ),
                      )
                    )
                ),
                Positioned(
                  top: 21,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset('assets/icons/17077.svg'),
                  ),),
              ],
            ),
          ),
          Expanded(
              child: Container(
                // color: Colors.white,
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dịch vụ', style: FontStyle().serviceFont,),
                    const SizedBox(height: 16,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [BoxShadow(
                          color: const Color(0x4F758C29).withOpacity(0.24),
                          blurRadius: 16
                        )],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset('assets/images/logodemo.png'),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16,),
                                Text('Dọn dẹp theo giờ', style: FontStyle().titleFontService,),
                                const SizedBox(height: 10,),
                                const Text('Bạn không có thời gian để dọn dẹp?\nHãy để II home giúp bạn với đội ngũ chuyên nghiệp', maxLines: 5,),
                                const SizedBox(height: 16),
                                const Divider(height: 2,),
                                const SizedBox(height: 16,),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text('Trải nghiệm dịch vụ', style: FontStyle().expService,),
                          ),
                          const SizedBox(height: 16,),
                        ],
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
