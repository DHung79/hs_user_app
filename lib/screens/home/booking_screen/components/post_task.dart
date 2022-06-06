import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../../theme/svg_constants.dart';
import '../../../layout_template/content_screen.dart';

class PostTask extends StatefulWidget {
  const PostTask({Key? key}) : super(key: key);

  @override
  State<PostTask> createState() => _PostTaskState();
}

class _PostTaskState extends State<PostTask> {
  final PageState _pageState = PageState();
  int valueWeek = 0;
  int value = 0;
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

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
            child: content(), // child: content(context),
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
          );
        },
      ),
    );
  }

  Scaffold content() {
    return Scaffold(
      backgroundColor: AppColor.text2,
      appBar: AppBar(
        elevation: 16,
        shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
        backgroundColor: Colors.white,
        leading: BackButton(
            color: AppColor.text1,
            onPressed: () {
              navigateTo(homeRoute);
            }),
        title: Text(
          'Dọn dẹp nhà cửa',
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
        centerTitle: true,
      ),
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Địa điểm',
                style: AppTextTheme.mediumHeaderTitle(AppColor.text1)),
            const SizedBox(
              height: 24,
            ),
            location(),
            const SizedBox(
              height: 32,
            ),
            Text('Thời lượng',
                style: AppTextTheme.mediumHeaderTitle(AppColor.text1)),
            const SizedBox(
              height: 24,
            ),
            room(3, 100, 3, 0),
            const SizedBox(
              height: 24,
            ),
            room(4, 150, 4, 1),
            const SizedBox(
              height: 24,
            ),
            room(3, 109, 2, 2),
            const SizedBox(
              height: 32,
            ),
            timeWork(),
          ]),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
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
        // const SizedBox(
        //   height: 12,
        // ),
        noteUser(),
        contentSwitch(),
        isSwitched == false
            ? const SizedBox(
                height: 71,
              )
            : Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgIcon(
                                SvgIcons.add,
                                color: AppColor.text1,
                                size: 24,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Thêm mới',
                                style: AppTextTheme.normalText(AppColor.text3),
                              ),
                            ],
                          ),
                          SvgIcon(
                            SvgIcons.bxTrashAlt,
                            size: 24,
                            color: AppColor.text1,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgIcon(
                                SvgIcons.add,
                                color: AppColor.text1,
                                size: 24,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Thêm mới',
                                style: AppTextTheme.normalText(AppColor.text3),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
        payButton(),
      ]),
    );
  }

  Container noteUser() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(children: [
        timeStart(),
        const SizedBox(
          height: 51,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ghi chú cho người làm',
              style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
            ),
            SizedBox(
              height: 144,
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: TextField(
                  style: AppTextTheme.normalText(AppColor.text1),
                  maxLines: 5,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.text7, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.text7, width: 1.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.text7, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.text7, width: 1.0))),
                  cursorColor: AppColor.text1,
                ),
              ),
            )
          ],
        )
      ]),
    );
  }

  Container payButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColor.shade9,
          padding: const EdgeInsets.all(16),
        ),
        onPressed: () {
          navigateTo(confirmPageRoute);
        },
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            '200.000 VNĐ/2h',
            style: AppTextTheme.headerTitle(AppColor.text2),
          ),
          Text(
            'TIẾP THEO',
            style: AppTextTheme.headerTitle(AppColor.text2),
          )
        ]),
      ),
    );
  }

  Container contentSwitch() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Danh sách công việc',
                style: AppTextTheme.normalHeaderTitle(AppColor.text1)),
            Text(
              'Tạo danh sách công việc cho người làm',
              style: AppTextTheme.subText(AppColor.text3),
            )
          ],
        ),
        Transform.scale(
            scale: 1,
            child: Switch(
              onChanged: toggleSwitch,
              value: isSwitched,
              activeColor: AppColor.primary2,
              activeTrackColor: AppColor.secondary4,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color.fromRGBO(33, 33, 33, 0.08),
            ))
      ]),
    );
  }

  Container timeStart() {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.24),
            blurStyle: BlurStyle.outer,
            blurRadius: 10,
            spreadRadius: 4)
      ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: [
                SvgIcon(
                  SvgIcons.accessTime,
                  color: AppColor.primary1,
                  size: 24,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Giờ bắt đầu',
                  style: AppTextTheme.normalHeaderTitle(AppColor.text1),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.shade1,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 38, right: 38),
              child: Text(
                '8:30 AM',
                style: AppTextTheme.bigText(AppColor.text1),
              ),
            ),
          )
        ]),
      ),
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

  Row timeWork() {
    return Row(
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
    );
  }

  Widget room(int time, int sizeRoom, int room, int index) {
    return InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            value = index;
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            // color: Colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: (value == index)
                ? null
                : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.24),
                      blurStyle: BlurStyle.outer,
                      blurRadius: 10,
                      // spreadRadius: 4),
                    ),
                  ],
            border: (value == index)
                ? Border.all(width: 2, color: AppColor.primary2)
                : Border.all(width: 2, color: Colors.transparent),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  '$time tiếng',
                  style: AppTextTheme.normalHeaderTitle(AppColor.primary1),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '$sizeRoom m2 / $room phòng',
                  style: AppTextTheme.normalText(AppColor.text7),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ));
  }

  TextButton location() {
    return TextButton(
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: () {
        navigateTo(gpsPageRoute);
      },
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.24),
                blurStyle: BlurStyle.outer,
                blurRadius: 10,
                spreadRadius: 4),
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 19, bottom: 19, right: 16, left: 20.5),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: SvgIcon(
                SvgIcons.locationOn,
                color: AppColor.primary1,
                size: 24,
              ),
            ),
            const SizedBox(
              width: 14.5,
            ),
            Text('Chọn địa chỉ',
                style: AppTextTheme.normalText(AppColor.text3)),
          ]),
        ),
      ),
    );
  }
}

void _fetchDataOnPage() {}
