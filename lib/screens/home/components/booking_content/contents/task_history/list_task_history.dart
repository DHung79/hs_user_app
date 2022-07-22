import 'package:flutter/material.dart';
import '../../../../../../core/task/task.dart';
import '../../../../../../widgets/task_widget/task_widget.dart';
import '/main.dart';
import '/core/user/user.dart';

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
                final task = statusess[index];
                final double padding = index == 0 ? 14 : 12;
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: padding,
                    horizontal: 16,
                  ),
                  child: TaskTab(
                    tab: 2,
                    nameButton: 'Xem chi tiết',
                    task: task,
                    onPressed: (task) {
                      navigateTo(taskHistoryRoute + '/${task!.id}');
                    },
                  ),
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
        return const JTIndicator();
      },
    );
  }

  void _fetchDataOnPage() {
    _taskBloc.fetchAllData(params: {});
  }
}
