import 'package:flutter/material.dart';
import 'package:hs_user_app/routes/route_names.dart';
import '../../../../core/task/bloc/task_bloc.dart';
import '../../../../core/task/model/task_model.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../../main.dart';
import '../../../../widgets/task_widget.dart';

final taskNowKey = GlobalKey<_TaskNowState>();

class TaskNow extends StatefulWidget {
  final UserModel user;
  const TaskNow({Key? key, required this.user}) : super(key: key);

  @override
  State<TaskNow> createState() => _TaskNowState();
}

class _TaskNowState extends State<TaskNow> {
  final _taskBloc = TaskBloc();
  int value = 0;

  TaskModel? task;
  List<TaskModel> waitings = [];
  List<TaskModel> accepteds = [];
  List<TaskModel> inprocess = [];
  List<TaskModel> statuses = [];

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
          waitings = tasks.where((e) => e.status == 0).toList();

          accepteds = tasks.where((e) {
            return e.status == 1 &&
                DateTime.now().isBefore(readTimestamp2(e.startTime));
          }).toList();
          inprocess = tasks.where((e) {
            return e.status == 1 &&
                DateTime.now().isAfter(readTimestamp2(e.startTime));
          }).toList();
          statuses = [
            inprocess,
            accepteds,
            waitings,
          ].expand((x) => x).toList();
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
                },
              );
            },
          );
        }
        return Center(
            child: CircularProgressIndicator(
          color: AppColor.primary2,
        ));
      },
    );
  }

  DateTime readTimestamp2(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return date;
  }

  void _fetchDataOnPage() {
    _taskBloc.fetchAllData(params: {'user': widget.user.id});
  }
}
