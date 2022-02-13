// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hashching/models/consumer_brokers_list_model.dart';
import 'package:hashching/models/consumer_dashboard.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/masterstyle.dart';

class VisibilitySettings extends StatefulWidget {
  VisibilitySettings(
      {Key? key,
      required this.consumerDashboardModel,
      required this.selctedFileId})
      : super(key: key);
  ConsumerDashboardModel? consumerDashboardModel;
  List<String> selctedFileId;

  @override
  _VisibilitySettingsState createState() => _VisibilitySettingsState();
}

class _VisibilitySettingsState extends State<VisibilitySettings> {
  List<bool> isSwitchList = [];

  shareConsumerDocuments(
      {required String userId, required String status}) async {
    Future shareConsumerDocumentServices =
        await ApiServices.shareConsumerDocuments(
      documentIds: widget.selctedFileId,
      userId: userId,
      status: status,
    );
    return shareConsumerDocumentServices;
  }
  int i =0;
  @override
  void initState() {
    super.initState();
    for (i; i < widget.consumerDashboardModel!.allConsumerBrokers.length; i++) {
      isSwitchList.add(false);
    }
    print('isCheckBoxList ${isSwitchList} ${isSwitchList.length}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 20,
        backgroundColor: MasterStyle.backgroundColor,
        title: Text(
          "Visibility Settings",
          style: MasterStyle.appBarTitleStyle,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:
                Icon(Icons.arrow_back_ios, color: MasterStyle.appBarIconColor)),
        actions: [
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.search, color: MasterStyle.appBarIconColor)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.consumerDashboardModel!.allConsumerBrokers.length,
            separatorBuilder: (context, index) {
              return Divider(
                  thickness: 1, height: 1, color: MasterStyle.dividerColor);
            },
            itemBuilder: (context, index) {
              return Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      horizontalTitleGap: 16,
                      leading: Container(
                        height: 51,
                        width: 51,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget
                              .consumerDashboardModel!
                              .allConsumerBrokers[index]
                              .profilePic),
                        ),
                      ),
                      title: Text(
                        widget.consumerDashboardModel!.allConsumerBrokers[index]
                                .firstName +
                            ' ' +
                            widget.consumerDashboardModel!
                                .allConsumerBrokers[index].lastName,
                        style: MasterStyle.whiteStyleWithRegular,
                      ),
                      subtitle: Text(
                          widget.consumerDashboardModel!.allConsumerBrokers[index]
                                  .locality +
                              ', ' +
                              widget.consumerDashboardModel!
                                  .allConsumerBrokers[index].state,
                          style: MasterStyle.whiteTextStyleNormal),
                      trailing: Transform.scale(
                        transformHitTests: false,
                        scale: .55,
                        child: CupertinoSwitch(
                          value: isSwitchList[index],
                          onChanged: (value) {
                            setState(() {
                              isSwitchList[index] = value;
                            });
                            String currentStatus = value ? 'on' : 'off';

                            shareConsumerDocuments(
                                status: currentStatus,
                                userId: widget.consumerDashboardModel!
                                    .allConsumerBrokers[index].userId
                                    .toString());
                          },
                          activeColor: Colors.green,
                          trackColor: MasterStyle.switchTileTrackColor,
                        ),
                      )));
            }),
      ),
    );
  }
}
