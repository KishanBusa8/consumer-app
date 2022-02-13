import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashching/Utilities/constants.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/consumer_notification_model.dart';
import 'package:hashching/models/hash_convenyancing_model.dart';
import 'package:hashching/pages/mydeals/hash_auto.dart';
import 'package:hashching/pages/mydeals/hash_connect.dart';
import 'package:hashching/pages/mydeals/hash_convenyancing.dart';
import 'package:hashching/pages/myloans/enquirey_details.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:provider/provider.dart';

class NotificationLocal extends StatelessWidget {
  NotificationLocal({Key? key, required this.floatingPanelWidget})
      : super(key: key);
  final Widget floatingPanelWidget;
  @override
  Widget build(BuildContext context) {
    void navigateToPage(page) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    }

    ConsumerNotificationsModel consumerNotificationsModel =
        Provider.of<ConsumerNotificationsModel>(context);
    ConsumerAccountModel consumerAccountModel =
        Provider.of<ConsumerAccountModel>(context);
    print('object ${consumerNotificationsModel}');
    return consumerNotificationsModel.consumerNotifications.length != 0
        ? ListView.separated(
            itemCount: consumerNotificationsModel.consumerNotifications.length,
            itemBuilder: (context, index) {
              String notificationMessage = consumerNotificationsModel
                  .consumerNotifications[index].title
                  .replaceAll("<u>", '')
                  .replaceAll("</u>", '');
              String action = consumerNotificationsModel
                  .consumerNotifications[index].action;
              String link = consumerNotificationsModel
                  .consumerNotifications[index].link;
              String encrypt_key = consumerNotificationsModel
                  .consumerNotifications[index].encryptId;
              return Container(
                  margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                  child: InkWell(
                    onTap: () {
                      if (action == LocalConstants.hashauto) {
                        navigateToPage(HashAuto(
                            consumerAccountModel: consumerAccountModel));
                      } else if (action == LocalConstants.hashconnect) {
                        navigateToPage(HashConnect(
                            consumerAccountModel: consumerAccountModel));
                      } else if (action == LocalConstants.hashconveyance) {
                        navigateToPage(HashConvenyancing(
                          consumerAccountModel: consumerAccountModel,
                          hashConveyacingRawList:
                              HashConveyacingRawList(hashconveyacingList: []),
                        ));
                      } else if(action == LocalConstants.videocall) {
                        SimplifiedWidgets.launchInBrowser(link, context);
                      }else{
                        navigateToPage(EnquireyDetails(encryptkey: encrypt_key));
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          notificationMessage,
                          style: MasterStyle.whiteTextNormal,
                        ),
                        MySizedBox.height(8.h),
                        Text(
                          consumerNotificationsModel
                              .consumerNotifications[index].notificationTime,
                          style: MasterStyle.whiteTextNormal.merge(TextStyle(
                              color: MasterStyle.whiteColor.withOpacity(0.3),
                              fontSize: 11.sp)),
                        ),
                      ],
                    ),
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                height: 1,
                color: MasterStyle.whiteColor.withOpacity(0.4),
              );
            },
          )
        : ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No new notifications"),
                  ],
                ),
              ),
              this.floatingPanelWidget
            ],
          );
  }
}
