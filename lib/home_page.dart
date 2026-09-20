import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_assistant/feature_box.dart';
import 'package:voice_assistant/pallete.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final speechtotext=SpeechToText();
  String lastWords='';
  @override
  void initState()
  {
    super.initState();
    initSpeechtotext();
  }

  Future<void>initSpeechtotext() async{
    await speechtotext.initialize();
    setState(() {
      
    });
  }
    Future<void> startListening() async {
    await speechtotext.listen(onResult: onSpeechResult);
    setState(() {});
  }


  Future <void> stopListening() async {
    await speechtotext.stop();
    setState(() {});
  }


  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }
  @override
  void dispose() {
    super.dispose();
    speechtotext.stop();
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Happy",
          style: TextStyle(fontFamily: 'Cera Pro', color: Pallete.blackColor),
        ),
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          //virtual assistant picture
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/avatar.png'),
                    ),
                  ),
                ),
              ],
            ),
            //chat bubble
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(
                horizontal: 40,
              ).copyWith(top: 30),
              decoration: BoxDecoration(
                border: Border.all(color: Pallete.borderColor),
                borderRadius: BorderRadius.circular(
                  20,
                ).copyWith(topLeft: Radius.zero),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Good Morning,what Task can I do for you?',
                  style: TextStyle(
                    fontFamily: 'Cera Pro',
                    color: Pallete.mainFontColor,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10, left: 22),
              child: const Text(
                'Here are a few features',
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.mainFontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //features
            Column(
              children: [
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  text: 'ChatGPT',
                  description:
                      'A smarter way to stay organised and informed with ChatGPT',
                ),
                FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  text: 'Gemini',
                  description:
                      'A smarter way to stay organised and informed with Gemini',
                ),
                FeatureBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  text: 'Smart Voice-Assistant',
                  description:
                      'A smarter way to stay organised and informed with Gemini',
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if(await speechtotext.hasPermission && speechtotext.isNotListening){ await startListening();}
          else if(speechtotext.isListening){await stopListening();}
          else {initSpeechtotext();}
        },
        child: Icon(Icons.mic),
      ),
    );
  }
}
