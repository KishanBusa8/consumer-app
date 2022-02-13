import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/models/lodged_enquiry_model.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:timelines/timelines.dart';

const kTileHeight = 50.0;

const completeColor = Color(0xff5e6172);
const inProgressColor = Color(0xff5ec792);
const todoColor = Color(0xffd1d2d7);

class LodgedLoanProcessTimelinePage extends StatefulWidget {
  late dynamic loan;
  late dynamic brokerDetail;
  dynamic statusName;
  LodgedLoanProcessTimelinePage(
      {Key? key, required this.loan, required this.brokerDetail, this.statusName})
      : super(key: key);
  @override
  _LodgedLoanProcessTimelinePageState createState() =>
      _LodgedLoanProcessTimelinePageState();
}

class _LodgedLoanProcessTimelinePageState
    extends State<LodgedLoanProcessTimelinePage> {
  int _processIndex = 2;
  List imgList = [
    'initial_conversation_process',
    'document_process',
    'submit_process',
    'pre_approval_process',
    'final_approval_process',
    'funded_process'
  ];

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return todoColor;
    } else {
      return completeColor;
    }
  }

  getTheColor(
    index,
  ) {
    var color;
    Color white = Colors.white;
    Color green = Colors.green;
    if (index == 0) {
      if (initialConversationIsActive) {
        color = green;
      } else {
        color = white;
      }
    }
    if (index == 1) {
      if (applicationDocumentsIsActive) {
        color = green;
      } else {
        color = white;
      }
    }
    if (index == 2) {
      if (submitToLenderIsActive) {
        color = green;
      } else {
        color = white;
      }
    }
    if (index == 3) {
      if (preApprovalIsActive) {
        color = green;
      } else {
        color = white;
      }
    }
    if (index == 4) {
      if (finalApprovalIsActive) {
        color = green;
      } else {
        color = white;
      }
    }
    if (index == 5) {
      if (fundedIsCompleted) {
        color = green;
      } else {
        color = white;
      }
    }

    return color;
  }

  getDotIndicatorChild(index, conditionActive, conditionComplete) {
    var dotWidget;
    Color bgColor = getTheColor(index);
    if (widget.statusName == 'Settled') {
       if (conditionComplete) {
        dotWidget = DotIndicator(
            size: 20.0,
            color: Colors.white,
            child: Icon(
              Icons.check,
              color: MasterStyle.backgroundColor,
              size: 15.0,
            ));
      } else {
        dotWidget = OutlinedDotIndicator(
          backgroundColor: Colors.white.withOpacity(.2),
          borderWidth: 4.0,
          color: Colors.white.withOpacity(.3),
        );
      }
    } else {
      if (conditionActive) {
        dotWidget = DotIndicator(
            size: 20.0,
            color: bgColor,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: CircularProgressIndicator(
                strokeWidth: 1.0,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),)
        );
      } else if (conditionComplete) {
        dotWidget = DotIndicator(
            size: 20.0,
            color: bgColor,
            child: Icon(
              Icons.check,
              color: MasterStyle.backgroundColor,
              size: 15.0,
            ));
      } else {
        dotWidget = OutlinedDotIndicator(
          backgroundColor: Colors.white.withOpacity(.2),
          borderWidth: 4.0,
          color: Colors.white.withOpacity(.3),
        );
      }
    }

      return dotWidget;
    }


  late bool initialConversationIsActive;
  late bool initialConversationIsComplete;
  late bool applicationDocumentsIsActive;
  late bool applicationDocumentsIsComplete;
  late bool submitToLenderIsActive;
  late bool submitToLenderIsCompleted;
  late bool preApprovalIsActive;
  late bool preApprovalIsCompleted;
  late bool finalApprovalIsActive;
  late bool finalApprovalIsCompleted;
  late bool fundedIsCompleted;
  @override
  Widget build(BuildContext context) {
    initialConversationIsActive = widget.loan.documents == 0 &&
        widget.loan.status != 3 &&
        widget.loan.status != 5 &&
        widget.loan.status != -1 &&
        widget.brokerDetail != "";
    initialConversationIsComplete = widget.loan.documents == 1 ||
        widget.loan.status == 3 ||
        widget.loan.status == 5 ||
        widget.loan.status == -1;

    applicationDocumentsIsActive = widget.loan.documents == 1 &&
        widget.loan.status != 3 &&
        widget.loan.status != 5 &&
        widget.loan.status != -1 &&
        widget.brokerDetail != '';
    applicationDocumentsIsComplete = widget.loan.status == 3 ||
        widget.loan.status == 5 ||
        widget.loan.status == -1;

    submitToLenderIsActive = widget.loan.status == 5 &&
        widget.loan.status != 3 &&
        widget.loan.status != -1;
    submitToLenderIsCompleted =
        widget.loan.status == 3 || widget.loan.status == -1;

    preApprovalIsActive = widget.loan.status == 3 &&
        widget.loan.approvedType == 'conditional' &&
        widget.loan.status != -1;
    preApprovalIsCompleted = widget.loan.status == -1 ||
        (widget.loan.status == 3 &&
            widget.loan.approvedType == 'un-conditional');
    finalApprovalIsActive = widget.loan.status == 3 &&
        widget.loan.approvedType == 'un-conditional' &&
        widget.loan.status != -1;
    finalApprovalIsCompleted = widget.loan.status == -1;

    fundedIsCompleted =
        widget.loan.status == -1 && widget.loan.closingStatus == "1";
print("-------------$fundedIsCompleted");
print(  widget.loan.closingStatus);
    return Container(
      height: 150,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            FixedTimeline.tileBuilder(
              direction: Axis.horizontal,
              builder: TimelineTileBuilder.connected(
                itemExtentBuilder: (_, __) =>
                    MediaQuery.of(context).size.width / 4,
                contentsAlign: ContentsAlign.basic,
                oppositeContentsBuilder: (context, index) {
                  var iconColor = getTheColor(index);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: SvgPicture.asset(
                        'assets/myloans/${imgList[index]}.svg',
                        color:index==5?Colors.white: iconColor //getColor(index),
                        ),
                  );
                },
                contentsBuilder: (context, index) {
                  var textColor = getTheColor(index);
                  return Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      _processes[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:index==5?Colors.white: textColor, // getColor(index),
                        fontSize: 13,
                      ),
                    ),
                  );
                },
                indicatorBuilder: (_, index) {
                  var color;
                  var child;

                  var childWidget;
                  if (index == 0) {
                    childWidget = getDotIndicatorChild(
                        index,
                        initialConversationIsActive,
                        initialConversationIsComplete);
                  }
                else  if (index == 1) {
                    childWidget = getDotIndicatorChild(
                        index,
                        applicationDocumentsIsActive,
                        applicationDocumentsIsComplete);
                  }
                else  if (index == 2) {
                    childWidget = getDotIndicatorChild(
                        index,
                        submitToLenderIsActive,
                        submitToLenderIsCompleted);
                  }else if (index == 3) {
                    childWidget = getDotIndicatorChild(
                        index,
                        preApprovalIsActive,
                        preApprovalIsCompleted);
                  }else  if (index == 4) {
                    childWidget = getDotIndicatorChild(
                        index,
                        finalApprovalIsActive,
                        finalApprovalIsCompleted);
                  }else  if (index == 5) {
                    childWidget = getDotIndicatorChild(
                        index,
                        false,
                        fundedIsCompleted);
                  }
              //    if ( index <= _processIndex) {


                    return Stack(
                      children: [
                        CustomPaint(
                          size: Size(15.0, 15.0),
                          painter: _BezierPainter(
                            color: todoColor,
                            // index == _processIndex ? Colors.green : Colors.white,
                            drawStart:false,
                             //   index == 0 ? false : index <= _processIndex,
                            drawEnd: false,
                            //index == 5 ? false : index < _processIndex,
                          ),
                        ),
                        childWidget

                      ],
                    );
                //  }
                  // else
                  //   {
                  //   return Stack(
                  //     children: [
                  //       CustomPaint(
                  //         size: Size(15.0, 15.0),
                  //         painter: _BezierPainter(
                  //             color: color, drawEnd: false, drawStart: false),
                  //       ),
                  //       OutlinedDotIndicator(
                  //         backgroundColor: Colors.white.withOpacity(.2),
                  //         borderWidth: 4.0,
                  //         color: Colors.white.withOpacity(.3),
                  //       ),
                  //     ],
                  //   );
                  // }
                },
                connectorBuilder: (_, index, type) {
                  if (index > 0) {
                    if (index == _processIndex) {
                      if (type == ConnectorType.start) {
                      } else {

                      }
                      return SolidLineConnector(
                        color: todoColor, //Colors.white.withOpacity(.3),
                      );
                    } else {
                      return SolidLineConnector(
                          color: todoColor //getColor(index),
                          );
                    }
                  } else {
                    return SolidLineConnector(
                        color: todoColor // getColor(index),
                        );
                  }
                },
                itemCount: _processes.length,

              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// hardcoded bezier painter
class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius, radius)
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(
            size.width, size.height / 2, size.width + radius, radius)
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}

final _processes = [
  'Initial conversation',
  'Application & documents',
  'Submit to a lender',
  'Pre-approval  ',
  'Final approval',
  'Funded'
];
