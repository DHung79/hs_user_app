import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../config/theme.dart';
import '/config/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo'),
        centerTitle: true,
        actions: [
          SvgPicture.asset('assets/icons/17078.svg')
        ],
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/17079.svg', width: 20,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        // scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, top: 16, bottom: 16),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 19),
                  child: CircleAvatar(
                    backgroundColor: ColorApp.purpleColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Tasker huy cong viec'),
                    SizedBox(
                      width: 300,
                     child: Text('dsdssddssssssssssd sadssds dds ds ds ds sddsdssdds as', overflow: TextOverflow.ellipsis, maxLines: 5,),
                    ),
                    Text('ajijij'),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 16, bottom: 16),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 19),
                  child: CircleAvatar(
                    backgroundColor: ColorApp.purpleColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Tasker huy cong viec'),
                    SizedBox(
                      width: 300,
                      child: Text('dsdssddssssssssssd sadssds dds ds ds ds sddsdssdds as', overflow: TextOverflow.ellipsis, maxLines: 5,),
                    ),
                    Text('ajijij'),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 16, bottom: 16),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 19),
                  child: CircleAvatar(
                    backgroundColor: ColorApp.purpleColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Tasker huy cong viec'),
                    SizedBox(
                      width: 300,
                      child: Text('dsdssddssssssssssd sadssds dds ds ds dssssssssssssssssssssd sdddddddddddddddddddd dsssssssssssssssssss sddsdssds qsas sds sddsdssdds as', overflow: TextOverflow.ellipsis, maxLines: 5,),
                    ),
                    Text('ajijij'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
