import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/Utilities/constants.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/consumer_dashboard.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class CompleteTask extends StatefulWidget {
  const CompleteTask({Key? key, required this.consumerDashboardModel})
      : super(key: key);
  final ConsumerDashboardModel consumerDashboardModel;

  @override
  _CompleteTaskState createState() => _CompleteTaskState();
}

class _CompleteTaskState extends State<CompleteTask> {
  List<AllLoans> consumerLoansList=[];
  bool isLoading = false;
  initialData(){
    for(var i =0; i<widget.consumerDashboardModel.allLoans.length;i++){
      var status =widget.consumerDashboardModel.allLoans[i].statusname;
   if( status == 'Qualified'||status == 'Assigned'|| status == 'Onhold'){
     consumerLoansList.add(widget.consumerDashboardModel.allLoans[i]);
     }

    }
    setState(() {
      isLoading = true;
    });
  
  }
  @override
  void initState() {
  // initialData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("object${widget.consumerDashboardModel.allLoans.length}");
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar: SimplifiedWidgets.appbar(
          appBarTitle: 'Complete task', context: context),
      body: ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.consumerDashboardModel.allLoans.length,
        itemBuilder: (BuildContext context, int index) {
          return completedTaskCards(
              consumerLoans: widget.consumerDashboardModel.allLoans[index]);
        },
      ),
    );
  }

  String getImageAssets(String loanType) {
    switch (loanType) {
      case 'Home Loan':
        return 'assets/home_assets/home_loan.svg';

      case 'Personal Loan':
        return 'assets/home_assets/personal_loan.svg';

      case 'Business Loan':
        return 'assets/home_assets/business_loan.svg';

      case 'Educational Loan':
        return 'assets/home_assets/scholarship.svg';

      case 'Car Finance':
        return 'assets/home_assets/car_loan.svg';

      case 'Assets & Equipment Finance':
        return 'assets/home_assets/assets_finance_loan.svg';

      default:
        return 'assets/home_assets/personal_loan.svg';
    }
  }

  Widget completedTaskCards({
    required AllLoans consumerLoans,
  }) {
         var status = consumerLoans.statusname;
    if(status == 'Qualified'||status == 'Assigned'|| status == 'Onhold'){
   return Container(
      margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
      decoration: BoxDecoration(
          color: MasterStyle.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: HexColor("#F7F7F7"),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              children: [
                Container(
                    height: 33.1.h,
                    width: 33.54.w,
                    margin: EdgeInsets.only(right: 11.w),
                    child: SvgPicture.asset(
                      getImageAssets(consumerLoans.loantypeshow),
                      height: 31.1.h,
                      width: 32.54.w,
                    )),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            consumerLoans.loantypeshow.toString(),
                            style: MasterStyle.blackTextSemiBoldMediumSize,
                          ),
                          SizedBox(
                            width: 9.w,
                          ),
                          Text(
                            consumerLoans.statusname,
                            style: consumerLoans.statusname == 'Settled' ||
                                    consumerLoans.statusname == 'New'
                                ? MasterStyle.possitiveStatusStyle
                                : MasterStyle.assignedStatusStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Submitted on: ${consumerLoans.createdate}",
                            style: MasterStyle.greySmallStyle,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '\$${consumerLoans.loanAmount}',
                                style: MasterStyle.blackTextStyleNormalSize,
                                // minFontSize: 10,
                                // maxFontSize: 15,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: (){
              SimplifiedWidgets.launchInBrowser(LocalConstants.uploadBankStatement, context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: HexColor("#E4E4E4")))),
              child: Center(
                child: Text(
                  "Upload bank statements",
                  style: MasterStyle.primaryContent,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              SimplifiedWidgets.launchInBrowser(LocalConstants.completeFactFind, context);
              // submitCompleteFactFind(consumerLoans.encryptkey);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Center(
                child: Text(
                  "Complete fact find",
                  style: MasterStyle.primaryContent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
 
    }
    return SizedBox();
  }

  submitCompleteFactFind(encrypt_id) async{

    var iFrameLink = await  ApiServices.getIFrameLink(encrypt_id);
  }
}
