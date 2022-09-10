
import 'package:flutter/material.dart';
import 'package:newsapp/widgets/settings_item.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

import '../providers/themeprovider.dart';
import 'darktheme.dart';

class SettingsGroup extends StatelessWidget {
  String? settingsGroupTitle;
  TextStyle? settingsGroupTitleStyle;
  List<SettingsItem> items;
  // Icons size
  double? iconItemSize;

  SettingsGroup(
      {this.settingsGroupTitle,
      this.settingsGroupTitleStyle,
      required this.items,
      this.iconItemSize = 25});

  @override
  Widget build(BuildContext context) {
   /* if (this.iconItemSize != null)
      SettingsScreenUtils.settingsGroupIconSize = iconItemSize;*/

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The title
          (settingsGroupTitle != null)
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    settingsGroupTitle!,
                    style: (settingsGroupTitleStyle == null)
                        ? TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
                        : settingsGroupTitleStyle,
                  ),
                )
              : Container(),
          // The SettingsGroup sections
          Container(
            decoration: BoxDecoration(
              color:  Provider.of<Theme_Provider>(context)  .Themedata== ThemeData.dark()?Color.fromARGB(255, 86, 85, 85): Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return items[index];
              },
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: ScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
