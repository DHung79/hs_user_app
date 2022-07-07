import 'package:flutter/material.dart';
import 'package:hs_user_app/routes/route_names.dart';
import '../../../../core/task/bloc/task_bloc.dart';
import '../../../../core/task/model/task_model.dart';
import '../../../../core/user/user.dart';
import '../../../../main.dart';
import '../../../../widgets/task_widget.dart';

final taskHistoryKey = GlobalKey<_TaskHistoryState>();

class TaskHistory extends StatefulWidget {
  final UserModel user;
  const TaskHistory({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<TaskHistory> createState() => _TaskHistoryState();
}

class _TaskHistoryState extends State<TaskHistory> {
  final _taskBloc = TaskBloc();
  TaskModel? task;
  List<TaskModel> statusess = [];

  @override
  void initState() {
    _fetchDataOnPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return StreamBuilder(
      stream: _taskBloc.allData,
      builder: (context, AsyncSnapshot<ApiResponse<ListTaskModel?>> snapshot) {
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
    );
  }

  void _fetchDataOnPage() {
    _taskBloc.fetchAllData(params: {});
  }
}
