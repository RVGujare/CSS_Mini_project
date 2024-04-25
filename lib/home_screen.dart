import 'package:css_mini_project/bouncing_text.dart';
import 'package:css_mini_project/cipher_class.dart';
import 'package:css_mini_project/cipher_details_screen.dart';
import 'package:css_mini_project/cipher_solving_functions.dart';
import 'package:css_mini_project/hover_cursor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

final List<CipherData> ciphers = [
  CipherData(
      image: "level_1.jpg",
      name: 'Caesar Cipher',
      ciphertext: 'XJHZWNYD',
      key: '5',
      decryptionFunction: decryptCaesar,
      url: "https://www.javatpoint.com/caesar-cipher-technique"),
  CipherData(
      image: "level_2.png",
      name: 'Playfair Cipher',
      ciphertext: 'WHFEFGCMGDTW',
      key: 'MONEY',
      decryptionFunction: decryptPlayfair,
      url: "https://www.javatpoint.com/playfair-cipher-program-in-java"),
  CipherData(
      image: "level_3.png",
      name: 'Vigenère Cipher',
      ciphertext: 'GCYCZFMLYLEIM',
      key: 'AYUSH',
      decryptionFunction: decryptVigenere,
      url: "https://www.javatpoint.com/vigenere-cipher"),
  CipherData(
      image: "level_4.png",
      name: 'Vernam Cipher',
      ciphertext: 'HWQCYXOAOYD',
      key: 'MONEY',
      decryptionFunction: decryptVernam,
      url: "https://www.geeksforgeeks.org/vernam-cipher-in-cryptography/"),
  CipherData(
      image: "level_5.png",
      name: 'Rail Fence Cipher',
      ciphertext: 'TIETSHSSSCEMSAEIAREG',
      key: '3',
      decryptionFunction: decryptRailFence,
      url:
          "https://www.geeksforgeeks.org/rail-fence-cipher-encryption-decryption/"),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            padding: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 15.0),
            child: Column(
              children: [
                BouncingText(),
                const SizedBox(
                  height: 150,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 50.0,
                      ),
                      itemCount: ciphers.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CipherDetailsScreen(
                                          cipherData: ciphers[index])),
                                );
                              },
                              child: HoverCursor(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  elevation: 4,
                                  child: Container(
                                    // height: 170,
                                    height: 200,
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: Image.asset(
                                              ciphers[index].image,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    bottom:
                                                        Radius.circular(12.0)),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              child: Text(
                                                ciphers[index].name,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
