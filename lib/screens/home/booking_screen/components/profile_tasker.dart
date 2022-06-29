import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import 'package:hs_user_app/theme/svg_constants.dart';

import '../../../../core/user/model/user_model.dart';
import '../../../layout_template/content_screen.dart';

class ProfileTasker extends StatefulWidget {
  const ProfileTasker({Key? key}) : super(key: key);

  @override
  State<ProfileTasker> createState() => _ProfileTaskerState();
}

class _ProfileTaskerState extends State<ProfileTasker> {
  final PageState _pageState = PageState();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
      onFetch: () {
        _fetchDataOnPage();
      },
      appBarHeight: 0,
      child: FutureBuilder(
        future: _pageState.currentUser,
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          return PageContent(
            child: content(context), // child: content(context),
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
          );
        },
      ),
    );
  }

  Scaffold content(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.text2,
      appBar: AppBar(
        elevation: 16,
        shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
        backgroundColor: AppColor.text2,
        centerTitle: true,
        title: Text(
          'Thông tin người làm',
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
        leading: TextButton(
          onPressed: () {
            navigateTo(viewDetailRoute);
          },
          child: SvgIcon(
            SvgIcons.arrowBack,
            size: 24,
            color: AppColor.text1,
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundColor: AppColor.primary1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Nguyễn Đức Hoàng Phi',
                style: AppTextTheme.mediumBigText(AppColor.text1),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: 183,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgIcon(
                        SvgIcons.star,
                        color: AppColor.primary2,
                        size: 24,
                      ),
                      SvgIcon(
                        SvgIcons.star,
                        color: AppColor.primary2,
                        size: 24,
                      ),
                      SvgIcon(
                        SvgIcons.star,
                        color: AppColor.primary2,
                        size: 24,
                      ),
                      SvgIcon(
                        SvgIcons.star,
                        color: AppColor.primary2,
                        size: 24,
                      ),
                      SvgIcon(
                        SvgIcons.starHalf,
                        color: AppColor.primary2,
                        size: 24,
                      ),
                      Text(
                        '4.5',
                        style: AppTextTheme.normalHeaderTitle(AppColor.text1),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 16),
                  child: Text(
                    '(643 đánh giá)',
                    style: AppTextTheme.normalText(AppColor.text1),
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  profileTasker(title: 'Tham gia từ', profile: '3/2019'),
                  linevertical(context),
                  profileTasker(title: 'Công việc', profile: '320'),
                  linevertical(context),
                  profileTasker(title: 'Đánh giá tích cực', profile: '90%'),
                ],
              ),
            ),
            titleMedal(),
            listmedal(),
            const SizedBox(
              height: 28,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Text(
                      'Đánh giá tiêu biểu',
                      style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      constraints:
                          const BoxConstraints(minHeight: 400, maxHeight: 600),
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          review(
                            comment: '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                            user: 'Ngo Anh Duong',
                            rate: '4.5',
                          ),
                          review(
                            comment: '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                            user: 'Ngo Anh Duong',
                            rate: '4.5',
                          ),
                          review(
                            comment: '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                            user: 'Ngo Anh Duong',
                            rate: '4.5',
                          ),
                          review(
                            comment: '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                            user: 'Ngo Anh Duong',
                            rate: '4.5',
                          ),
                          review(
                            comment: '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                            user: 'Ngo Anh Duong',
                            rate: '4.5',
                          ),
                          review(
                            comment: '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                            user: 'Ngo Anh Duong',
                            rate: '4.5',
                          ),
                          review(
                            comment: '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                            user: 'Ngo Anh Duong',
                            rate: '4.5',
                          ),
                          review(
                            comment: '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                            user: 'Ngo Anh Duong',
                            rate: '4.5',
                          ),
                          review(
                            comment: '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                            user: 'Ngo Anh Duong',
                            rate: '4.5',
                          ),
                          review(
                            comment: '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                            user: 'Ngo Anh Duong',
                            rate: '4.5',
                          ),
                          review(
                            comment: '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                            user: 'Ngo Anh Duong',
                            rate: '4.5',
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding review(
      {required String comment, required String user, required String rate}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 19.5, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  comment,
                  style: AppTextTheme.normalText(AppColor.text1),
                ),
              ),
              Text(
                user,
                style: AppTextTheme.subText(AppColor.text7),
              ),
            ],
          ),
          Row(
            children: [
              SvgIcon(
                SvgIcons.star,
                color: AppColor.primary2,
                size: 24,
              ),
              const SizedBox(
                width: 9,
              ),
              Text(
                rate,
                style: AppTextTheme.normalText(AppColor.text1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container listmedal() {
    return Container(
      constraints: const BoxConstraints(minHeight: 50, maxHeight: 120),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          medal(),
          medal(),
          medal(),
          medal(),
          medal(),
          medal(),
        ],
      ),
    );
  }

  Padding medal() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Stack(
            children: [
              const SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 15,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.primary1,
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    child: Text(
                      '10',
                      style: AppTextTheme.subText(AppColor.text2),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Nhanh nhẹn',
              style: AppTextTheme.subText(AppColor.text1),
            ),
          )
        ],
      ),
    );
  }

  Padding titleMedal() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 16.0, right: 16.0, bottom: 8.0, left: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Huy hiệu',
            style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
          ),
          Text(
            '7 huy hiệu',
            style: AppTextTheme.normalText(AppColor.primary2),
          )
        ],
      ),
    );
  }

  Container linevertical(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 42),
      width: 1,
      height: MediaQuery.of(context).size.height,
      color: AppColor.shade1,
    );
  }

  Column profileTasker({required String title, required String profile}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            title,
            style: AppTextTheme.normalText(AppColor.text7),
          ),
        ),
        Text(
          profile,
          style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
        )
      ],
    );
  }
}

void _fetchDataOnPage() {}
