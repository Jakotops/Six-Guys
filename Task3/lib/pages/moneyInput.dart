import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'dart:math';

import 'package:stockit/wrapper.dart';

class MoneyInput extends StatefulWidget {
  final TextEditingController assetController;
  PrimitiveWrapper date;
  final TextEditingController amountController;
  PrimitiveWrapper gainOrLoss;
  MoneyInput(
      {super.key,
      required this.assetController,
      required this.date,
      required this.amountController,
      required this.gainOrLoss});

  @override
  State<MoneyInput> createState() => _MoneyInputState();
}

class _MoneyInputState extends State<MoneyInput> {
  DateTime _selectedDate = DateTime.now().subtract(Duration(days: 1));
  bool loading = false;

  void _showErrorMessage(String message) {
    // You can use a SnackBar to show an error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final random = Random();
    widget.date.value = DateFormat("yyyy-MM-dd").format(_selectedDate);
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: Colors.grey[200],
      content: SizedBox(
        height: size.height * 0.55,
        width: size.width * 0.8,
        child: Column(children: [
          Align(
            alignment: Alignment.centerRight,
            child:  GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: size.width*0.075,
              ),
            )
          ),
          Text(
            "Record Investment",
            style: TextStyle(fontSize: size.width * 0.06),
          ),
          SizedBox(
            height: size.height*0.025,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Asset",
              style: TextStyle(fontSize: size.width * 0.035),
            ),
          ),
          Container(
            width: size.width * 0.75,
            height: size.height * 0.05,
            decoration: BoxDecoration(
                //color: widget.color,
                border: Border.all(color: Colors.black, width: 2.5),
                borderRadius: BorderRadius.circular(12)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.015, right: size.width * 0.01),
                child: TextFormField(
                  // onTapOutside: (t){
                  //   FocusScope.of(context).unfocus();
                  // },
                  maxLines: 1,
                  scrollPadding: EdgeInsets.only(bottom: size.height * 0.4),
                  controller: widget.assetController,
                  cursorColor: const Color(0xFF3498db),
                  autocorrect: false,
                  // keyboardType: widget.numberOnly != null&&widget.numberOnly == true
                  //     ? TextInputType.number
                  //     : TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Type Symbol, eg. AAPL",
                      hintStyle: TextStyle(
                          color: Colors.grey.shade700, fontSize: size.width * 0.04),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                  style: TextStyle(color: Colors.black, fontSize: size.width * 0.04),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height*0.025,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Amount Invested",
              style: TextStyle(fontSize: size.width * 0.035),
            ),
          ),
          Container(
            width: size.width * 0.75,
            height: size.height * 0.05,
            decoration: BoxDecoration(
              //color: widget.color,
                border: Border.all(color: Colors.black, width: 2.5),
                borderRadius: BorderRadius.circular(12)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.015, right: size.width * 0.01),
                child: TextFormField(
                  // onTapOutside: (t){
                  //   FocusScope.of(context).unfocus();
                  // },
                  maxLines: 1,
                  scrollPadding: EdgeInsets.only(bottom: size.height * 0.4),
                  controller: widget.amountController,
                  cursorColor: const Color(0xFF3498db),
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Type Amount Invested",
                      hintStyle: TextStyle(
                          color: Colors.grey.shade700, fontSize: size.width * 0.04),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                  style: TextStyle(color: Colors.black, fontSize: size.width * 0.04),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height*0.025,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Date Invested",
              style: TextStyle(fontSize: size.width * 0.035),
            ),
          ),
          SizedBox(
            height: size.height*0.1,
            child: ScrollDatePicker(
              selectedDate: _selectedDate,
              options: DatePickerOptions(
                backgroundColor: Colors.grey[200]!,
              ),
              maximumDate: DateTime.now().subtract(Duration(days: 1)),
              locale: Locale('en', 'GB'),
              onDateTimeChanged: (DateTime value) {
                setState(() {
                  _selectedDate = value;
                  widget.date.value = DateFormat("yyyy-MM-dd").format(_selectedDate);
                });
              },
            ),
          ),
          SizedBox(
            height: size.height*0.075,
          ),
          Align(
            alignment: Alignment.centerRight,
            child:  GestureDetector(
              onTap: ()async {

                loading = true;
                try {
                  double amount = double.parse(widget.amountController.text);
                  if(widget.amountController.text.isEmpty || amount == 0) {
                    _showErrorMessage('Please enter a valid amount');
                  }

                  try{
                    // widget.gainOrLoss = await Functionality().calculateGainOrLoss(
                    //     amount, widget.date, widget.assetController.text);

                    widget.gainOrLoss.value = -500 + (random.nextDouble() * (1000));

                    print(widget.gainOrLoss.value);

                    Navigator.pop(context);
                  }
                  catch(e){
                    String message = e.toString();
                    if(message.contains("Date not found in historical data")){
                      _showErrorMessage('Date not found, Please enter a valid date');
                    }
                    if(message.contains("Failed to load historical price")){
                      _showErrorMessage('Failed to load historical price');
                    }
                    if(message.contains("Failed to load current price")){
                      _showErrorMessage('Failed to load current price');
                    }
                    else{
                      _showErrorMessage('API Error');
                    }
                  }





                } catch (e) {
                  _showErrorMessage('Please enter a valid amount');
                }
                loading = false;



              },
              child:
              Container(
                width: size.width * 0.3,
                height: size.height * 0.05,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: loading?
                  CircularProgressIndicator():Text(
                    "Record",
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: size.width * 0.05),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
