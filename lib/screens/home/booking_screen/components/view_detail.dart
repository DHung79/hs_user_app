import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import 'package:hs_user_app/theme/svg_constants.dart';

import '../../../../core/authentication/bloc/authentication/authentication_event.dart';
import '../../../../core/user/bloc/user_bloc.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../layout_template/content_screen.dart';

class ViewDetail extends StatefulWidget {
  const ViewDetail({Key? key}) : super(key: key);

  @override
  State<ViewDetail> createState() => _ViewDetailState();
}

class _ViewDetailState extends State<ViewDetail> {
  final PageState _pageState = PageState();
  final _userBloc = UserBloc();
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.focused,
      MaterialState.selected,
    };
    if (states.any(interactiveStates.contains)) {
      return AppColor.shade9;
    }
    return AppColor.others1;
  }

  bool isShowListTask = false;
  int count = 0;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    _userBloc.getProfile();
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
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
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
            child: snapshot.hasData ? content(snapshot) : const SizedBox(),
          );
        },
      ),
    );
  }

  Widget content(AsyncSnapshot<UserModel> snapshot) {
    final user = snapshot.data;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
        elevation: 16,
        title: Text(
          'Chi tiết công việc',
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            navigateTo(bookingRoute);
          },
          child: SvgIcon(
            SvgIcons.arrowBack,
            color: AppColor.text1,
            size: 24,
          ),
        ),
      ),
      body: Column(children: [
        profile(user!),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              yourprofile(user),
              detailtask(context),
              payment(context),
              buttonreview()
            ],
          ),
        )
      ]),
    );
  }

  Widget buttonreview() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 52,
      child: TextButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: AppColor.primary2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4))),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgIcon(
                SvgIcons.starOutline,
                color: AppColor.text2,
                size: 24,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                'Đánh giá',
                style: AppTextTheme.headerTitle(AppColor.text2),
              )
            ],
          )),
    );
  }

  Padding payment(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.text2,
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(79, 117, 140, 0.16),
                  blurRadius: 16,
                  blurStyle: BlurStyle.outer)
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hình thức thanh toán',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColor.shade1,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  child: Text(
                    'Thành công',
                    style: AppTextTheme.mediumHeaderTitle(AppColor.shade9),
                  ),
                )
              ],
            ),
            Container(
              color: AppColor.shade1,
              height: 1,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 12),
            ),
            icontitle(icon: SvgIcons.wallet1, text: 'MOMO, *******756'),
            const SizedBox(
              height: 12,
            ),
            icontitle(icon: SvgIcons.dollar1, text: '210,000 VND'),
            const SizedBox(
              height: 12,
            ),
            icontitle(icon: SvgIcons.tag1, text: 'JOYTECH07'),
          ],
        ),
      ),
    );
  }

  Padding detailtask(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColor.text2,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                blurStyle: BlurStyle.outer,
                color: Color.fromRGBO(79, 117, 140, 0.16),
                blurRadius: 16.0)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chi tiet cong viec',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.shade1,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  child: Text(
                    'Thanh cong',
                    style: AppTextTheme.mediumHeaderTitle(AppColor.shade9),
                  ),
                )
              ],
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: AppColor.shade1,
              margin: const EdgeInsets.symmetric(vertical: 12),
            ),
            icontitle(
                icon: SvgIcons.accessTime, text: '3 tiếng, 4:30 pm - 7:30 pm '),
            const SizedBox(
              height: 10,
            ),
            icontitle(icon: SvgIcons.calenderToday, text: 'thứ 3, 24/6/2022'),
            const SizedBox(
              height: 10,
            ),
            icontitle(icon: SvgIcons.dollar1, text: '210,000 VND'),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: AppColor.shade1,
              margin: const EdgeInsets.symmetric(vertical: 12),
            ),
            Text(
              'Ghi chú cho người giúp việc',
              style: AppTextTheme.mediumBodyText(AppColor.primary1),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColor.shade1,
              ),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '“Đừng quên khóa cửa trước khi ra về”',
                style: AppTextTheme.normalText(AppColor.text1),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColor.shade1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Danh sách nhắc việc',
                  style: AppTextTheme.mediumBodyText(AppColor.primary1),
                ),
                Row(
                  children: [
                    Text(
                      count.toString() + '/ 4',
                      style: AppTextTheme.normalText(AppColor.text3),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(24, 24),
                          fixedSize: const Size(24, 24)),
                      onPressed: () {
                        setState(() {
                          isShowListTask = !isShowListTask;
                        });
                      },
                      child: SvgIcon(
                        SvgIcons.expandMore,
                        size: 24,
                        color: AppColor.text1,
                      ),
                    )
                  ],
                )
              ],
            ),
            isShowListTask
                ? Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColor.shade1,
                    ),
                    child: Column(
                      children: [
                        checkbox(
                            isCheck: isChecked1,
                            onChanged: (value) {
                              setState(() {
                                isChecked1 = value!;
                                if (isChecked1) {
                                  count++;
                                } else {
                                  count--;
                                }
                              });
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        checkbox(
                            isCheck: isChecked2,
                            onChanged: (value) {
                              setState(() {
                                isChecked2 = value!;
                                if (isChecked2) {
                                  count++;
                                } else {
                                  count--;
                                }
                              });
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        checkbox(
                            isCheck: isChecked3,
                            onChanged: (value) {
                              setState(() {
                                isChecked3 = value!;
                                if (isChecked3) {
                                  count++;
                                } else {
                                  count--;
                                }
                              });
                            }),
                      ],
                    ),
                  )
                : const SizedBox(),
            Container(
              color: AppColor.shade1,
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 1,
              width: MediaQuery.of(context).size.width,
            ),
            Text(
              'Chụp hình thành quả',
              style: AppTextTheme.mediumBodyText(AppColor.primary1),
            ),
            const SizedBox(
              height: 12,
            ),
            listimage(name: 'Trước'),
            const SizedBox(
              height: 12,
            ),
            listimage(name: 'Sau'),
          ],
        ),
      ),
    );
  }

  Column listimage({required String name}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTextTheme.mediumBodyText(AppColor.text1),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 100,
          child: ListView(scrollDirection: Axis.horizontal, children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 16),
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Padding checkbox(
      {required bool isCheck, required void Function(bool?)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: Checkbox(
              activeColor: AppColor.shade9,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: isCheck,
              onChanged: onChanged,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            'Cho cun an',
            style: AppTextTheme.normalText(AppColor.text1),
          )
        ],
      ),
    );
  }

  Padding yourprofile(UserModel user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.text2,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(79, 117, 140, 0.16),
                blurRadius: 16,
                blurStyle: BlurStyle.outer,
              ),
            ]),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin của bạn',
              style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: AppColor.shade1,
              margin: const EdgeInsets.symmetric(vertical: 12),
            ),
            Text(
              'Địa chỉ không tên 1',
              style: AppTextTheme.normalText(AppColor.text1),
            ),
            const SizedBox(
              height: 12,
            ),
            icontitle(
              icon: SvgIcons.epLocation,
              text: user.address,
            ),
            const SizedBox(
              height: 12,
            ),
            icontitle(
              icon: SvgIcons.viewDetails,
              text: user.address,
            ),
            const SizedBox(
              height: 12,
            ),
            icontitle(
              icon: SvgIcons.telephone1,
              text: user.phoneNumber,
            ),
          ],
        ),
      ),
    );
  }

  Row icontitle({required SvgIconData? icon, required String text}) {
    return Row(
      children: [
        SvgIcon(
          icon,
          color: AppColor.shade5,
          size: 24,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: AppTextTheme.normalText(AppColor.text1),
        )
      ],
    );
  }

  Padding profile(UserModel user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 80,
                height: 80,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                    ),
                    onPressed: () {
                      navigateTo(profileTaskersRoute);
                    },
                    child: Row(
                      children: [
                        Text(
                          'Xem thêm',
                          style: AppTextTheme.mediumBodyText(AppColor.primary2),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Transform(
                          transform: Matrix4.identity()
                            ..rotateZ(3.1415927 / 180 * 180),
                          alignment: FractionalOffset.center,
                          child: SvgIcon(
                            SvgIcons.arrowBack,
                            color: AppColor.primary2,
                            size: 24,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurStyle: BlurStyle.outer,
                  color: Color.fromRGBO(79, 117, 140, 0.16),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Row(
              children: [
                SvgIcon(
                  SvgIcons.star1,
                  color: AppColor.primary2,
                  size: 24,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  '5.0',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _fetchDataOnPage() {
    _userBloc.getProfile();
  }
}
