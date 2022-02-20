import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';

String? budgetFrom, budgetTo;

class BudgetBottomSheet extends StatelessWidget {
  const BudgetBottomSheet({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
          decoration: BoxDecoration(color: ColorManager.whiteWithOpecity1),
          height: MediaQuery.of(context).copyWith().size.height * .32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(AppPadding.p12),
                height: MediaQuery.of(context).copyWith().size.height * .05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select your budget",
                      overflow: TextOverflow.visible,
                      style: getRegularSalsaStyle(
                          color: ColorManager.black, fontSize: FontSize.s16),
                    ),
                    IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.clear_outlined))
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).copyWith().size.height * .2,
                child: Row(
                  children: [
                    Flexible(
                      flex: 10,
                      fit: FlexFit.tight,
                      child: TextField(
                        onChanged: (value) {
                          budgetFrom = value;
                        },
                        keyboardType: TextInputType.number,
                        style: getBoldStyle(color: ColorManager.black),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14),
                          prefixIcon: Image.asset(
                            ImageStrings.budget,
                          ),
                          hintText: 'From',
                          hintStyle: getBoldStyle(color: ColorManager.black),
                        ),
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          "-",
                          style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s36),
                        )),
                    Flexible(
                      flex: 10,
                      fit: FlexFit.tight,
                      child: TextField(
                        onChanged: (value) {
                          budgetTo = value;
                        },
                        keyboardType: TextInputType.number,
                        style: getBoldStyle(color: ColorManager.black),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14),
                          prefixIcon: Image.asset(
                            ImageStrings.budget,
                          ),
                          hintText: 'To',
                          hintStyle: getBoldStyle(color: ColorManager.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: MediaQuery.of(context).copyWith().size.height * .05,
                  margin: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).copyWith().size.width * .35,
                  ),
                  decoration: BoxDecoration(
                      color: ColorManager.confirm,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlexText(
                        title: "Confirm",
                        style: getBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s14),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.check_outlined,
                        color: ColorManager.whiteWithOpecity1,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ));
    });
  }
}
