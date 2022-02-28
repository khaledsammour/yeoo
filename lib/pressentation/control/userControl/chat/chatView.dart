import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yeeo/pressentation/control/chat/chatDetailView.dart';
import 'package:yeeo/pressentation/control/userControl/chat/chatViewModel.dart';
import 'package:yeeo/pressentation/control/userControl/controlViewModel.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';
import 'package:yeeo/pressentation/widget/flexTextFiled.dart';
import 'package:yeeo/pressentation/widget/loadingWidget.dart';

import '../../../resource/stringsManager.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: GetX<ChatViewModel>(
          init: ChatViewModel(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 40.h,
                  margin: EdgeInsets.only(left: 156.w),
                  child: FlexText(
                    title: "Chats",
                    style: getMPlus1cStyle(
                        color: ColorManager.black, fontSize: FontSize.s36),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                SizedBox(
                  height: 35.h,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16.w,
                      ),
                      FlexText(
                        title: "search:",
                        style: getMPlus1cStyle(
                            color: ColorManager.black, fontSize: FontSize.s24),
                      ),
                      FlexTextFiled(
                          validator: (p0) {},
                          width: 256,
                          textInputType: TextInputType.text,
                          autofillHints: AutofillHints.name,
                          onChanged: (v) {},
                          left: 16),
                    ],
                  ),
                ),
                SizedBox(
                  height: 48.h,
                ),
                controller.loading.value
                    ? LoadingWidget()
                    : Flexible(
                        child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            controller.chatModel.length,
                            (index) => GetBuilder<ControlViewModel>(
                                init: ControlViewModel(),
                                builder: (controlControlller) {
                                  return GestureDetector(
                                    onTap: () {
                                      controlControlller.currentScreen =
                                          ChatDetailView(
                                        chatModel: controller.chatModel[index],
                                      );
                                      controlControlller.update();
                                    },
                                    child: Container(
                                      height: 74.h,
                                      margin: EdgeInsets.only(top: 18.h),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 14.w,
                                          ),
                                          Container(
                                            width: 95.w,
                                            height: 74.h,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        controller
                                                            .chatModel[index]
                                                            .serviceProviderImg),
                                                    fit: BoxFit.fill),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        167.r)),
                                          ),
                                          SizedBox(
                                            width: 11.w,
                                          ),
                                          Container(
                                            width: 209.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 36.h,
                                                  child: FlexText(
                                                    title: controller
                                                        .chatModel[index]
                                                        .serviceProviderName,
                                                    style: getRegularSalsaStyle(
                                                        color:
                                                            ColorManager.black,
                                                        fontSize: FontSize.s24),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Container(
                                                  height: 30.h,
                                                  child: FlexText(
                                                    title: controller
                                                        .chatModel[index]
                                                        .lastmessage,
                                                    style: getMPlus1cStyle(
                                                        color:
                                                            ColorManager.black,
                                                        fontSize: FontSize.s24),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 70.w,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Container(
                                                  height: 50.h,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        height: 23.h,
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: FlexText(
                                                          title: DateFormat(
                                                                  "k:mm a")
                                                              .format(DateTime
                                                                  .parse(controller
                                                                      .chatModel[
                                                                          index]
                                                                      .lastTimeStamp)),
                                                          style: getRegularSalsaStyle(
                                                              color:
                                                                  ColorManager
                                                                      .black,
                                                              fontSize:
                                                                  FontSize.s24),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 15.h,
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: controller
                                                                    .chatModel[
                                                                        index]
                                                                    .lastSender ==
                                                                controller
                                                                    .userModel
                                                                    .userId
                                                            ? Stack(
                                                                children: [
                                                                  Image.asset(
                                                                      ImageStrings
                                                                          .messageSent),
                                                                  Container(
                                                                      margin: EdgeInsets.only(
                                                                          left: 9
                                                                              .w),
                                                                      child: Image.asset(
                                                                          ImageStrings
                                                                              .messageSent)),
                                                                ],
                                                              )
                                                            : Stack(
                                                                children: [
                                                                  Image.asset(
                                                                      ImageStrings
                                                                          .messageSent),
                                                                ],
                                                              ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ))
              ],
            );
          }),
    );
  }
}
