import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/rate/rate.dart';
import '../../../../../../core/task/task.dart';
import '/main.dart';
import '/core/user/user.dart';
import '/core/authentication/auth.dart';

class TaskDetail extends StatefulWidget {
  
  const TaskDetail({Key? key}) : super(key: key);

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  final PageState _pageState = PageState();
  final _userBloc = UserBloc();
  final _taskBloc = TaskBloc();
  final _rateBloc = RateBloc();
  bool _mainPage = true;
  TaskModel? _editModel;
  List<TaskModel>? editModel;
  List<RateModel>? _listRateModel;
  final EditRateModel _editRateModel = EditRateModel.fromModel(null);
  int? value;
  double rate = 0;
  final TextEditingController _controller = TextEditingController();

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
        shadowColor: AppColor.shadow.withOpacity(0.16),
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
                _editModel?.tasker.avatar == '' ? profile() : const SizedBox(),
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
          : StreamBuilder(
              stream: _rateBloc.allData,
              builder: (context,
                  AsyncSnapshot<ApiResponse<ListRateModel?>> snapshot) {
                _listRateModel = snapshot.data?.model!.records;

                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipOval(
                            child: _editModel!.tasker.avatar.isNotEmpty
                                ? Image.network(
                                    _editModel!.tasker.avatar,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/images/logo.png",
                                    width: 100,
                                    height: 100,
                                  ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          _editModel?.tasker.name ?? '',
                          style: AppTextTheme.mediumBigText(AppColor.text3),
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
                            padding:
                                const EdgeInsets.only(top: 4.0, bottom: 16),
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
                            profileTasker(
                                title: 'Tham gia từ', profile: '3/2019'),
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
                                style: AppTextTheme.mediumHeaderTitle(
                                    AppColor.text1),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                constraints: const BoxConstraints(
                                    minHeight: 400, maxHeight: 600),
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: _listRateModel?.length,
                                  itemBuilder: (context, index) {
                                    return review(
                                      comment: _listRateModel?[index]
                                              .comments
                                              .first
                                              .description ??
                                          '',
                                      user: _listRateModel?[index]
                                              .comments
                                              .first
                                              .description ??
                                          '',
                                      rate: _listRateModel?[index]
                                              .comments
                                              .first
                                              .rating
                                              .toString() ??
                                          '',
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
    );
  }

  Widget buttonReview() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 52,
      child: _editModel != null
          ? TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: AppColor.primary2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {
                setState(() {
                  rate = 0;
                  _controller.text = '';
                });
                _showMaterialDialog();
              },
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
              ))
          : TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: AppColor.text2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              onPressed: () {
                _taskBloc.deleteTask(id: editModel?[value!].id).then(
                  (value) async {
                    AuthenticationBlocController()
                        .authenticationBloc
                        .add(GetUserData());
                    navigateTo(homeRoute);
                    JTToast.successToast(
                        message: ScreenUtil.t(I18nKey.updateSuccess)!);
                  },
                ).onError((ApiError error, stackTrace) {
                  setState(() {});
                }).catchError(
                  (error, stackTrace) {
                    setState(() {});
                  },
                );
              },
              child: Text(
                'Hủy công việc',
                style: AppTextTheme.headerTitle(AppColor.others1),
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
            boxShadow: [
              BoxShadow(
                  color: AppColor.shadow.withOpacity(0.16),
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
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: AppColor.shadow.withOpacity(0.16),
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
                    'Đang diễn ra',
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
                    '${_editModel?.estimateTime ?? editModel?[value!].estimateTime} tiếng, ${readTimestamp(_editModel?.startTime ?? editModel?[value!].startTime ?? 0)} - ${readTimestampEnd(_editModel?.startTime ?? editModel?[value!].startTime ?? 0)} '),
            const SizedBox(
              height: 10,
            ),
            icontitle(
                icon: SvgIcons.calenderToday,
                text: readTimestamp2(
                    _editModel?.date ?? editModel?[value!].date)),
            const SizedBox(
              height: 10,
            ),
            icontitle(
                icon: SvgIcons.dollar1,
                text:
                    '${_editModel?.totalPrice ?? editModel?[value!].totalPrice}'),
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
                _editModel?.note ?? editModel?[value!].note ?? '',
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
                      count.toString() +
                          ' / ${_editModel?.checkList.length ?? editModel?[value!].checkList.length}',
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
                ? const SizedBox()
                : Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColor.text2,
                    ),
                    constraints: const BoxConstraints(minHeight: 0.0),
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return checkbox(
                          isCheck: _editModel?.checkList[index].status ??
                              editModel?[value!].checkList[index].status ??
                              false,
                          name: _editModel?.checkList[index].name ??
                              editModel![value!].checkList[index].name,
                        );
                      },
                      itemCount: _editModel?.checkList.length ??
                          editModel?[value!].checkList.length,
                    ),
                  ),
            if (_editModel != null)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
          boxShadow: [
            BoxShadow(
              color: AppColor.shadow.withOpacity(0.16),
              blurRadius: 16,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
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
                child: ClipOval(
                  child: _editModel!.tasker.avatar.isNotEmpty
                      ? Image.network(
                          _editModel!.tasker.avatar,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/logo.png",
                          width: 100,
                          height: 100,
                        ),
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
                    editModel?[value!].tasker.name ??
                        _editModel?.tasker.name ??
                        '',
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
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp ?? 0);
    var time = '';
    time = format.format(date);

    return time;
  }

  String readTimestamp(int? timestamp) {
    var format = DateFormat('HH:mm');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp!);
    var time = '';
    time = format.format(date);

    return time;
  }

  String readTimestampEnd(int? timestamp) {
    var format = DateFormat('HH:mm');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp!);
    var time = '';
    time = format.format(date.add(Duration(
        hours: int.parse(_editModel?.estimateTime ??
            editModel?[value!].estimateTime ??
            '0'))));

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
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(_editModel?.tasker.avatar ?? ''),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        editModel?[value!].tasker.name ??
                            _editModel?.tasker.name ??
                            '',
                        style: AppTextTheme.mediumBigText(AppColor.text1),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RatingBar(
                          itemSize: 24,
                          initialRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ratingWidget: RatingWidget(
                            full: SvgIcon(SvgIcons.starReview,
                                size: 12, color: AppColor.primary2),
                            half: SvgIcon(SvgIcons.starHalfReview, size: 12),
                            empty: const Icon(
                              Icons.star_outline_outlined,
                              size: 12,
                            ),
                          ),
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          onRatingUpdate: (rating) {
                            setState(() {
                              rate = rating;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            rate.toString(),
                            style:
                                AppTextTheme.normalHeaderTitle(AppColor.text1),
                          ),
                        ),
                      ],
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
                        controller: _controller,
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        onPressed: _createRate,
                        child: Text(
                          'Gửi đánh giá',
                          style: AppTextTheme.headerTitle(AppColor.text2),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: AppColor.primary2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  _createRate() {
    setState(() {
      _editRateModel.comments = [
        CommentsModel.fromJson(
            {'rating': rate, 'description': _controller.text})
      ];
    });
    _rateBloc.createRate(editModel: _editRateModel).then(
      (value) async {
        AuthenticationBlocController().authenticationBloc.add(GetUserData());
        Navigator.pop(context);

        JTToast.successToast(message: ScreenUtil.t(I18nKey.updateSuccess)!);
      },
    ).onError((ApiError error, stackTrace) {
      setState(() {});
    }).catchError(
      (error, stackTrace) {
        setState(() {});
      },
    );
  }

  _fetchDataOnPage() {
    _userBloc.getProfile();
    _taskBloc.fetchAllData(params: {});
    _rateBloc.fetchAllData(params: {});
  }
}

class Comment {
  final String rating;
  final String description;

  Comment(this.rating, this.description);
}
