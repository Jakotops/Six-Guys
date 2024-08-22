
import 'package:flutter/material.dart';
import 'package:stockit/assetBlock.dart';
import 'package:stockit/pages/moneyInput.dart';
import 'package:stockit/wrapper.dart';

import '../investmentClass.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  List<InvestmentClass> assets = [];


  final assetController = TextEditingController();
  PrimitiveWrapper date = PrimitiveWrapper("");
  final amountController = TextEditingController();
  PrimitiveWrapper gainOrLoss = PrimitiveWrapper(0);

  String sumInvestment(){

    double sum = 0;

    for (int index = 0; index < assets.length; index++){
      sum = sum + assets[index].amountInvested + assets[index].lossOrGain;

    }

    return sum.toStringAsFixed(2);

  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      color: Colors.grey[900],
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: size.height * 0.075),
                Text(
                  "StockIt",
                  style: TextStyle(
                      color: Colors.grey[200], fontSize: size.width * 0.05),
                ),
                SizedBox(height: size.height * 0.025),
                Text(
                  '£${sumInvestment()}',
                  style: TextStyle(
                      color: Colors.grey[200], fontSize: size.width * 0.125),
                ),
                SizedBox(height: size.height * 0.025),
                InkWell(
                  onTap: () async{
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MoneyInput(
                            assetController: assetController,
                            date: date,
                            amountController: amountController,
                            gainOrLoss: gainOrLoss,
                          );
                        });
                    print(gainOrLoss.value);
                    assets.add(InvestmentClass(date: date.value, amountInvested: double.parse(amountController.text), lossOrGain: gainOrLoss.value, symbol: assetController.text));
                    setState(() {
                      assetController.clear();
                      date.value = "";
                      amountController.clear();
                      gainOrLoss.value = 0;
                    });

                    print(assets[0].lossOrGain);



                  },
                  child: Container(
                    width: size.width * 0.4,
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Record Asset",
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: size.width * 0.05),
                      ),
                    ),
                  ),
                )
              ],
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.6,
              maxChildSize: 0.8,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.width * 0.1),
                    topRight: Radius.circular(size.width * 0.1),
                  ),
                  child: Container(
                    width: size.width,
                    color: Colors.white,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Column(children: [
                          IgnorePointer(
                              child: Container(
                                  width: size.width,
                                  height: size.height * 0.03,
                                  color: Colors.white,
                                  child: Column(children: [
                                    SizedBox(
                                      height: size.height * 0.0075,
                                    ),
                                    Container(
                                      width: size.width * 0.2,
                                      height: size.height * 0.006,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[500],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  size.width * 0.01))),
                                    ),

                                    // Text(
                                    //   "Completed Tasks",
                                    //   style: TextStyle(fontSize: size.width * 0.05),
                                    // ),
                                  ]))),
                          Text(
                            "Portfolio",
                            style: TextStyle(
                              fontSize: size.width * 0.05,
                            ),
                          ),
                          SizedBox(height: size.height*0.01,),
                          assets.length == 0?
                              Column(
                                children: [
                                  SizedBox(height: size.height*0.2,),
                                  Text("No Recorded Investments",
                                  style: TextStyle(
                                    color: Colors.red
                                  ),),
                                ],
                              ):
                          SizedBox(
                            height: size.height*0.5,
                            child: GridView.count(
                                crossAxisCount: 2,
                            crossAxisSpacing: size.width*0.05,
                            mainAxisSpacing: size.height*0.025,
                            padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                            children: [
                              for (int index = 0; index < assets.length; index++)
                                AssetBlock(investmentClass: assets[index])

                            ],),
                          )
                        ]),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
