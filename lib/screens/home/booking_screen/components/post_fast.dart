import 'package:flutter/material.dart';
import 'package:hs_user_app/routes/route_names.dart';

import '../../../../core/user/model/user_model.dart';
import '../../../../main.dart';
import '../../../../models/profile_model.dart';
import '../../../../theme/svg_constants.dart';
import '../../../layout_template/content_screen.dart';

class PostFast extends StatefulWidget {
  const PostFast({Key? key}) : super(key: key);

  @override
  State<PostFast> createState() => _PostFastState();
}

class _PostFastState extends State<PostFast> {
  final PageState _pageState = PageState();
  String fakeCode = 'JOYTECH';
  int valueWeek = 0;
  int value = 0;

  final TextEditingController _code = TextEditingController();
  String? code;
  List<ProfileModel> fakeProfiles = [
    ProfileModel(
      'Thông tin công việc',
      '3 tiếng, 14:00 đến 17:00',
      'thứ 6, 25/03/2022',
      '55 m2 / 2 phòng',
      'Thông tin của bạn',
      'Julies Nguyen',
      '(+84) 0335475756',
      '358/12/33 Lư Cẩm, Ngọc Hiệp - Nha Trang - Khánh Hòa',
      'Hình thức thanh toán',
      'Thanh toán bằng tiền mặt',
    ),
  ];

  List profileIcons = [
    SvgIcon(
      SvgIcons.accessTime,
      color: AppColor.shade5,
      size: 24,
    ),
    SvgIcon(
      SvgIcons.calenderToday,
      color: AppColor.shade5,
      size: 24,
    ),
    SvgIcon(
      SvgIcons.clipboard1,
      color: AppColor.shade5,
      size: 24,
    ),
    SvgIcon(
      SvgIcons.user1,
      color: AppColor.shade5,
      size: 24,
    ),
    SvgIcon(
      SvgIcons.telephone1,
      color: AppColor.shade5,
      size: 24,
    ),
    SvgIcon(
      SvgIcons.epLocation,
      color: AppColor.shade5,
      size: 24,
    ),
    SvgIcon(
      SvgIcons.wallet1,
      color: AppColor.shade5,
      size: 24,
    ),
  ];
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

  Widget content(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.text2,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: LayoutBuilder(
          builder: (context, size) {
            return AppBar(
              title: Text(
                'Đăng việc nhanh',
                style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
              ),
              centerTitle: true,
              backgroundColor: AppColor.text2,
              shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
              elevation: 8,
              leading: TextButton(
                onPressed: () {
                  navigateTo(bookingRoute);
                },
                child: SvgIcon(
                  SvgIcons.arrowBack,
                  size: 24,
                  color: AppColor.text1,
                ),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thời gian làm việc',
                style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
              ),
              Text(
                'tháng 3, 2022',
                style: AppTextTheme.normalHeaderTitle(AppColor.primary1),
              )
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 24,
              ),
              child: Row(
                children: [
                  pickTimeWork('24', 'MON', 0),
                  pickTimeWork('25', 'TUE', 1),
                  pickTimeWork('26', 'WED', 2),
                  pickTimeWork('27', 'THU', 3),
                  pickTimeWork('28', 'FRI', 4),
                  pickTimeWork('29', 'SAT', 5),
                  pickTimeWork('30', 'SUN', 6),
                ],
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: profileIcons.length,
            itemBuilder: (BuildContext context, iconIndex) {
              return _item(iconIndex,
                  task: fakeProfiles[0], icons: profileIcons);
            },
          ),
          const SizedBox(
            height: 37,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                fakeCode == _code.text
                    ? Text(
                        '190,000 VND',
                        style:
                            AppTextTheme.normalHeaderTitleLine(AppColor.text7),
                      )
                    : const Text(''),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng cộng',
                      style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                    ),
                    Text(
                      '210,000 VND',
                      style: AppTextTheme.mediumBigText(AppColor.text1),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 52,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: AppColor.shade9,
                  padding: const EdgeInsets.only(top: 16, bottom: 16)),
              onPressed: () {},
              child: Text(
                'ĐĂNG VIỆC',
                style: AppTextTheme.headerTitle(AppColor.text2),
              ),
            ),
          )
        ]),
      )),
    );
  }

  Widget _item(int i, {required ProfileModel task, required List icons}) {
    String text = '';
    if (i == 0) {
      text = task.userName;
    } else if (i == 1) {
      text = task.numberPhone;
    } else if (i == 2) {
      text = task.location;
    } else if (i == 3) {
      text = task.hours;
    } else if (i == 4) {
      text = task.week;
    } else if (i == 5) {
      text = task.sizeRoom;
    } else if (i == 6) {
      text = task.pay;
    }

    // print(i++);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          i == 0
              ? yourProfile(
                  task: fakeProfiles[0].title,
                  onPressed: () {
                    navigateTo(editTaskProfileRoute);
                  })
              : Row(),
          i == 3
              ? yourProfile(task: fakeProfiles[0].title2, onPressed: () {})
              : Row(),
          i == 6
              ? yourProfile(
                  task: fakeProfiles[0].title3,
                  onPressed: () {
                    showModalBottomSheet<void>(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColor.text2,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                          height: 192,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Text(
                                    'Hình thức thanh toán',
                                    style: AppTextTheme.mediumHeaderTitle(
                                        AppColor.text1),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: const Size(0, 0),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Tiền mặt',
                                      style: AppTextTheme.mediumBodyText(
                                          AppColor.primary2),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: const Size(0, 0),
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Momo',
                                      style: AppTextTheme.mediumBodyText(
                                          AppColor.text8),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  })
              : Row(),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColor.shade10,
                    borderRadius: BorderRadius.circular(4)),
                padding: const EdgeInsets.all(8.0),
                child: icons[i],
              ),
              const SizedBox(
                width: 16,
              ),
              SizedBox(
                width: 300,
                child: Text(
                  text,
                  style: AppTextTheme.normalText(AppColor.text1),
                  maxLines: 2,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Row yourProfile({required String task, required void Function()? onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          task,
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 16, left: 16),
            backgroundColor: AppColor.shade1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          child: Text(
            'Thay đổi',
            style: AppTextTheme.normalText(AppColor.text3),
          ),
          onPressed: onPressed,
        )
      ],
    );
  }

  Widget pickTimeWork(String title, String content, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: TextButton(
        onPressed: () {
          setState(() {
            valueWeek = index;
          });
        },
        style: TextButton.styleFrom(
          backgroundColor:
              valueWeek == index ? AppColor.primary2 : AppColor.text2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: valueWeek == index
              ? const BorderSide(color: Colors.transparent, width: 1)
              : BorderSide(color: AppColor.primary2),
        ),
        child: SizedBox(
          width: 60,
          height: 80,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              title,
              style: valueWeek == index
                  ? AppTextTheme.mediumHeaderTitle(AppColor.text2)
                  : AppTextTheme.mediumHeaderTitle(AppColor.text1),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              content,
              style: valueWeek == index
                  ? AppTextTheme.mediumHeaderTitle(AppColor.text2)
                  : AppTextTheme.mediumHeaderTitle(AppColor.text1),
            ),
          ]),
        ),
      ),
    );
  }
}

void _fetchDataOnPage() {}
