import 'package:flutter/material.dart';
import '../../components/components.dart';
import 'tabs/book_new_task.dart';
import 'tabs/rebook_task.dart';

class BookTaskScreen extends StatefulWidget {
  final String taskId;
  const BookTaskScreen({
    Key? key,
    this.taskId = '',
  }) : super(key: key);

  @override
  State<BookTaskScreen> createState() => _RebookTaskState();
}

class _RebookTaskState extends State<BookTaskScreen> {
  final PageState _pageState = PageState();
  final _userBloc = UserBloc();
  final _taskBloc = TaskBloc();

  @override
  void initState() {
    _fetchDataOnPage();
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.dispose();
    _taskBloc.dispose();
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
    return widget.taskId.isNotEmpty
        ? StreamBuilder(
            stream: _taskBloc.taskData,
            builder:
                (context, AsyncSnapshot<ApiResponse<TaskModel?>> snapshot) {
              if (snapshot.hasData) {
                final task = snapshot.data!.model!;
                return RebookTask(
                  user: user,
                  task: task,
                );
              } else {
                return const SizedBox();
              }
            },
          )
        : BookNewTaskContent(
            user: user,
          );
  }

  _fetchDataOnPage() {
    if (widget.taskId.isNotEmpty) {
      _taskBloc.fetchDataById(widget.taskId);
    }
  }
}
