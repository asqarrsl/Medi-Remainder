import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medi_remainder/screen/pill_remainder/add_new_medicine/slider.dart';

class FormFields extends StatelessWidget {

  final String selectWeight;
  final int noOfWeeks;
  final TextEditingController amountController;
  final Function onPopUpMenuChanged, onSliderChanged;
  final TextEditingController nameController;
  final List<String> weightValues = ["pills", "ml", "mg"];

  FormFields(this.noOfWeeks, this.selectWeight, this.onPopUpMenuChanged,
      this.onSliderChanged, this.nameController, this.amountController);

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);
    return LayoutBuilder(
      builder: (context, constrains) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: constrains.maxHeight * 0.22,
            child: TextField(
              textInputAction: TextInputAction.next,
              controller: nameController,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0),
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  labelText: "Pills Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(width: 0.5, color: Colors.grey))),
              onSubmitted: (val) => focus.nextFocus(),
            ),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.07,
          ),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: SizedBox(
                  height: constrains.maxHeight * 0.22,
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.0),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5.0),
                        labelText: "Pills Amount",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(width: 0.5, color: Colors.grey))),
                    onSubmitted: (val) => focus.unfocus(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: constrains.maxHeight * 0.07,
          ),
          SizedBox(
            height: constrains.maxHeight * 0.1,
            child: FittedBox(
              child: Text(
                "How long?",
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(
              height: constrains.maxHeight * 0.18,
              child: UserSlider(onSliderChanged, noOfWeeks)),
          Align(
            alignment: Alignment.bottomRight,
            child: FittedBox(child: Text('$noOfWeeks weeks')),
          )
        ],
      ),
    );
  }
}
