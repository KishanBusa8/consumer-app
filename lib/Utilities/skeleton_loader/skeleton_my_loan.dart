import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/Utilities/sizedbox.dart';
import 'package:hashching/styles/masterstyle.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class SkeletonLoaderMyLoan extends StatelessWidget {
  const SkeletonLoaderMyLoan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SkeletonLoader(
        highlightColor: Colors.grey,
        builder: Container(
          margin: EdgeInsets.only(bottom: 10, left: 8, right: 8),
          child: NewColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: Text(
                'Loan ...',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
                padding:
                    EdgeInsets.only(top: 16, bottom: 16, left: 20, right: 20),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: MasterStyle.greyCustomColor, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                child: Column(children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        height: 62,
                        width: 60,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        height: 18,
                        width: 150,
                      )
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NewColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MySizedBox.height(16),
                            Container(
                              color: Colors.white,
                              height: 8,
                              width: 80,
                            ),
                            MySizedBox.height(16),
                            Container(
                              color: Colors.white,
                              height: 8,
                              width: 130,
                            ),
                            MySizedBox.height(16),
                            Container(
                              color: Colors.white,
                              height: 8,
                              width: 110,
                            ),
                            MySizedBox.height(16),
                            Container(
                              color: Colors.white,
                              height: 8,
                              width: 80,
                            ),
                            MySizedBox.height(16),
                          ],
                        ),
                        NewColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MySizedBox.height(16),
                            Container(
                              color: Colors.white,
                              height: 8,
                              width: 90,
                            ),
                            MySizedBox.height(16),
                            Container(
                              color: Colors.white,
                              height: 8,
                              width: 100,
                            ),
                            MySizedBox.height(16),
                            Container(
                              color: Colors.white,
                              height: 8,
                              width: 110,
                            ),
                            MySizedBox.height(16),
                            Container(
                              color: Colors.white,
                              height: 8,
                              width: 80,
                            ),
                            MySizedBox.height(16),
                          ],
                        )
                      ])
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
