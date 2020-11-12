import 'package:clock_app/constants/data.dart';
import 'package:clock_app/constants/enums.dart';
import 'package:clock_app/constants/my_colors.dart';
import 'package:clock_app/models/menu_info.dart';
import 'package:clock_app/views/clock_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneStr = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';

    if (!timezoneStr.startsWith('-')) offsetSign = '+';

    return Scaffold(
      backgroundColor: MyColors.pageBackgroundColor,
      body: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menuItems
                  .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                  .toList(),
            ),
            VerticalDivider(
              color: Colors.white54,
              width: 1,
            ),
            Expanded(
              child: Consumer<MenuInfo>(
                builder: (BuildContext context, MenuInfo value, Widget child) {
                  if (value.menuType != MenuType.clock) return Container(child: Center(
                    child: Text("Upcoming", style: TextStyle(color: MyColors.primaryTextColor, fontWeight: FontWeight.bold),),
                  ),);

                  return Container(
                    padding: const EdgeInsets.all(32),
                    child: Column(
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(32))
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          color: currentMenuInfo.menuType == value.menuType
            ? MyColors.menuBackgroundColor
            : Colors.transparent,
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);

            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: [
              Image.asset(
                currentMenuInfo.imageSource,
                scale: 1.5,
              ),
              Text(
                currentMenuInfo.title ?? '',
                style: TextStyle(color: Colors.white, fontSize: 14),
              )
            ],
          ),
        );
      },

    );
  }
}
