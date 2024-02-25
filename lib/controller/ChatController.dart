import 'package:abhi/controller/model.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

DateTime now = new DateTime.now();
String Time = '${now.hour}:${now.minute}';
String Date = '${now.day}/${now.month}';

class ChatController extends GetxController {
  List<ChatModel> Chats = <ChatModel>[].obs;

  void addChat(String Userinput, String Time, String Date, bool isUser,
      String Response) {
    Chats.insert(
        0,
        ChatModel(
            Userinput: Userinput,
            Response: Response,
            isUser: isUser,
            Time: Time,
            Date: Date));
    update();
  }

  var apiKey = 'AIzaSyDoNE0wYPQygZLuRnY00wJBfwRqwC1XVu8';
  void airesponse(String Prompt) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final prompt = Prompt;
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    print(response.text);
    String? res = response.text;
    addChat(res!, Time, Date, false, '');
  }
}
