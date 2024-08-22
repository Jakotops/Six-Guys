import 'package:stockit/wrapper.dart';

class InvestmentClass {
  final String date;
  final double amountInvested;
  final double lossOrGain;
  final String symbol;

  InvestmentClass(
      {required this.date,
      required this.amountInvested,
      required this.lossOrGain,
      required this.symbol});
}
