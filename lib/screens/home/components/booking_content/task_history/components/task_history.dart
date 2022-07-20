import 'package:flutter/material.dart';
import '../../../../../../core/task/task.dart';
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
          return TaskHistoryDetail(
            user: user,
            task: task,
            onChangeContent: () {
              navigateTo(taskerInfoRoute);
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
