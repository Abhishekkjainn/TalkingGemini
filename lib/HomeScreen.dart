import 'package:abhi/controller/ChatController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    String Time = '${now.hour}:${now.minute}';
    String Date = '${now.day}/${now.month}';
    ChatController controller = Get.put(ChatController());
    TextEditingController userinp = TextEditingController();
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 16, 16, 16),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder<ChatController>(
              builder: (controller) {
                return (controller.Chats.length == 0)
                    ? Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/images/powerai.json',
                                    width: 200, height: 200),
                                Text(
                                  'Power of Gemini',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : chatInterface(controller);
              },
            ),
            chatInput(userinp, controller, Time, Date)
          ],
        ),
      ),
    );
  }

  Container chatInput(TextEditingController userinp, ChatController controller,
      String Time, String Date) {
    return Container(
        alignment: Alignment.center,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            controller: userinp,
            cursorColor: Colors.blue,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Color.fromARGB(255, 66, 65, 65)),
                hintText: 'Todays News.',
                prefixIcon: IconButton(
                    onPressed: () {
                      // controller.addChat(userinp.text, Time, Date, false, '');
                      // userinp.text = '';
                    },
                    icon: Icon(
                      CupertinoIcons.camera_circle_fill,
                      size: 40,
                      color: Colors.grey,
                    )),
                suffixIcon: IconButton(
                    onPressed: () {
                      controller.addChat(userinp.text, Time, Date, true, '');
                      controller.airesponse(userinp.text);
                      userinp.text = '';
                      // print(controller.Chats[0].Userinput);
                    },
                    icon: Icon(
                      CupertinoIcons.search_circle_fill,
                      size: 40,
                      color: Colors.blue,
                    )),
                focusColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 175, 175, 175),
                      width: 2,
                    )),
                enabled: true,
                filled: true,
                fillColor: Color.fromARGB(255, 19, 19, 19),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 74, 74, 74),
                      width: 2,
                    )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 4,
                    ))),
          ),
        ));
  }

  GetBuilder chatInterface(ChatController controller) {
    return GetBuilder<ChatController>(
      builder: (controller) {
        return Expanded(
          child: ListView.builder(
            reverse: true, // Scroll to bottom by default
            itemCount: controller.Chats.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 5, top: 10),
                child: Row(
                  mainAxisAlignment: (controller.Chats[index].isUser)
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (controller.Chats[index].isUser)
                        ? IntrinsicHeight(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: IntrinsicWidth(
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 270),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          Color.fromARGB(255, 41, 41, 41),
                                          Color.fromARGB(255, 29, 29, 29)
                                        ],
                                      )
                                      // color: const Color.fromARGB(255, 29, 29, 29),
                                      ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      top: 8,
                                      bottom: 10,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.Chats[index].Userinput,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          controller.Chats[index].Time,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Lottie.asset('assets/images/gemini.json',
                                width: 25, height: 25),
                          ),
                    (controller.Chats[index].isUser)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Icon(
                              CupertinoIcons.person_alt_circle_fill,
                              color: Colors.white,
                              size: 25,
                            ),
                          )
                        : IntrinsicHeight(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: IntrinsicWidth(
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 270),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          Colors.blue.withOpacity(0.2),
                                          Colors.blue.withOpacity(0.15),
                                          Colors.blue.withOpacity(0.1),
                                          Colors.blue.withOpacity(0.05)
                                        ],
                                      )
                                      // color: const Color.fromARGB(255, 29, 29, 29),
                                      ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      top: 8,
                                      bottom: 10,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.Chats[index].Userinput,
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 189, 207, 255),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          controller.Chats[index].Time,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
