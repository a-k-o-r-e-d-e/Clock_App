import 'package:clock_app/constants/data.dart';
import 'package:clock_app/constants/enums.dart';
import 'package:clock_app/constants/my_colors.dart';
import 'package:clock_app/models/menu_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'alarm_page.dart';
import 'clock_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

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
              color: MyColors.dividerColor,
              width: 1,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(32),
                child: Consumer<MenuInfo>(
                  builder: (BuildContext context, MenuInfo value, Widget child) {

                    if (value.menuType == MenuType.clock)
                      return ClockPage();
                    else if (value.menuType == MenuType.alarm)
                      return AlarmPage();
                    else {
                      return Container(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 20),
                            children: <TextSpan>[
                              TextSpan(text: 'Upcoming\n'),
                              TextSpan(
                                text: value.title,
                                style: TextStyle(fontSize: 40)
                              )
                            ]
                          ),
                        ),
                      );
                    }

                  },
                ),
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
