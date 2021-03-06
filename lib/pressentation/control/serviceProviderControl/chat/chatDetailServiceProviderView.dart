import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/auth/serviceProviderModel.dart';
import 'package:yeeo/pressentation/auth/userModel.dart';
import 'package:yeeo/pressentation/control/chat/chatDetailViewModel.dart';
import 'package:yeeo/pressentation/control/chat/chatModel.dart';
import 'package:yeeo/pressentation/control/serviceProviderControl/chat/serviceProviderChatView.dart';
import 'package:yeeo/pressentation/control/serviceProviderControl/controlViewModelService.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';

class ChatDetailServiceProviderView extends StatelessWidget {
  const ChatDetailServiceProviderView({
    Key? key,
    required this.chatModel,
  }) : super(key: key);

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return GetX<ChatDetailViewModel>(
        init: ChatDetailViewModel(chatModel: chatModel),
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              controller.focusNode.unfocus();
              controller.update();
            },
            child: Scaffold(
              backgroundColor: ColorManager.primary,
              body: Column(
                children: [
                  SizedBox(
                    height: 46.h,
                  ),
                  Container(
                    height: 35.h,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        Container(
                          width: 113.w,
                          child: FlexText(
                            title: chatModel.userName,
                            style: getRegularSalsaStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s36),
                          ),
                        ),
                        SizedBox(
                          width: 200.w,
                        ),
                        GetBuilder<ControlViewModelService>(
                            init: ControlViewModelService(),
                            builder: (controlController) {
                              return GestureDetector(
                                onTap: () {
                                  controlController.currentScreen =
                                      ServiceProviderChatView();
                                  controlController.update();
                                },
                                child: Container(
                                  width: 49.w,
                                  child: Image.asset(
                                    ImageStrings.back,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: List.generate(
                          controller.messageModel.length,
                          (index) => Container(
                                height: 88.h,
                                alignment:
                                    controller.messageModel[index].sender ==
                                            chatModel.serviceProviderId
                                        ? Alignment.bottomRight
                                        : Alignment.bottomLeft,
                                child: Column(
                                  crossAxisAlignment:
                                      controller.messageModel[index].sender ==
                                              chatModel.serviceProviderId
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        margin: controller.messageModel[index]
                                                    .sender ==
                                                chatModel.serviceProviderId
                                            ? EdgeInsets.only(right: 20.w)
                                            : EdgeInsets.only(left: 10.w),
                                        child: FlexText(
                                          title: controller
                                              .messageModel[index].message,
                                          style: getMPlus1cStyle(
                                              color: ColorManager.black,
                                              fontSize: FontSize.s36),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Container(
                                        height: 12.h,
                                        width: 31.w,
                                        margin: EdgeInsets.only(left: 20.w),
                                        child: controller
                                                    .messageModel[index].read ==
                                                "true"
                                            ? Stack(
                                                children: [
                                                  Image.asset(
                                                      ImageStrings.messageSent),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: 9.w),
                                                      child: Image.asset(
                                                          ImageStrings
                                                              .messageSent)),
                                                ],
                                              )
                                            : Stack(
                                                children: [
                                                  Image.asset(
                                                      ImageStrings.messageSent),
                                                ],
                                              ))
                                  ],
                                ),
                              )),
                    ),
                  )),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
              bottomSheet: Container(
                height: 68.h,
                decoration: BoxDecoration(
                    color: ColorManager.yellow,
                    border: Border.symmetric(
                        horizontal: BorderSide(color: ColorManager.black))),
                child: Row(
                  children: [
                    SizedBox(
                      width: 17.w,
                    ),
                    Container(
                      width: 20.w,
                      height: 35.h,
                      child: Image.asset(
                        ImageStrings.emoji,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: 19.w,
                    ),
                    Container(
                      width: 256.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ColorManager.black),
                          borderRadius: BorderRadius.circular(30.r),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 2))
                          ]),
                      child: TextField(
                        onChanged: (message) {
                          controller.message = message;
                        },
                        focusNode: controller.focusNode,
                        controller: controller.textEditingController,
                        keyboardType: TextInputType.multiline,
                        style: getMeduimStyle(
                            color: ColorManager.black, fontSize: FontSize.s18),
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              controller.message == null
                                  ? Get.snackbar("empty", "type a message")
                                  : controller.sendMessage(chatModel.chatId,
                                      chatModel.serviceProviderId);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 6.h),
                              width: 10.07.w,
                              child: Image.asset(
                                ImageStrings.messageSend,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 17.h, horizontal: 5.w),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Container(
                      width: 18.w,
                      height: 35.h,
                      child: Image.asset(
                        ImageStrings.on,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Container(
                      width: 26.w,
                      height: 35.h,
                      child: Image.asset(
                        ImageStrings.camera,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    Container(
                      width: 11.w,
                      height: 35.h,
                      child: Image.asset(
                        ImageStrings.messageType,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
