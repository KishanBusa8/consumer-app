import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/Utilities/constants.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/models/consumer_dashboard_model.dart';
import 'package:hashching/models/fetch_loan_model.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/hexcolor.dart';
import 'package:hashching/styles/masterstyle.dart';

class CompleteTask extends StatefulWidget {
  const CompleteTask({Key? key, required this.encryptId,required this.statusName})
      : super(key: key);

  final String encryptId;
  final String statusName;

  @override
  _CompleteTaskState createState() => _CompleteTaskState();
}

class _CompleteTaskState extends State<CompleteTask> {
  List<AllLoans> consumerLoansList=[];
 late FetchLoanModel? fetchLoanModel;
  bool isLoading = false;
  bool setInitThe = false;
  initialData()  async {

    setState(() {
      setInitThe = true;
    });
   fetchLoanModel = await ApiServices.fetchLoans(encryptId:widget.encryptId);
    setState(() {
      setInitThe = false;
    });
  
  }
  @override
  void initState() {
   initialData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar: SimplifiedWidgets.appbar(
          appBarTitle: 'Complete task', context: context),
      body: setInitThe?  Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(MasterStyle.appSecondaryColor))): Column(
        children: [
          completedTaskCards(
              consumerLoans: fetchLoanModel!),
        ],
      )
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
    required FetchLoanModel consumerLoans,
  }) {

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
                      getImageAssets(consumerLoans.loan.productType),
                      height: 31.1.h,
                      width: 32.54.w,
                    )),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            consumerLoans.loan.loantypeLabel,
                            style: MasterStyle.blackTextSemiBoldMediumSize,
                          ),
                          SizedBox(
                            width: 9.w,
                          ),
                          Text(
                            widget.statusName,
                            style:  widget.statusName == 'Settled' ||
                                widget.statusName == 'New'
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
                            "Submitted on: ${consumerLoans.loan.createdAt}",
                            style: MasterStyle.greySmallStyle,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '\$${consumerLoans.loan.loanAmount}',
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
           Visibility(
             child: InkWell(
              onTap: (){
                SimplifiedWidgets.launchInBrowser(consumerLoans.loan.bankStatementIframeLink, context);
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
             visible:  consumerLoans.loan.bankStatementRequest,
           ),
          Visibility(
            child: InkWell(
              onTap: (){
                SimplifiedWidgets.launchInBrowser(consumerLoans.loan.mystroServicesList[0].iframeLink, context);
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
            visible:  consumerLoans.loan.leadDetailsMystroRequested,
          ),
        ],
      ),
    );

  }

  submitCompleteFactFind(encrypt_id) async{

    var iFrameLink = await  ApiServices.getIFrameLink(encrypt_id);
  }
}
