// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hashching/Utilities/newloan_process_timeline.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/models/newloan_enquirey_model.dart';
import 'package:hashching/pages/myloans/enquirey_details/newloan_enquirey_timeline.dart';
import 'package:hashching/services/api_services.dart';
import 'package:hashching/styles/masterstyle.dart';

class NewLoanEnquireyDetails extends StatefulWidget {
  NewLoanEnquireyDetails(
      {Key? key, required this.encryptkey, this.loanTypeDisplay})
      : super(key: key);
  String encryptkey;
  dynamic loanTypeDisplay;

  @override
  _NewLoanEnquireyDetailsState createState() => _NewLoanEnquireyDetailsState();
}

class _NewLoanEnquireyDetailsState extends State<NewLoanEnquireyDetails> {
  late Future<NewLoanEnquiryModel?> fetchLoanEnquireyDetails;
  @override
  void initState() {
    fetchLoanEnquireyDetails =
        ApiServices.fetchNewLoanDetails(encryptId: widget.encryptkey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MasterStyle.backgroundColor,
      appBar: SimplifiedWidgets.appbar(
          appBarTitle: 'Enquiry Details', context: context),
      body: FutureBuilder<NewLoanEnquiryModel?>(
          future: fetchLoanEnquireyDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var loanEnquireyModel = snapshot.data;
              print('loanEnquireyMode${loanEnquireyModel!}');

              return Container(
                  child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: NewLoanProcessTimelinePage()),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Loan details',
                            style: MasterStyle.whiteTextStyleMedium,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          myEnquireyCards(
                              title: 'Settled', onTap: () {}, isClick: false),
                          Container(
                            height: 1,
                          ),
                          myEnquireyCards(
                              title: 'Approved', onTap: () {}, isClick: false),
                          Container(
                            height: 1,
                          ),
                          myEnquireyCards(
                              title: 'Lodged', onTap: () {}, isClick: false),
                          Container(
                            height: 1,
                          ),
                          myEnquireyCards(
                              title: 'Enquirey Details',
                              onTap: () {},
                              isClick: true),
                          Container(
                            height: 1,
                          ),
                          //  NewLoanEnquireyReport(loanEnquireyModel: loanEnquireyModel),
                          MySizedBox.height(16),
                          Text(
                            'Timeline',
                            style: MasterStyle.whiteMediumHeader,
                          ),
                          MySizedBox.height(16),
                          NewLoanEnquireyTimeline(),
                          MySizedBox.height(26),
                        ]),
                  ),
                ],
              ));
            }
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(MasterStyle.appSecondaryColor),
            ));
          }),
    );
  }

  Widget myEnquireyCards(
      {required String title,
      required void Function() onTap,
      required bool isClick}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
        elevation: 0,
        margin: EdgeInsets.zero,
        color: MasterStyle.whiteColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 23.0, top: 18, bottom: 15),
          child: Text(
            title,
            style: isClick
                ? MasterStyle.appBarSecondaryBoldStyle
                : MasterStyle.unselectstatusStyle,
          ),
        ),
      ),
    );
  }
}
