import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:timelines/timelines.dart';

const kTileHeight = 50.0;

const completeColor = Color(0xff5e6172);
const inProgressColor = Color(0xff5ec792);
const todoColor = Color(0xffd1d2d7);

class NewLoanProcessTimelinePage extends StatefulWidget {
  @override
  _NewLoanProcessTimelinePageState createState() => _NewLoanProcessTimelinePageState();
}

class _NewLoanProcessTimelinePageState extends State<NewLoanProcessTimelinePage> {
  int _processIndex = 2;
   List imgList = ['initial_conversation_process','document_process', 'submit_process', 'pre_approval_process', 'final_approval_process','funded_process'];


  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return todoColor;
    } else {
      return completeColor;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    MediaQuery.of(context).size.width /4,
                contentsAlign: ContentsAlign.basic,
                oppositeContentsBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: SvgPicture.asset(
                    'assets/myloans/${imgList[index]}.svg',
                    color: Colors.grey//getColor(index),
                  ),
                ),
                contentsBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    _processes[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:todoColor,// getColor(index),
                      fontSize: 13,
                    ),
                  ),
                ),
                indicatorBuilder: (_, index) {
                  var color;
                  var child;
                  if (index == _processIndex) {
                    color = Colors.white;;
                    child = Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    );
                  } else if (index < _processIndex) {
                    color = Colors.white;
                    child = Icon(
                      Icons.check,
                      color: MasterStyle.backgroundColor,
                      size: 15.0,
                    );
                  } else {
                    color = todoColor;
                  }
      
                  // if (index <= _processIndex) {
                  //   return Stack(
                  //     children: [
                  //       CustomPaint(
                  //         size: Size(20.0, 20.0),
                  //         painter: _BezierPainter(
                  //           color:todoColor,
                  //              // index == _processIndex ? Colors.green : Colors.white,
                  //           drawStart: index <= _processIndex,
                  //           drawEnd: index < _processIndex,
                  //         ),
                  //       ),
                  //       DotIndicator(
                  //         size: 20.0,
                  //         color: color,
                  //         child: child,
                  //       ),
                  //     ],
                  //   );
                  // } 
                  
                 // else {
                    return Stack(
                      children: [
                        CustomPaint(
                          size: Size(15.0, 15.0),
                          painter: _BezierPainter(
                              color: color, drawEnd: false, drawStart: false),
                        ),
                        OutlinedDotIndicator(
                          backgroundColor: Colors.white.withOpacity(.2),
                          borderWidth: 4.0,
                          color:Colors.white.withOpacity(.3),
                        ),
                      ],
                    );
                 // }
                },
                connectorBuilder: (_, index, type) {
                  if (index > 0) {
                    if (index == _processIndex) {
                      if (type == ConnectorType.start) {
                      } else {
                      }
                      return SolidLineConnector(
                        color:todoColor,//Colors.white.withOpacity(.3),
                      );
                    } else {
                      return SolidLineConnector(
                        color: todoColor//getColor(index),
                      );
                    }
                  } else {
                    return SolidLineConnector(
                      color:todoColor// getColor(index),
                    );
                  }
                },
                itemCount: _processes.length,
                // firstConnectorBuilder: (context) {
                //   return 
                //   SolidLineConnector(
                //     color:Colors.transparent//Colors.white,
                //   );
                // },
                // lastConnectorBuilder: (context) {
                //   return
                  
                //    SolidLineConnector(
                //     color:Colors.transparent//Colors.white.withOpacity(.3),
                //   );
                // },
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
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius)
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
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) 
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
