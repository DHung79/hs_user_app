import 'package:flutter/material.dart';
import '../../core/task/task.dart';
import '/main.dart';
import 'package:intl/intl.dart';
export './task_time_picker.dart';
export './task_warning_dialog.dart';

String getOptionType(int type) {
  switch (type) {
    case 0:
      return 'Giờ';
    case 1:
      return 'Phòng';
    case 2:
      return 'Khác';
    default:
      return 'Giờ';
  }
}

class TaskTab extends StatefulWidget {
  final void Function(TaskModel?)? onPressed;
  final String nameButton;
  final TaskModel task;
  final int tab;

  const TaskTab({
    Key? key,
    required this.task,
    required this.nameButton,
    this.onPressed,
    this.tab = 0,
  }) : super(key: key);

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final startTime = formatFromInt(
      displayedFormat: 'HH:mm',
      value: widget.task.startTime,
      context: context,
    );
    final date = formatFromInt(
      displayedFormat: 'E, dd/MM/yyyy',
      value: widget.task.date,
      context: context,
    );
    final price =
        NumberFormat('#,##0 VND', 'vi').format(widget.task.totalPrice);
    final optionType =
        getOptionType(widget.task.service.optionType).toLowerCase();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: AppColor.text2,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow.withOpacity(0.24),
            blurStyle: BlurStyle.normal,
            blurRadius: 10,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Divider(),
          ),
          if (widget.tab == 2 && widget.task.status == 3)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                constraints: const BoxConstraints(minHeight: 59),
                decoration: BoxDecoration(
                  color: AppColor.shade2,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: _contentHeader(
                            headerTitle: 'Người hủy công việc',
                            contentTitle: _getWhoCancelTask(),
                          ),
                        ),
                        VerticalDivider(
                          thickness: 2,
                          color: AppColor.shade1,
                        ),
                        Expanded(
                          flex: 1,
                          child: _contentHeader(
                            headerTitle: 'Tổng tiền (VND)',
                            contentTitle: price,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          _detailItem(
            title:
                '${widget.task.selectedOption.quantity} $optionType, $startTime',
            icon: SvgIcon(
              SvgIcons.accessTime,
              size: 24,
              color: AppColor.shade5,
            ),
          ),
          _detailItem(
            title: date,
            icon: SvgIcon(
              SvgIcons.calenderToday,
              size: 24,
              color: AppColor.shade5,
            ),
          ),
          _detailItem(
            title: widget.task.address.name,
            icon: SvgIcon(
              SvgIcons.epLocation,
              size: 24,
              color: AppColor.shade5,
            ),
          ),
          if (widget.tab != 2 || widget.task.status == 2)
            _detailItem(
              title: price,
              icon: SvgIcon(
                SvgIcons.dollar1,
                size: 24,
                color: AppColor.shade5,
              ),
            ),
          _taskInfoOf(widget.task),
          TextButton(
            onPressed: () {
              widget.onPressed!(widget.task);
            },
            child: Text(
              widget.nameButton,
              style: AppTextTheme.headerTitle(AppColor.primary2),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(
                  width: 1,
                  color: AppColor.primary2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentHeader({
    String? contentTitle,
    String? headerTitle,
  }) {
    return Column(
      children: [
        Text(
          headerTitle ?? '',
          style: AppTextTheme.subText(AppColor.text3),
        ),
        Text(
          contentTitle ?? '',
          style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
        ),
      ],
    );
  }

  Widget _detailItem({
    required String? title,
    required SvgIcon icon,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title ?? '',
              style: AppTextTheme.normalText(AppColor.text1),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dọn dẹp theo ngày',
              style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                timeAgoFromNow(widget.task.updatedTime, context),
                style: AppTextTheme.normalText(AppColor.text7),
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: AppColor.shade1),
          padding:
              const EdgeInsets.only(top: 4, bottom: 4, right: 12, left: 12),
          child: Text(
            getStatusName(widget.task),
            style: AppTextTheme.mediumBodyText(
              colorStatus(
                index: widget.task.status,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getWhoCancelTask() {
    final String name =
        widget.task.tasker.isDeleted ? 'Người giúp việc' : 'Người dùng';
    return name;
  }

  Widget _taskInfoOf(TaskModel task) {
    final user = task.user;
    final tasker = task.tasker;
    final String avatar = widget.tab == 0 ? user.avatar : tasker.avatar;
    final String name = widget.tab == 0 ? user.name : tasker.name;
    if (name.isNotEmpty) {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Divider(),
          ),
          Row(
            children: [
              ClipOval(
                child: avatar.isNotEmpty
                    ? Image.network(
                        avatar,
                        width: 35,
                        height: 35,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/logo.png",
                        width: 35,
                        height: 35,
                        fit: BoxFit.cover,
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    name,
                    style: AppTextTheme.normalText(AppColor.text1),
                  ),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Divider(),
          ),
        ],
      );
    } else {
      return const SizedBox(height: 12);
    }
  }
}

Color colorStatus({required index}) {
  Color color;
  if (index == 0) {
    color = AppColor.primary2;
  } else if (index == 1) {
    color = AppColor.shade9;
  } else if (index == 2) {
    color = AppColor.shade9;
  } else if (index == 3) {
    color = AppColor.others1;
  } else {
    color = AppColor.test1;
  }
  return color;
}

String getStatusName(TaskModel task) {
  final now = DateTime.now();
  switch (task.status) {
    case 0:
      return 'Đang chờ nhận';
    case 1:
      final date = DateTime.fromMillisecondsSinceEpoch(task.date);
      if (date.difference(now).inDays <= 0 &&
          task.startTime <= now.millisecondsSinceEpoch) {
        return 'Đã nhận';
      } else {
        return 'Đang làm';
      }
    case 2:
      return 'Thành công';
    case 3:
      return 'Đã bị hủy';
    default:
      return '';
  }
}
