import 'package:flutter/material.dart';
import '../../../../core/user/user.dart';
import '/main.dart';
import 'rebook_task/list_rebook_task.dart';
import 'task_history/task_history.dart';
import 'task_booked/task_booked.dart';

class BookingContent extends StatefulWidget {
  final int tab;
  final UserModel user;
  const BookingContent({
    Key? key,
    this.tab = 0,
    required this.user,
  }) : super(key: key);

  @override
  State<BookingContent> createState() => _BookingContentState();
}

class _BookingContentState extends State<BookingContent> {
  final _userBloc = UserBloc();
  late int _currentTab;
  @override
  void initState() {
    _currentTab = widget.tab;
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
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.shadow.withOpacity(0.16),
                blurRadius: 16,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeaderItem(
                title: 'Đăng việc',
                isActive: _currentTab == 0,
                onPressed: () {
                  setState(() {
                    _currentTab = 0;
                  });
                },
              ),
              _buildHeaderItem(
                title: 'Hiện tại',
                isActive: _currentTab == 1,
                onPressed: () {
                  setState(() {
                    _currentTab = 1;
                  });
                },
              ),
              _buildHeaderItem(
                title: 'Lịch sử',
                isActive: _currentTab == 2,
                onPressed: () {
                  setState(() {
                    _currentTab = 2;
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: screenSize.height - 150 - 24,
          child: _getContent(),
        ),
      ],
    );
  }

  Widget _buildHeaderItem({
    required String title,
    required bool isActive,
    required void Function()? onPressed,
  }) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColor.primary1 : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.white),
          onPressed: onPressed,
          child: Text(
            title,
            style: isActive
                ? AppTextTheme.normalText(AppColor.primary1)
                : AppTextTheme.normalText(AppColor.text3),
          ),
        ),
      ),
    );
  }

  Widget _getContent() {
    if (_currentTab == 1) {
      return TaskBooked(
        user: widget.user,
      );
    } else if (_currentTab == 2) {
      return TaskHistory(
        user: widget.user,
      );
    } else {
      return ListRebookTask(
        user: widget.user,
      );
    }
  }
}
