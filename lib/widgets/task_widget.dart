import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/theme/svg_constants.dart';
import 'package:intl/intl.dart';
import '../core/task/task.dart';

class TasksWidget extends StatefulWidget {
  final void Function(TaskModel?)? onPressed;
  final String nameButton;
  final TaskModel? task;
  String name = '';
  String url;

  TasksWidget({
    Key? key,
    this.task,
    required this.name,
    required this.url,
    required this.nameButton,
    this.onPressed,
  }) : super(key: key);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppColor.text2,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.24),
              blurStyle: BlurStyle.normal,
              blurRadius: 10,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Column(
          children: [
            _title(),
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 12),
              color: AppColor.shade1,
              height: 1,
              width: MediaQuery.of(context).size.width,
            ),
            _item(
                task:
                    '${widget.task?.estimateTime} tiếng, ${readTimestamp(widget.task?.startTime)} - ${readTimestampEnd(widget.task?.startTime)}',
                icon: SvgIcon(
                  SvgIcons.accessTime,
                  size: 24,
                  color: AppColor.shade5,
                )),
            _item(
                task: readTimestamp2(widget.task?.date),
                icon: SvgIcon(
                  SvgIcons.calenderToday,
                  size: 24,
                  color: AppColor.shade5,
                )),
            _item(
                task: widget.task?.address,
                icon: SvgIcon(
                  SvgIcons.epLocation,
                  size: 24,
                  color: AppColor.shade5,
                )),
            _item(
                task: widget.task?.totalPrice.toString(),
                icon: SvgIcon(
                  SvgIcons.dollar1,
                  size: 24,
                  color: AppColor.shade5,
                )),
            const SizedBox(
              height: 6,
            ),
            const Divider(
              height: 1,
            ),
            widget.name != ''
                ? _profile(name: widget.name, url: widget.url)
                : const SizedBox(),
            const Divider(
              height: 1,
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _item({
    required String? task,
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
              task ?? '',
              style: AppTextTheme.normalText(AppColor.text1),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
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
                readTimestamp(widget.task?.updatedTime),
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
            statusTask(index: widget.task?.status),
            style: AppTextTheme.mediumBodyText(
              colorStatus(index: widget.task?.status),
            ),
          ),
        ),
      ],
    );
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
      color = AppColor.shade9;
    } else if (index == 4) {
      color = AppColor.others1;
    } else {
      color = AppColor.test1;
    }
    return color;
  }

  String statusTask({required index}) {
    String text = '';
    if (index == 0) {
      text = 'Đang chờ nhận';
    } else if (index == 1) {
      text = 'Đã nhận';
    } else if (index == 2) {
      text = 'Đang làm';
    } else if (index == 3) {
      text = 'Thành công';
    } else if (index == 4) {
      text = 'Đã bị hủy';
    } else {
      text = 'Lỗi';
    }
    return text;
  }

  Widget _profile({required String name, required String url}) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(url)
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              name,
              style: AppTextTheme.normalText(AppColor.text1),
            ),
          )
        ],
      ),
    );
  }

  String readTimestamp(int? timestamp) {
    var format = DateFormat('HH:mm');
    var date = DateTime.fromMicrosecondsSinceEpoch((timestamp ?? 0 * 1000));
    var time = '';
    time = format.format(date);

    return time;
  }

  String readTimestamp2(int? timestamp) {
    logDebug(timestamp);
    var format = DateFormat('E, dd/MM/yyyy');
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp ?? 0 * 1000);
    var time = '';
    time = format.format(date);

    return time;
  }

  String readTimestampEnd(int? timestamp) {
    var format = DateFormat('HH:mm');
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp ?? 0 * 1000);
    var time = '';
    time = format.format(
        date.add(Duration(hours: int.parse(widget.task?.estimateTime ?? '0'))));

    return time;
  }
}
