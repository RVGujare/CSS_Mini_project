import 'dart:html';

import 'package:css_mini_project/cipher_class.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CipherDetailsScreen extends StatelessWidget {
  final CipherData cipherData;

  CipherDetailsScreen({required this.cipherData});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowAltCircleLeft,
              size: 35,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("home_screen_2.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.1),
              BlendMode.lighten,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white.withOpacity(0.8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cipherData.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t know how to solve? '),
                          TextButton(
                            onPressed: () {
                              window.open(cipherData.url, 'new_tab');
                            },
                            child: const Text(
                              'Click here to learn!',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Color.fromARGB(255, 38, 23, 245),
                                  color: Color.fromARGB(255, 38, 23, 245)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Ciphertext:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black)),
                          SizedBox(
                            width: screenWidth * 0.01,
                          ),
                          Text(cipherData.ciphertext,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black)),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Key:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black)),
                          SizedBox(
                            width: screenWidth * 0.01,
                          ),
                          Text(cipherData.key,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black)),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      const Text(
                          'Decrypt the above cipher and give your answer below',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black)),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      SizedBox(
                          width: screenWidth * 0.3,
                          child: TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(
                                hintStyle: const TextStyle(color: Colors.black),
                                hintText:
                                    'Enter your answer here (case sensitive)',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          )),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 237, 179, 54)),
                        onPressed: () {
                          String decryptedText = cipherData.decryptionFunction(
                              cipherData.ciphertext, cipherData.key);

                          String userEnteredText = _controller.text;

                          if (_controller.text.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Answer cannot be empty!',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            if (decryptedText == userEnteredText) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title:
                                        const Text('Your answer is Correct!!',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            )),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Wrong Answer! Try Again.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 20),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                          _controller.clear();
                        },
                        child: const Text(
                          'Decrypt',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              iconSize: 30,
                              icon: const Icon(Icons.help_outline,
                                  color: Colors.black),
                              onPressed: () {
                                String plaintext =
                                    cipherData.decryptionFunction(
                                        cipherData.ciphertext, cipherData.key);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Are you sure you want to reveal the answer?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Close'),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Answer is:'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: Text(plaintext,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      25)),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text('Close'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: const Text('Show'))
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
