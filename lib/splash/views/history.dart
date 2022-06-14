import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpi/components/components.dart';
import 'package:qpi/controller/history_controller.dart';
import 'package:qpi/splash/views/home.dart';
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/size_config.dart';

class History extends StatelessWidget {
  const History({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyController = Get.put(HistoryController());

    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,

              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Image(
                      image: AssetImage('assets/img/bg_color.png'),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: regularText("\nOrder History", 2.5, Colors.white,
                            FontWeight.bold, 1))
                  ],
                ),
              ),
              // pinned: true,
              expandedHeight: SizeConfig.screenHeight * 0.2,
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: regularText(
                        "Orders: " +
                                historyController.historyList.length
                                    .toString() ??
                            0,
                        1.9,
                        Constants.grey,
                        FontWeight.bold,
                        2),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.8,
                    child: ListView.builder(
                      itemCount: historyController.historyList.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext ctxt, int index) {
                        print(historyController.historyList[index].toString());
                        return InkWell(
                            onTap: () {},
                            child: Container(
                              margin:
                                  EdgeInsets.all(SizeConfig.heightMultiplier),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(
                                      1.0,
                                      1.0,
                                    ),
                                    blurRadius: 7.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: Image.asset(
                                  'assets/img/rupeeicon.png',
                                  width: SizeConfig.heightMultiplier * 8,
                                  height: SizeConfig.heightMultiplier * 8,
                                ),
                                title: regularText(
                                  historyController.historyList[index].bstatus
                                      .toString(),
                                  2.0,
                                  Colors.black,
                                  FontWeight.normal,
                                  0,
                                ),
                                subtitle: regularText(
                                  "Order Date: " +
                                      historyController
                                          .historyList[index].orderdate +
                                      "\n" +
                                      "Order ID: " +
                                      historyController.historyList[index].id,
                                  2.0,
                                  Colors.black,
                                  FontWeight.normal,
                                  0,
                                ),
                                trailing: regularText(
                                    "₹\n" +
                                        historyController
                                            .historyList[index].price
                                            .toString(),
                                    1.9,
                                    Constants.grey,
                                    FontWeight.bold,
                                    0),
                              ),
                            )
                            //     Container(
                            //   width: double.infinity,
                            //   decoration: BoxDecoration(
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.grey.withOpacity(0.3),
                            //         offset: Offset(
                            //           1.0,
                            //           1.0,
                            //         ),
                            //         blurRadius: 15.0,
                            //         spreadRadius: 2.0,
                            //       ),
                            //     ],
                            //   ),
                            //   child: regularText(
                            //     historyController.historyList[index].name +
                            //         index.toString(),
                            //     2.0,
                            //     Colors.black,
                            //     FontWeight.normal,
                            //     0,
                            //   ),
                            // ),

                            );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
