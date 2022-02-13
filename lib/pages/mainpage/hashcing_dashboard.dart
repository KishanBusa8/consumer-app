import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/Utilities/constants.dart';
import 'package:hashching/models/consumer_account_model.dart';
import 'package:hashching/models/consumer_details_model.dart';
import 'package:hashching/models/hash_convenyancing_model.dart';
import 'package:hashching/pages/brokers/brokers.dart';
import 'package:hashching/pages/myaccount/myaccounts.dart';
import 'package:hashching/pages/homepage/homepage.dart';
import 'package:hashching/pages/inbox/inbox.dart';
import 'package:hashching/pages/myaccount/settings.dart';
import 'package:hashching/pages/mydeals/my_deals.dart';
import 'package:hashching/pages/myloans/myloans.dart';
import 'package:hashching/pages/notification/notification.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:hashching/styles/styles.dart';
import 'package:provider/provider.dart';

class HaschingDashboard extends StatefulWidget {
  const HaschingDashboard({Key? key}) : super(key: key);

  @override
  _HaschingDashboardState createState() => _HaschingDashboardState();
}

class _HaschingDashboardState extends State<HaschingDashboard>
    with SingleTickerProviderStateMixin {
  bool isHomePage = true;
  bool isNotification = false;
  bool isInbox = false;
  bool isBroker = false;
  bool isProfile = false;
  bool isMyLoan = false;
  bool isFloatingIconActive = false;
  int currenIndex = 0;
  int initialIndex = 0;
  int notificationPageIndex = 4;
  int inboxPageIndex = 5;

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  final svgList = [
    'category.svg',
    'loan.svg',
    'broker.svg',
    'loan.svg',
  ];
  final textList = ["Dashboard", "Loans", "Brokers", "My Profile"];
  initialData() {
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#2A4460'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  tabBar(context) {
    return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return _buildBottomPicker(
            CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {},
            ),
          );
        });
  }

  _buildBottomPicker(CupertinoDatePicker cupertinoDatePicker) {
    var picker;
    Container(
      height: 400,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  AppBar appBar(title) {
    ConsumerAccountModel consumerAccountModel =
        Provider.of<ConsumerAccountModel>(context);
    if (isInbox) {
      return AppBar(
        backgroundColor: AppColors.themeColor,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        title: Text(
          "Inbox",
          style: TextStyle(color: Colors.orange[800]),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: HexColor("#F56735"),
          ),
          onPressed: () {
            setState(() {
              isNotification = false;
              isHomePage = true;
              currenIndex = 0;
              isInbox = false;
            });
          },
        ),
      );
    } else if (isNotification) {
      return AppBar(
        centerTitle: false,
        backgroundColor: AppColors.themeColor,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: HexColor("#F56735"),
          ),
          onPressed: () {
            setState(() {
              isInbox = false;
              isNotification = false;
              isHomePage = true;
              currenIndex = 0;
            });
          },
        ),
        titleSpacing: 0,
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(color: Colors.orange[800]),
        ),
        actions: [
          // SvgPicture.asset('assets/home_assets/search.svg'),
          GestureDetector(
            onTap: () {
              setState(() {
                isInbox = false;
                isNotification = true;
                isHomePage = false;
                currenIndex = notificationPageIndex;
              });
            },
            child: consumerAccountModel.messageNotification
                ? Padding(
                    padding: EdgeInsets.only(left: 16, right: 12, bottom: 5),
                    child:
                        SvgPicture.asset('assets/home_assets/notification.svg'),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 12, right: 16),
                    child: Icon(
                      Icons.notifications_none,
                      size: 28,
                    ),
                  ),
          ),
          Stack(
            clipBehavior: Clip.hardEdge,
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isInbox = true;
                    isHomePage = false;
                    isNotification = false;
                    currenIndex = inboxPageIndex;
                  });
                },
                child: Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: SvgPicture.asset("assets/home_assets/inbox.svg")),
              ),
              consumerAccountModel.consumerNotificationsUnread
                  ? Positioned(
                      left: 0,
                      right: 0,
                      top: 18,
                      child: new Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                            color: MasterStyle.unreadBadgeColor,
                            shape: BoxShape.circle),
                        constraints: BoxConstraints(
                          minWidth: 7,
                          minHeight: 7,
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ],
      );
    } else if (isHomePage) {
      return AppBar(
        backgroundColor: AppColors.themeColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0.0,
        title: Transform(
          transform: Matrix4.translationValues(-8.0, 0.0, 0.0),
          child: Container(
              margin: EdgeInsets.zero,
              height: 50,
              width: 160,
              child: new Image.asset(
                'assets/hashching1logo.png',
                fit: BoxFit.fill,
              )),
        ),
        actions: [
          // SvgPicture.asset('assets/home_assets/search.svg'),
          GestureDetector(
            onTap: () {
              setState(() {
                isInbox = false;
                isNotification = true;
                isHomePage = false;
                currenIndex = notificationPageIndex;
              });
            },
            child: consumerAccountModel.messageNotification
                ? Padding(
                    padding: EdgeInsets.only(left: 16, right: 12, bottom: 5),
                    child:
                        SvgPicture.asset('assets/home_assets/notification.svg'),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 12, right: 16),
                    child: Icon(
                      Icons.notifications_none,
                      size: 28,
                    ),
                  ),
          ),
          Stack(
            clipBehavior: Clip.hardEdge,
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isInbox = true;
                    isHomePage = false;
                    isNotification = false;
                    currenIndex = inboxPageIndex;
                  });
                },
                child: Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: SvgPicture.asset("assets/home_assets/inbox.svg")),
              ),
              consumerAccountModel.consumerNotificationsUnread
                  ? Positioned(
                      left: 0,
                      right: 0,
                      top: 18,
                      child: new Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                            color: MasterStyle.unreadBadgeColor,
                            shape: BoxShape.circle),
                        constraints: BoxConstraints(
                          minWidth: 7,
                          minHeight: 7,
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ],
      );
    } else if (currenIndex != 3) {
      return AppBar(
        automaticallyImplyLeading: false,
      );
    } else {
      return AppBar();
    }
  }

  Widget floatingPanel() {
    ConsumerAccountModel consumerAccountModel =
        Provider.of<ConsumerAccountModel>(context);
    ConsumerDetailsModel consumerDetailsModel =
        Provider.of<ConsumerDetailsModel>(context);
        //  HashConveyacingRawList hashConveyacingRawList =
        //       Provider.of<HashConveyacingRawList>(context);
    if (!isFloatingIconActive) {
      return SizedBox();
    } else {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(18),
          margin: EdgeInsets.only(bottom: 0),
          decoration: BoxDecoration(
            color: HexColor('#2A4460'),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Column(
              //   children: [
              //     InkWell(
              //       onTap: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => Calculator()));
              //       },
              //       child: SvgPicture.asset(
              //         'assets/home_assets/calculator.svg',
              //         height: 28,
              //         width: 28,
              //       ),
              //     ),

              //     SizedBox(
              //       height: 8,
              //     ),
              //     Text(
              //       'Calculator',
              //       style: MasterStyle.bottombarTextStyle
              //           .merge(TextStyle(color: Colors.white)),
              //     )
              //   ],
              // ),

              SizedBox(
                width: 22,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isFloatingIconActive = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyDeals(
                            hashConveyacingRawList:HashConveyacingRawList(hashconveyacingList: []),
                                consumerAccountModel: consumerAccountModel,
                              )));
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/home_assets/mydeals.svg',
                      height: 28,
                      width: 28,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'My Deals',
                      style: MasterStyle.bottombarTextStyle
                          .merge(TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 22,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isFloatingIconActive = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyAccountSettings(
                                consumerInformation: consumerDetailsModel,
                                consumerAccount: consumerAccountModel,
                              )));
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/home_assets/settings.svg',
                      height: 28,
                      width: 28,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Settings',
                      style: MasterStyle.bottombarTextStyle
                          .merge(TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 14,
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    initialData();
    super.initState();
  }

  screens(context) {
    return [
      HomePage(
          floatingPanelWidget: floatingPanel(),
          isFloatingIconActive: isFloatingIconActive),
      willPopScopeWidget(child: MyLoans(myLoanNavigation: myNavigation())),
      willPopScopeWidget(child: Brokers(brokerNavigation: myNavigation())),
      willPopScopeWidget(
          child: MyAccount(myAccountNavigation: myAccountNavigation())),
      NotificationLocal(floatingPanelWidget: floatingPanel()),
      Inbox(floatingPanelWidget: floatingPanel()),
    ];
  }

  Widget willPopScopeWidget({child}) {
    return WillPopScope(
      child: child,
      onWillPop: () async {
        print('object');
        setState(() {
          currenIndex = 0;
          isHomePage = true;
        });
        return await true;
      },
    );
  }

  Widget myNavigation() {
    return IconButton(
        onPressed: () {
          setState(() {
            currenIndex = 0;
            isHomePage = true;
          });
        },
        icon: Icon(Icons.arrow_back_ios, color: MasterStyle.appBarIconColor));
  }

  Widget myAccountNavigation() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isHomePage = true;
          currenIndex = 0;
        });
      },
      child: Container(
        child: SvgPicture.asset('assets/icons/arrow_outline.svg',
            height: 36.6, width: 64.46),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ConsumerAccountModel consumerAccountModel =
    //     Provider.of<ConsumerAccountModel>(context);
    // ConsumerDetailsModel consumerDetailsModel =
    //     Provider.of<ConsumerDetailsModel>(context);
    return WillPopScope(
      onWillPop: () async {
        if (isHomePage) {
          SystemNavigator.pop();
        } else if (isInbox) {
          setState(() {
            isNotification = false;
            isHomePage = true;
            currenIndex = 0;
            isInbox = false;
          });
        } else if (isNotification) {
          setState(() {
            isInbox = false;
            isNotification = false;
            isHomePage = true;
            currenIndex = 0;
          });
        } else {
          setState(() {
            currenIndex = 0;
            isHomePage = true;
          });
        }

        return await false;
      },
      child: Scaffold(
        appBar: currenIndex == 3 || currenIndex == 1 || currenIndex == 2
            ? null
            : appBar(isHomePage
                ? LocalConstants.dashboard
                : LocalConstants.notification),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton:
            currenIndex == 3 || currenIndex == 1 || currenIndex == 2
                ? SizedBox()
                :
                //  FloatingAction(
                //     consumerAccountModel: consumerAccountModel,
                //     consumerDetailsModel: consumerDetailsModel,
                //   ),

                Container(
                    height: 50,
                    width: 50,
                    child: FloatingActionButton(
                        //params
                        backgroundColor: HexColor('#F56D3E'),
                        child: Container(
                          child: !isFloatingIconActive
                              ? SvgPicture.asset(
                                  'assets/home_assets/floating_icon.svg')
                              : Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                        ),
                        onPressed: () {
                          setState(() {
                            isFloatingIconActive = !isFloatingIconActive;
                          });
                        }),
                  ),
        bottomNavigationBar: initialBottomNavBar(context),
        backgroundColor: Color(0xff1F3751),
        body: IndexedStack(index: currenIndex, children: screens(context)),
      ),
    );
  }

  Widget initialBottomNavBar(context) {
    if (currenIndex == 3 || currenIndex == 1 || currenIndex == 2) {
      return SizedBox();
    } else {
      return bottomNavBar(context);
    }
  }

  onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to exit an App'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      },
    );
  }

  Widget bottomNavBar(context) {
    ConsumerAccountModel consumerAccountModel =
        Provider.of<ConsumerAccountModel>(context);
  return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.loose,
      alignment: AlignmentDirectional.center,
      children: [
        isFloatingIconActive
            ? Positioned(
                bottom: 0,
                child: Container(
                  color: HexColor('#2A4460'),
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                ))
            : SizedBox(),
        AnimatedBottomNavigationBar.builder(
            itemCount: 4,
            tabBuilder: (int index, bool isActive) {
              final color =
                  isActive ? MasterStyle.quaternaryColor : Colors.white;
              final IconsData = index != 3
                  ? Container(
                      child: SvgPicture.asset(
                          'assets/home_assets/${svgList[index]}'))
                  : consumerAccountModel.consumer.profilePic !='' ?Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                   consumerAccountModel.consumer.profilePic
                                      ))),
                      height: 23,
                      width: 23,
                    ): Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                          shape: BoxShape.circle,
                          ),
                          child: Center(
                                      child: Text(
                                        consumerAccountModel
                                            .consumer.firstName
                                            .split("")
                                            .first
                                            .toString()
                                            .toUpperCase(),
                                        style: MasterStyle.dashbordHeader.merge(
                                            TextStyle(
                                                color: MasterStyle.thedaryColor,
                                                fontSize: 12.sp,fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                      height: 23,
                      width: 23,
                    );
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconsData,
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      textList[index],
                      maxLines: 1,
                     
                      style: MasterStyle.bottombarTextStyle.merge(TextStyle(
                          color: index == 0
                              ? MasterStyle.quaternaryColor
                              : color)),
                    ),
                  )
                ],
              );
            },
            backgroundColor: MasterStyle.bottomBarBackgroundColor,
            activeIndex: currenIndex,
            // notchAndCornersAnimation: animation,
            notchSmoothness: NotchSmoothness.softEdge,
            gapLocation: GapLocation.center,
            leftCornerRadius: 26,
            rightCornerRadius: 26,
            onTap: (index) {
              setState(() => currenIndex = index);
              if (index == 0) {
                setState(() {
                  isHomePage = true;
                  isInbox = false;
                  isNotification = false;
                });
              }
              if (currenIndex == 3 || currenIndex == 1 || currenIndex == 2) {
                print('callindex');
                setState(() {
                  isHomePage = false;
                  isBroker = false;
                  isNotification = false;
                  isInbox = false;
                });
              }
            }),
      ],
    );
  }
}
