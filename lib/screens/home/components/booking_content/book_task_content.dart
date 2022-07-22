import 'package:flutter/material.dart';
import 'components/components.dart';

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
                isActive: widget.tab == 0,
                onPressed: () {
                  navigateTo(bookTaskRoute);
                },
              ),
              _buildHeaderItem(
                title: 'Hiện tại',
                isActive: widget.tab == 1,
                onPressed: () {
                  navigateTo(taskBookedRoute);
                },
              ),
              _buildHeaderItem(
                title: 'Lịch sử',
                isActive: widget.tab == 2,
                onPressed: () {
                  navigateTo(taskHistoryRoute);
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
    if (widget.tab == 1) {
      return ListTaskBooked(
        user: widget.user,
      );
    } else if (widget.tab == 2) {
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
