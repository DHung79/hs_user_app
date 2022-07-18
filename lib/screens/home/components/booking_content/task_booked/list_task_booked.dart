import 'package:flutter/material.dart';
import '../../../../../core/task/task.dart';
import '../../../../../widgets/task_widget/task_widget.dart';
import '/main.dart';
import '/core/user/user.dart';

class ListTaskBooked extends StatefulWidget {
  final UserModel user;
  const ListTaskBooked({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ListTaskBooked> createState() => _ListTaskBookedState();
}

class _ListTaskBookedState extends State<ListTaskBooked> {
  final _taskBloc = TaskBloc();
  final _now = DateTime.now();
  int value = 0;

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
          final waitingTasks = tasks.where((e) => e.status == 0).toList();
          final acceptedTasks = tasks.where((e) {
            final startTime = DateTime.fromMillisecondsSinceEpoch(e.startTime);
            return e.status == 1 && _now.isBefore(startTime);
          }).toList();
          final inprocessTasks = tasks.where((e) {
            final startTime = DateTime.fromMillisecondsSinceEpoch(e.startTime);
            return e.status == 1 && _now.isBefore(startTime);
          }).toList();
          final userOrders = [
            inprocessTasks,
            acceptedTasks,
            waitingTasks,
          ].expand((x) => x).toList();
          return ListView.builder(
            shrinkWrap: true,
            itemCount: userOrders.length,
            itemBuilder: (context, index) {
              final task = userOrders[index];
              final double padding = index == 0 ? 14 : 12;
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: padding,
                  horizontal: 16,
                ),
                child: TaskTab(
                  tab: 1,
                  nameButton: 'Xem chi tiết',
                  task: task,
                  onPressed: (model) {
                    value = index;
                    navigateTo(taskBookedRoute + '/${task.id}');
                  },
                ),
              );
            },
          );
        }
        return const JTIndicator();
      },
    );
  }

  void _fetchDataOnPage() {
    _taskBloc.fetchAllData(params: {'user': widget.user.id});
  }
}
