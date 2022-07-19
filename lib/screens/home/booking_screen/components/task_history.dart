import 'package:flutter/material.dart';
import 'package:hs_user_app/routes/route_names.dart';
import '../../../../core/task/bloc/task_bloc.dart';
import '../../../../core/task/model/task_model.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../../main.dart';
import '../../../../widgets/task_widget.dart';
import '../../../layout_template/content_screen.dart';

final taskHistoryKey = GlobalKey<_TaskHistoryState>();

class TaskHistory extends StatefulWidget {
  const TaskHistory({Key? key}) : super(key: key);

  @override
  State<TaskHistory> createState() => _TaskHistoryState();
}

class _TaskHistoryState extends State<TaskHistory> {
  final PageState _pageState = PageState();
  final _taskBloc = TaskBloc();
  TaskModel? task;
  List<TaskModel> statusess = [];
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
            statusess = tasks.where((e) => e.status >= 2).toList();
            if (statusess.isNotEmpty) {
              return ListView.builder(
                itemCount: statusess.length,
                itemBuilder: (context, index) {
                  return TasksWidget(
                    name: statusess[index].tasker.name,
                    url: statusess[index].tasker.avatar,
                    nameButton: 'Xem chi tiết',
                    task: statusess[index],
                    onPressed: (callBackTask) {
                      setState(() {
                        task = callBackTask;
                        callBackTask?.startTime;
                        callBackTask?.id;
                        callBackTask?.endTime;
                        callBackTask?.date;
                        callBackTask?.address;
                        callBackTask?.note;
                        callBackTask?.checkList;
                        int.parse(callBackTask!.estimateTime);
                        callBackTask.service.options.isNotEmpty
                            ? callBackTask.service.options.first.note
                            : '';
                        callBackTask.service.options.isNotEmpty
                            ? callBackTask.service.options.first.quantity
                            : 0;
                      });
                      navigateTo(viewDetailRoute);
                    },
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'Không có dữ liệu',
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

  void _fetchDataOnPage() {
    _taskBloc.fetchAllData(params: {});
  }
}
