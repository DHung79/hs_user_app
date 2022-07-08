import 'package:flutter/material.dart';
import '/core/task/model/task_model.dart';
import '/main.dart';
import '/routes/route_names.dart';
import '../../../../core/task/bloc/task_bloc.dart';
import '../../../../core/user/user.dart';
import '../../../../theme/svg_constants.dart';
import '../../../../widgets/task_widget.dart';

class BookTask extends StatefulWidget {
  final UserModel user;
  const BookTask({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<BookTask> createState() => _BookTaskState();
}

class _BookTaskState extends State<BookTask> {
  final _taskBloc = TaskBloc();

  @override
  void initState() {
    _fetchDataOnPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 22, 16, 12),
          child: SizedBox(
            height: 52,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColor.primary2,
              ),
              onPressed: () {
                navigateTo(bookNewTaskRoute);
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(
            'Việc từng đăng',
            style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: _taskBloc.allData,
            builder:
                (context, AsyncSnapshot<ApiResponse<ListTaskModel?>> snapshot) {
              if (snapshot.hasData) {
                final tasks = snapshot.data!.model!.records;
                final listTask = tasks.where((e) => e.status >= 2).toList();
                if (listTask.isNotEmpty) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: listTask.length,
                      itemBuilder: (context, index) {
                        final task = listTask[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          child: TasksWidget(
                            nameButton: 'Đăng lại',
                            task: task,
                            onPressed: (task) {
                              navigateTo(rebookTaskRoute + '/${task!.id}');
                            },
                          ),
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

  void _fetchDataOnPage() {
    _taskBloc.fetchAllData(params: {});
  }
}
