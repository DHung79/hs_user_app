import 'package:flutter/material.dart';
import '../../../../../../core/rate/rate.dart';
import '../../../../../../core/task/task.dart';
import '/main.dart';
import '/core/user/user.dart';
import '/core/authentication/auth.dart';
import 'task_detail_content.dart';

class TaskHistoryScreen extends StatefulWidget {
  final String taskId;
  const TaskHistoryScreen({
    Key? key,
    required this.taskId,
  }) : super(key: key);

  @override
  State<TaskHistoryScreen> createState() => _TaskHistoryScreenState();
}

class _TaskHistoryScreenState extends State<TaskHistoryScreen> {
  final PageState _pageState = PageState();
  final _userBloc = UserBloc();
  final _taskBloc = TaskBloc();

  bool _isTaskerInfo = false;
  List<RateModel>? _listRateModel;

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
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
            child: snapshot.hasData
                ? _buildContent(snapshot.data!)
                : const SizedBox(),
          );
        },
      ),
    );
  }

  _buildContent(UserModel user) {
    return StreamBuilder(
      stream: _taskBloc.taskData,
      builder: (context, AsyncSnapshot<ApiResponse<TaskModel?>> snapshot) {
        if (snapshot.hasData) {
          final task = snapshot.data!.model!;
          return _isTaskerInfo
              ? _buildDetail(
                  user: user,
                  task: task,
                )
              : TaskDetailContent(
                  user: user,
                  task: task,
                  onChangeContent: () {
                    setState(() {
                      _isTaskerInfo = !_isTaskerInfo;
                    });
                  },
                );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildDetail({
    required UserModel user,
    required TaskModel task,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.shadow.withOpacity(0.16),
                blurRadius: 16,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButtonTheme.fillRounded(
                constraints: const BoxConstraints(minHeight: 56, maxWidth: 40),
                color: AppColor.transparent,
                highlightColor: AppColor.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SvgIcon(
                    SvgIcons.arrowBack,
                    size: 24,
                    color: AppColor.black,
                  ),
                ),
                onPressed: () {
                  if (_isTaskerInfo) {
                    navigateTo(taskBookedRoute);
                  } else {
                    setState(() {
                      _isTaskerInfo = !_isTaskerInfo;
                    });
                  }
                },
              ),
              Center(
                child: Text(
                  'Thông tin người làm',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                ),
              ),
              AppButtonTheme.fillRounded(
                constraints: const BoxConstraints(maxWidth: 40),
                color: Colors.transparent,
                highlightColor: AppColor.white,
                child: const SizedBox(),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipOval(
                      child: task.tasker.avatar.isNotEmpty
                          ? Image.network(
                              task.tasker.avatar,
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
                    task.tasker.name,
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
                            style:
                                AppTextTheme.normalHeaderTitle(AppColor.text1),
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
                      _profileTasker(title: 'Tham gia từ', profile: '3/2019'),
                      _linevertical(context),
                      _profileTasker(title: 'Công việc', profile: '320'),
                      _linevertical(context),
                      _profileTasker(
                          title: 'Đánh giá tích cực', profile: '90%'),
                    ],
                  ),
                ),
                _titleMedal(),
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
          ),
        ),
      ],
    );
  }

  Widget _profileTasker({required String title, required String profile}) {
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

  Container _linevertical(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 42),
      width: 1,
      height: MediaQuery.of(context).size.height,
      color: AppColor.shade1,
    );
  }

  Padding _titleMedal() {
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

  _fetchDataOnPage() {
    _taskBloc.fetchDataById(widget.taskId);
  }
}
