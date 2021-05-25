import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jimin_clock/constants/theme_data.dart';
import 'package:jimin_clock/enums.dart';
import 'package:jimin_clock/views/alarm_page.dart';
import 'package:jimin_clock/views/clock_page.dart';
import 'package:provider/provider.dart';

import 'package:jimin_clock/data.dart';
import 'package:jimin_clock/models/menu_info.dart';
import 'package:jimin_clock/views/clock_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackgroundColor,
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                .toList(),
          ),
          VerticalDivider(
            color: CustomColors.dividerColor,
            width: 1,
          ),
          Expanded(child: Consumer<MenuInfo>(
            builder: (BuildContext context, MenuInfo value, Widget child) {
              if(value.menuType == MenuType.clock) return ClockPage();
              else if (value.menuType == MenuType.alarm) return AlarmPage();
              else return Container(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(text: 'Upcoming Tutorial\n'),
                        TextSpan(
                          text: value.title,
                          style: TextStyle(fontSize: 48),
                        )
                      ]
                    ),
                  ),
              );
            },
          )),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
        builder: (BuildContext context, MenuInfo value, Widget child) {
      return TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
            backgroundColor: currentMenuInfo.menuType == value.menuType
                ? CustomColors.menuBackgroundColor
                : Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(32)))),
        onPressed: () {
          var menuInfo = Provider.of<MenuInfo>(context, listen: false);
          menuInfo.updateMenu(currentMenuInfo);
        },
        child: Column(
          children: <Widget>[
            Image.asset(
              currentMenuInfo.imageSource,
              scale: 1.5,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              currentMenuInfo.title ?? '',
              style: TextStyle(
                fontFamily: 'avenir',
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    });
  }
}
