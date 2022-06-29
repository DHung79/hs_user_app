import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import 'package:hs_user_app/screens/home/booking_screen/components/task_history.dart';
import 'package:hs_user_app/theme/svg_constants.dart';
import 'package:intl/intl.dart';

import '../../../../core/authentication/bloc/authentication/authentication_event.dart';
import '../../../../core/task/bloc/task_bloc.dart';
import '../../../../core/task/model/task_model.dart';
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
  final _taskBloc = TaskBloc();
  bool _mainPage = true;
  TaskModel? _editModel;
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
  List rates = [
    SvgIcon(SvgIcons.star1, size: 24),
    SvgIcon(SvgIcons.star1, size: 24),
    SvgIcon(SvgIcons.star1, size: 24),
    SvgIcon(SvgIcons.star1, size: 24),
    SvgIcon(SvgIcons.star1, size: 24),
  ];
  @override
  void initState() {
    _editModel = taskHistoryKey.currentState?.task;
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
          _mainPage ? 'Chi tiết công việc' : 'Thông tin người làm',
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            setState(() {
              _mainPage ? navigateTo(bookingRoute) : _mainPage = !_mainPage;
            });
          },
          child: SvgIcon(
            SvgIcons.arrowBack,
            color: AppColor.text1,
            size: 24,
          ),
        ),
      ),
      body: _mainPage
          ? Column(
              children: [
                profile(),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      yourProfile(user!),
                      detailTask(),
                      payment(context),
                      buttonReview()
                    ],
                  ),
                )
              ],
            )
          : SizedBox(
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
                              style: AppTextTheme.normalHeaderTitle(
                                  AppColor.text1),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        profileTasker(title: 'Tham gia từ', profile: '3/2019'),
                        linevertical(context),
                        profileTasker(title: 'Công việc', profile: '320'),
                        linevertical(context),
                        profileTasker(
                            title: 'Đánh giá tích cực', profile: '90%'),
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
                            style:
                                AppTextTheme.mediumHeaderTitle(AppColor.text1),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            constraints: const BoxConstraints(
                                minHeight: 400, maxHeight: 600),
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                review(
                                  comment:
                                      '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                                  user: 'Ngo Anh Duong',
                                  rate: '4.5',
                                ),
                                review(
                                  comment:
                                      '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                                  user: 'Ngo Anh Duong',
                                  rate: '4.5',
                                ),
                                review(
                                  comment:
                                      '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                                  user: 'Ngo Anh Duong',
                                  rate: '4.5',
                                ),
                                review(
                                  comment:
                                      '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                                  user: 'Ngo Anh Duong',
                                  rate: '4.5',
                                ),
                                review(
                                  comment:
                                      '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                                  user: 'Ngo Anh Duong',
                                  rate: '4.5',
                                ),
                                review(
                                  comment:
                                      '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                                  user: 'Ngo Anh Duong',
                                  rate: '4.5',
                                ),
                                review(
                                  comment:
                                      '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                                  user: 'Ngo Anh Duong',
                                  rate: '4.5',
                                ),
                                review(
                                  comment:
                                      '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                                  user: 'Ngo Anh Duong',
                                  rate: '4.5',
                                ),
                                review(
                                  comment:
                                      '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                                  user: 'Ngo Anh Duong',
                                  rate: '4.5',
                                ),
                                review(
                                  comment:
                                      '“Bạn làm rất tốt! Xứng đáng tăng lương”',
                                  user: 'Ngo Anh Duong',
                                  rate: '4.5',
                                ),
                                review(
                                  comment:
                                      '“Bạn làm rất tốt! Xứng đáng tăng lương”',
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

  Scaffold content1(BuildContext context) {
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

  Widget buttonReview() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 52,
      child: TextButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: AppColor.primary2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4))),
          onPressed: _showMaterialDialog,
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

  Widget payment(BuildContext context) {
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

  Widget detailTask() {
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
              blurRadius: 16.0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chi tiết công việc',
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
                icon: SvgIcons.accessTime,
                text:
                    '${_editModel?.estimateTime} tiếng, ${readTimestamp(_editModel?.startTime)} - ${readTimestampEnd(_editModel?.startTime)} '),
            const SizedBox(
              height: 10,
            ),
            icontitle(
                icon: SvgIcons.calenderToday,
                text: readTimestamp2(_editModel?.date)),
            const SizedBox(
              height: 10,
            ),
            icontitle(
                icon: SvgIcons.dollar1, text: '${_editModel?.totalPrice}'),
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
                _editModel?.note ?? '',
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
                      count.toString() + ' / ${_editModel?.checkList.length}',
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
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return checkbox(
                          isCheck: _editModel!.checkList[index].status,
                          name: _editModel!.checkList[index].name,
                        );
                      },
                      itemCount: _editModel?.checkList.length,
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

  Widget listimage({required String name}) {
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
          child: ListView(
            physics: const ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
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
            ],
          ),
        ),
      ],
    );
  }

  Widget checkbox({required bool isCheck, required String name}) {
    if (isCheck) {
      count++;
    }
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          isCheck
              ? SvgIcon(
                  SvgIcons.checkBox,
                  size: 24,
                  color: AppColor.shade9,
                )
              : SvgIcon(SvgIcons.checkBoxOutlinedBlank,
                  size: 24, color: AppColor.others1),
          const SizedBox(
            width: 15,
          ),
          Text(
            name,
            style: AppTextTheme.normalText(AppColor.text1),
          )
        ],
      ),
    );
  }

  Widget yourProfile(UserModel user) {
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

  Widget icontitle({required SvgIconData? icon, required String text}) {
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

  Widget profile() {
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
              SizedBox(
                width: 80,
                height: 80,
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(_editModel?.tasker.avatar ?? ''),
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
                    _editModel?.tasker.name ?? '',
                    style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                    ),
                    onPressed: () {
                      setState(() {
                        _mainPage = !_mainPage;
                      });
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
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.outer,
                  color: AppColor.shadow.withOpacity(0.16),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Row(
              children: [
                SvgIcon(
                  SvgIcons.star1,
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

  String readTimestamp2(int? timestamp) {
    var format = DateFormat('E, dd/MM/yyyy');
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp ?? 0 * 1000);
    var time = '';
    time = format.format(date);

    return time;
  }

  String readTimestamp(int? timestamp) {
    var format = DateFormat('HH:mm');
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp ?? 0 * 1000);
    var time = '';
    time = format.format(date);

    return time;
  }

  String readTimestampEnd(int? timestamp) {
    var format = DateFormat('HH:mm');
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp ?? 0 * 1000);
    var time = '';
    time = format.format(
        date.add(Duration(hours: int.parse(_editModel?.estimateTime ?? '0'))));

    return time;
  }

  Widget profileTasker({required String title, required String profile}) {
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

  Container linevertical(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 42),
      width: 1,
      height: MediaQuery.of(context).size.height,
      color: AppColor.shade1,
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

  Widget listmedal() {
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

  Widget review(
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

  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        backgroundColor: AppColor.inactive2,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return rates[index];
                        },
                        itemCount: rates.length,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 130,
                      child: TextField(
                        maxLines: 5,
                        style: AppTextTheme.mediumBodyText(AppColor.text3),
                        cursorColor: AppColor.text3,
                        decoration: InputDecoration(
                          fillColor: AppColor.shade1,
                          filled: true,
                          disabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.text7, width: 2),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.text7, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.text7, width: 2),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 8,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ]),
            ),
          );
        });
  }

  _fetchDataOnPage() {
    _userBloc.getProfile();
    _taskBloc.fetchAllData(params: {});
  }
}