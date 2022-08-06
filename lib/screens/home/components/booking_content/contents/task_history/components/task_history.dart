import 'package:flutter/material.dart';
import '../../../../../../../core/task/task.dart';
import '../../book_task/components/tasker_info.dart';
import '/main.dart';
import '/core/user/user.dart';
import '/core/authentication/auth.dart';
import 'task_history_detail.dart';

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
          return !_isTaskerInfo
              ? TaskHistoryDetail(
                  user: user,
                  task: task,
                  onChangeContent: () {
                    setState(() {
                      _isTaskerInfo = true;
                    });
                  },
                )
              : TaskerInfo(
                  taskerId: task.tasker.id,
                  onBack: () {
                    setState(() {
                      _isTaskerInfo = false;
                    });
                  },
                );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  _fetchDataOnPage() {
    _taskBloc.fetchDataById(widget.taskId);
  }
}
