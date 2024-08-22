import 'package:flutter/material.dart';
import 'package:stockit/investmentClass.dart';


class AssetBlock extends StatelessWidget {
  final InvestmentClass investmentClass;
  const AssetBlock({super.key, required this.investmentClass});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    return Container(
      width: size.width*0.45,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.grey[200]!,
              investmentClass.lossOrGain > 0? Colors.green:Colors.red,
            ]

        ),
        border: Border.all(color: Colors.black, width: 2),

        borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height*0.01,
            ),
            Text(investmentClass.symbol,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width*0.06
              ),),
            SizedBox(
              height: size.height*0.01,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: size.width*0.025,
                  ),
                  Text("£${investmentClass.amountInvested.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width*0.06
                  ),),
                ],
              ),
            ),
            SizedBox(
              height: size.height*0.01,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SizedBox(width: size.width*0.025,),
                  investmentClass.lossOrGain > 0? Icon(Icons.trending_up_rounded, color: Colors.green,):
                  Icon(Icons.trending_down_rounded, color: Colors.red,),
                  Text("£"+investmentClass.lossOrGain.toStringAsFixed(2),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width*0.04
                    ),),
                ],
              ),
            ),
            SizedBox(
              height: size.height*0.01,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SizedBox(width: size.width*0.025,),
                  Text(investmentClass.date,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width*0.04
                    ),),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
