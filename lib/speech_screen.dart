import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:mobile_rota/widgets/speech_model.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;

import 'colors.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechToText = SpeechToText();
  var text = 'Hold the button and start speaking';
  var isListening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff031a28),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: AvatarGlow(
      //   endRadius: 75.0,
      //   animate: isListening,
      //   duration: const Duration(milliseconds: 2000),
      //   glowColor: Colors.white,
      //   repeat: true,
      //   repeatPauseDuration: const Duration(milliseconds: 100),
      //   showTwoGlows: true,
      //   child: GestureDetector(
      //     onTapDown: (details) async {
      //       if (!isListening) {
      //         var available = await speechToText.initialize();
      //         if (available) {
      //           setState(() {
      //             isListening = true;
      //             speechToText.listen(onResult: (result) {
      //               setState(() {
      //                 text = result.recognizedWords;
      //               });
      //             });
      //           });
      //         }
      //       }
      //     },
      //     onTapUp: (datails) {
      //       setState(() {
      //         isListening = false;
      //       });
      //       speechToText.stop();
      //       // sendTextToApi(
      //       //     text); // Call the function to send the text to the API
      //     },
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         IconButton(
      //           onPressed: () async {
      //             await _editTextDialog(context, {'message': text});
      //           },
      //           // onPressed: () async {
      //           //   // Navigate to the EditScreen and wait for the result (edited text)
      //           //   final editedText = await Navigator.push(
      //           //     context,
      //           //     MaterialPageRoute(
      //           //       builder: (context) => EditScreen(initialText: text),
      //           //     ),
      //           //   );
      //           //   // Update the text if the user made changes
      //           //   if (editedText != null) {
      //           //     setState(() {
      //           //       text = editedText;
      //           //     });
      //           //   }
      //           // },
      //           color: Colors.white,
      //           icon: Icon(Icons.edit_outlined),
      //         ),
      //         CircleAvatar(
      //           backgroundColor: Color(0xff031c2b),
      //           radius: 25,
      //           // radius: 35,
      //           // child: Image.asset('assets/images/mic.png'),
      //           child: Icon(
      //             isListening ? Icons.mic : Icons.mic_none,
      //             color: Colors.white,
      //             size: 30,
      //           ),
      //         ),
      //         IconButton(
      //           onPressed: () {
      //             sendTextToApi(text);
      //           },
      //           color: Colors.white,
      //           icon: Icon(
      //             Icons.check,
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        // leading: Image.asset('assets/images/rotapadlogo.png'),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: bgColor,
        elevation: 0.0,
        title: Text(
          'Record',
          style: GoogleFonts.figtree(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            reverse: true,
            physics: const BouncingScrollPhysics(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              margin: const EdgeInsets.only(bottom: 150),
              child: Text(
                text,
                style: GoogleFonts.figtree(
                    fontSize: 24,
                    color: isListening ? Colors.white : Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () async {
                      await _editTextDialog(context, {'message': text});
                    },
                    // onPressed: () async {
                    //   // Navigate to the EditScreen and wait for the result (edited text)
                    //   final editedText = await Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => EditScreen(initialText: text),
                    //     ),
                    //   );
                    //   // Update the text if the user made changes
                    //   if (editedText != null) {
                    //     setState(() {
                    //       text = editedText;
                    //     });
                    //   }
                    // },
                    color: Colors.white,
                    icon: Icon(Icons.edit_outlined),
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xff252B48),
                    radius: 35,
                    // radius: 35,
                    // child: Image.asset('assets/images/mic.png'),
                    child: AvatarGlow(
                      endRadius: 75.0,
                      animate: isListening,
                      duration: const Duration(milliseconds: 2000),
                      glowColor: Colors.white,
                      repeat: true,
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      showTwoGlows: true,
                      child: GestureDetector(
                        onTapDown: (details) async {
                          if (!isListening) {
                            var available = await speechToText.initialize();
                            if (available) {
                              setState(() {
                                isListening = true;
                                speechToText.listen(onResult: (result) {
                                  setState(() {
                                    text = result.recognizedWords;
                                  });
                                });
                              });
                            }
                          }
                        },
                        onTapUp: (datails) {
                          setState(() {
                            isListening = false;
                          });
                          speechToText.stop();
                          // sendTextToApi(
                          //     text); // Call the function to send the text to the API
                        },
                        child: Icon(
                          isListening ? Icons.mic : Icons.mic_none,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendTextToApi(text);
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return AlertDialog(
                              backgroundColor: Color(0xff031a28),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              title: Text(
                                'Saved successfully',
                                style: GoogleFonts.figtree(color: Colors.white),
                              ),
                              // title: const Text('Please Confirm'),
                              content: Text(
                                'Message saved successfully',
                                style: GoogleFonts.figtree(color: Colors.white),
                              ),
                              // const Text('Are you sure you want to save this message?'),
                              actions: [
                                // The "Yes" button
                                TextButton(
                                    onPressed: () {
                                      // Remove the box
                                      // setState(() {
                                      //   _isShown = false;
                                      // });

                                      // Close the dialog
                                      setState(() {
                                        text =
                                            'Hold the button and start speaking';
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Ok',
                                      style: GoogleFonts.figtree(
                                          color: Colors.white),
                                    )),
                                // child: const Text('Yes')),
                                // TextButton(
                                //     onPressed: () {
                                //       // Close the dialog
                                //       Navigator.of(context).pop();
                                //     },
                                //     child: const Text('No'))
                              ],
                            );
                          });
                    },
                    color: Colors.white,
                    icon: Icon(
                      Icons.check,
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  void _saveSpeechText(String text) async {
    final box = await Hive.openBox<SpeechTextModel>('speech_text_box');
    final speechTextModel = SpeechTextModel(text);
    box.put('speech_text_key', speechTextModel);
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  Future<void> sendTextToApi(String text) async {
    try {
      final url = Uri.parse('https://rotapadconnect.herokuapp.com/voice');
      final headers = {
        // 'Authorization': 'Bearer YOUR_AUTH_TOKEN',
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*"
      };

      final data = {
        'message': text,
      };

      encoding:
      Encoding.getByName("utf-8");

      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));
      print(response.statusCode);
      final responseData = json.decode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        // Successful response
        print('Text saved successfully to the API!');
      } else {
        // Handle errors or other status codes as needed
        print(
            'Failed to save text to the API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      print('Error sending request: $e');
    }
  }

  Future<void> _editTextDialog(
      BuildContext context, Map<String, dynamic> textData) async {
    final TextEditingController textMessageController =
        TextEditingController(text: textData['message'] as String);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xff031a28),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            'Edit Text',
            style: GoogleFonts.figtree(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: 600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: textMessageController,
                    style: GoogleFonts.figtree(color: Colors.white),
                    // decoration: InputDecoration(labelText: 'Edit Text'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.figtree(
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  text = textMessageController.text;
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Save',
                style: GoogleFonts.figtree(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
