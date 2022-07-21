import 'package:flutter/material.dart';
import 'package:hs_user_app/routes/route_names.dart';

import '../../../../core/task/bloc/task_bloc.dart';
import '../../../../core/task/model/task_model.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../../main.dart';
import '../../../../widgets/task_widget.dart';
import '../../../layout_template/content_screen.dart';

final taskNowKey = GlobalKey<_TaskNowState>();

class TaskNow extends StatefulWidget {
  const TaskNow({Key? key}) : super(key: key);

  @override
  State<TaskNow> createState() => _TaskNowState();
}

class _TaskNowState extends State<TaskNow> {
  final PageState _pageState = PageState();
  final _taskBloc = TaskBloc();
  int value = 0;

  TaskModel? task;
  List<TaskModel> waitings = [];
  List<TaskModel> accepteds = [];
  List<TaskModel> inprocess = [];
  List<TaskModel> statuses = [];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
      onFetch: () {
        // _fetchDataOnPage();
      },
      appBarHeight: 0,
      child: FutureBuilder(
        future: _pageState.currentUser,
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            return PageContent(
              child: content(), // child: content(context),
              pageState: _pageState,
              onFetch: () {
                _fetchDataOnPage(user: snapshot.data!);
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: AppColor.primary2,
            ),
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
            waitings = tasks.where((e) => e.status == 0).toList();

            accepteds = tasks.where((e) {
              logDebug(readTimestamp2(e.startTime));
              return e.status == 1 &&
                  DateTime.now().isBefore(readTimestamp2(e.startTime));
            }).toList();
            inprocess = tasks.where((e) {
              return e.status == 1 &&
                  DateTime.now().isAfter(readTimestamp2(e.startTime));
            }).toList();
            logDebug(
                'inprocess ${inprocess.length}\n accepteds ${accepteds.length}\n waitings ${waitings.length}');
            statuses = [
              inprocess,
              accepteds,
              waitings,
            ].expand((x) => x).toList();
            if (statuses.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: statuses.length,
                itemBuilder: (context, index) {
                  return TasksWidget(
                    nameButton: 'Xem chi tiết',
                    task: statuses[index],
                    name: statuses[index].tasker.name,
                    url: statuses[index].tasker.avatar,
                    onPressed: (model) {
                      value = index;
                      navigateTo(viewDetailRoute);
                      task = model;
                    },
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  "Không có dữ liệu",
                  style: AppTextTheme.mediumHeaderTitle(AppColor.primary2),
                ),
              );
            }
          }
          return Center(
              child: CircularProgressIndicator(
            color: AppColor.primary2,
          ));
        },
      ),
    );
  }

  DateTime readTimestamp2(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return date;
  }

  void _fetchDataOnPage({UserModel? user}) {
    _taskBloc.fetchAllData(params: {'user': user?.id});
  }
}
