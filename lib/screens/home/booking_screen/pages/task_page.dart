import 'package:flutter/material.dart';
import 'package:hs_user_app/core/task/model/task_model.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import '../../../../core/task/bloc/task_bloc.dart';
import '../../../../core/user/user.dart';
import '../../../../theme/svg_constants.dart';
import '../../../../widgets/task_widget.dart';

final taskPageKey = GlobalKey<_TaskPageState>();

class TaskPage extends StatefulWidget {
  final UserModel user;
  const TaskPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _taskBloc = TaskBloc();
  TaskModel? task;
  List<TaskModel> statuses = [];

  @override
  void initState() {
    _fetchDataOnPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 52,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: AppColor.primary2,
                      padding: const EdgeInsets.only(top: 16, bottom: 16)),
                  onPressed: () {
                    navigateTo(posttaskRoute);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgIcon(
                          SvgIcons.add,
                          color: AppColor.text2,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'ĐĂNG VIỆC MỚI NGAY',
                          style: AppTextTheme.headerTitle(AppColor.text2),
                        ),
                      ]),
                ),
              ),
              Padding(
                child: Text(
                  'Việc từng đăng',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                ),
                padding: const EdgeInsets.only(top: 24),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: _taskBloc.allData,
            builder:
                (context, AsyncSnapshot<ApiResponse<ListTaskModel?>> snapshot) {
              if (snapshot.hasData) {
                final tasks = snapshot.data!.model!.records;
                idTask = tasks.first.id;
                statuses = tasks.where((e) => e.status >= 2).toList();
                if (statuses.isNotEmpty) {
                  return ListView.builder(
                      itemCount: statuses.length,
                      itemBuilder: (context, index) {
                        return TasksWidget(
                          nameButton: 'Đăng lại',
                          task: statuses[index],
                          name: statuses[index].postedUser.name,
                          url: statuses[index].postedUser.avatar,
                          onPressed: (callBackTask) {
                            setState(() {
                              task = callBackTask;
                              callBackTask?.startTime;
                              callBackTask?.endTime;
                              callBackTask?.date;
                              callBackTask?.address;
                              int.parse(callBackTask!.estimateTime);
                              callBackTask.service.options.isNotEmpty
                                  ? callBackTask.service.options.first.note
                                  : '';
                              callBackTask.service.options.isNotEmpty
                                  ? callBackTask.service.options.first.quantity
                                  : 0;
                            });
                            navigateTo(postFastRoute);
                          },
                        );
                      });
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
                ),
              );
            },
          ),
        )
      ],
    );
  }

  String intToTimeLeft(int value) {
    DateTime date2 = DateTime.fromMillisecondsSinceEpoch(value * 1000);
    return date2.toString();
  }

  void _fetchDataOnPage() {
    _taskBloc.fetchAllData(params: {});
  }
}
