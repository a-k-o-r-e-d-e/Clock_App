import 'package:clock_app/constants/data.dart';
import 'package:clock_app/constants/my_colors.dart';
import 'package:clock_app/models/alarm_info.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AlarmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Alarm',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: MyColors.primaryTextColor,
                fontSize: 24),
          ),
          Expanded(
            child: ListView(
              children: alarms
                  .map<Widget>((alarm) => buildAlarmCard(alarm))
                  .followedBy([
                DottedBorder(
                  strokeWidth: 2,
                  color: MyColors.clockOutline,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(24),
                  dashPattern: [5, 4],
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: MyColors.clockBG,
                        borderRadius: BorderRadius.circular(24)),
                    child: FlatButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 31, vertical: 16),
                      onPressed: () {},
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/add_alarm.png',
                            scale: 1.5,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Add Alarm',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildAlarmCard(AlarmInfo alarmInfo) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: alarmInfo.gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
        boxShadow: [
          BoxShadow(
              color: alarmInfo.gradientColors.last.withOpacity(0.4),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(4, 4))
        ],
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.label,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Office',
                style: TextStyle(color: Colors.white),
              ),
              Switch(
                onChanged: (bool value) {},
                value: true,
                activeColor: Colors.white,
              )
            ],
          ),
          Text(
            'Mon-Fri',
            style: TextStyle(color: Colors.white),
          ),
          Row(
            children: [
              Text(
                '07:00 AM',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 30,
              )
            ],
          ),
        ],
      ),
    );
  }
}
