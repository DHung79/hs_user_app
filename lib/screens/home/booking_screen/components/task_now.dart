import 'package:flutter/material.dart';

import '../../../../core/task/bloc/task_bloc.dart';
import '../../../../core/task/model/task_model.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../../main.dart';
import '../../../../widgets/button_widget2.dart';
import '../../../../widgets/task_widget.dart';
import '../../../layout_template/content_screen.dart';

class TaskNow extends StatefulWidget {
  const TaskNow({Key? key}) : super(key: key);

  @override
  State<TaskNow> createState() => _TaskNowState();
}

class _TaskNowState extends State<TaskNow> {
  final PageState _pageState = PageState();
  final _taskBloc = TaskBloc();
  TaskModel? task;

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

  Widget content() {
    return Scaffold(
      backgroundColor: AppColor.text2,
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: _taskBloc.allData,
        builder:
            (context, AsyncSnapshot<ApiResponse<ListTaskModel?>> snapshot) {
          if (snapshot.hasData) {
            final tasks = snapshot.data!.model!.records;

            return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  if (tasks[index].status >= 0 && tasks[index].status < 3) {
                    return TasksWidget(
                      nameButton: 'Xem chi tiết',
                      task: tasks[index],
                      name: tasks[index].tasker.name,
                      url: tasks[index].tasker.avatar,
                      onPressed: (model) {
                        _showDialog();
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                });
          }
          return Center(
              child: CircularProgressIndicator(
            color: AppColor.primary2,
          ));
        },
      ),
    );
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Container(
                width: 334,
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Đã nhận việc',
                        style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          color: AppColor.shade1,
                          height: 1,
                          margin: const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset(
                              'assets/images/logo.png',
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Đã có người nhận công việc của bạn',
                          style: AppTextTheme.normalText(AppColor.text1),
                        ),
                        Container(
                          height: 8,
                          margin: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        ButtonWidget2(
                          name: 'Hiểu rồi',
                          backgroundColor: AppColor.primary2,
                          onPressed: () {},
                          style: AppTextTheme.headerTitle(AppColor.text2),
                          side: BorderSide.none,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ButtonWidget2(
                          name: 'Xem công việc',
                          backgroundColor: AppColor.shade1,
                          onPressed: () {},
                          style: AppTextTheme.headerTitle(AppColor.text3),
                          side: BorderSide.none,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  void _fetchDataOnPage() {
    _taskBloc.fetchAllData(params: {});
  }
}
