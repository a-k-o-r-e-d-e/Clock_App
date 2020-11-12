import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'clock_view.dart';

class ClockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneStr = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';

    if (!timezoneStr.startsWith('-')) offsetSign = '+';


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(
            'Clock',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700),
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedTime,
                style: TextStyle(color: Colors.white, fontSize: 64),
              ),
              Text(
                formattedDate,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 20),
              ),
            ],
          ),
        ),
        Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Align(
                alignment: Alignment.center,
                child: ClockView(
                  size: MediaQuery.of(context).size.height / 4,
                ))),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TimeZone',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 24),
              ),
              Row(
                children: [
                  Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'UTC' + offsetSign + timezoneStr,
                    style: TextStyle(
                        color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
