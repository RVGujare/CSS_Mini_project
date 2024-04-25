String decryptCaesar(String ciphertext, String key) {
  int shift = int.parse(key);

  String plaintext = '';
  for (int i = 0; i < ciphertext.length; i++) {
    if (ciphertext[i].toUpperCase().codeUnitAt(0) >= 65 &&
        ciphertext[i].toUpperCase().codeUnitAt(0) <= 90) {
      plaintext += String.fromCharCode(
          ((ciphertext[i].toUpperCase().codeUnitAt(0) - 65 - shift) % 26 + 26) %
                  26 +
              65);
    } else {
      plaintext += ciphertext[i];
    }
  }
  return plaintext;
}

String decryptPlayfair(String ciphertext, String key) {
  // Step 1: Generate the Key Square
  List<List<String>> keySquare = generateKeySquare(key);

  // Step 2: Prepare the Ciphertext
  ciphertext = ciphertext.replaceAll(' ', '').toUpperCase();
  if (ciphertext.length % 2 != 0) {
    ciphertext += 'X';
  }

  // Step 3: Break the Ciphertext into Digraphs
  List<String> digraphs = [];
  for (int i = 0; i < ciphertext.length; i += 2) {
    digraphs.add(ciphertext.substring(i, i + 2));
  }

  // Step 4: Decrypt each Digraph
  String plaintext = '';
  for (String digraph in digraphs) {
    int row1 = 0, col1 = 0, row2 = 0, col2 = 0;
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        if (keySquare[i][j] == digraph[0]) {
          row1 = i;
          col1 = j;
        }
        if (keySquare[i][j] == digraph[1]) {
          row2 = i;
          col2 = j;
        }
      }
    }
    if (row1 == row2) {
      plaintext += keySquare[row1][(col1 - 1 + 5) % 5];
      plaintext += keySquare[row2][(col2 - 1 + 5) % 5];
    } else if (col1 == col2) {
      plaintext += keySquare[(row1 - 1 + 5) % 5][col1];
      plaintext += keySquare[(row2 - 1 + 5) % 5][col2];
    } else {
      plaintext += keySquare[row1][col2];
      plaintext += keySquare[row2][col1];
    }
  }

  return plaintext;
}

List<List<String>> generateKeySquare(String key) {
  List<String> letters = 'ABCDEFGHIKLMNOPQRSTUVWXYZ'.split('');
  List<List<String>> keySquare =
      List.generate(5, (_) => List<String>.filled(5, ''));

  int keyIndex = 0;
  int letterIndex = 0;

  // Fill the key square with the keyword
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      if (keyIndex < key.length) {
        keySquare[i][j] = key[keyIndex++];
      } else {
        while (
            letters[letterIndex] == 'J' || key.contains(letters[letterIndex])) {
          letterIndex++;
        }
        keySquare[i][j] = letters[letterIndex++];
      }
    }
  }

  return keySquare;
}

String decryptVernam(String ciphertext, String key) {
  while (key.length < ciphertext.length) {
    key += key;
  }

  key = key.substring(0, ciphertext.length);

  ciphertext = ciphertext.toUpperCase();
  key = key.toUpperCase();

  String plaintext = '';
  for (int i = 0; i < ciphertext.length; i++) {
    int ciphertextCharCode = ciphertext.codeUnitAt(i) - 65;
    int keyCharCode = key.codeUnitAt(i) - 65;
    int decryptedCharCode = (ciphertextCharCode - keyCharCode) % 26;
    if (decryptedCharCode < 0) {
      decryptedCharCode += 26;
    }
    plaintext += String.fromCharCode(decryptedCharCode + 65);
  }
  return plaintext;
}

String decryptVigenere(String ciphertext, String keyword) {
  // Define the alphabet
  final String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  // Convert the keyword to uppercase for consistency
  keyword = keyword.toUpperCase();

  // Initialize variables
  String decryptedText = '';
  int keywordIndex = 0;

  // Repeat the keyword to match the length of the ciphertext
  String repeatedKeyword = '';
  for (int i = 0; i < ciphertext.length; i++) {
    repeatedKeyword += keyword[keywordIndex];
    keywordIndex = (keywordIndex + 1) % keyword.length;
  }

  // Iterate over each character in the ciphertext
  for (int i = 0; i < ciphertext.length; i++) {
    String currentChar =
        ciphertext[i].toUpperCase(); // Convert to uppercase for consistency

    // Check if the character is in the alphabet
    if (alphabet.contains(currentChar)) {
      // Calculate the shift amount using the current keyword character
      int shift = alphabet.indexOf(repeatedKeyword[i]);

      // Decrypt the current character using the shift amount
      int decryptedIndex = (alphabet.indexOf(currentChar) - shift) % 26;
      if (decryptedIndex < 0) {
        decryptedIndex += 26; // Handle negative index by wrapping around
      }
      decryptedText += alphabet[decryptedIndex];
    } else {
      // If the character is not in the alphabet (e.g., punctuation), add it unchanged
      decryptedText += currentChar;
      // Move the keyword index back to align with the non-alphabetic character
      keywordIndex = (keywordIndex - 1) % keyword.length;
    }
  }

  // Return the decrypted plaintext
  return decryptedText;
}

String decryptRailFence(String ciphertext, String railsString) {
  int rails;
  try {
    rails = int.parse(railsString);
    if (rails <= 0) {
      throw FormatException('The number of rails must be a positive integer.');
    }
  } catch (e) {
    throw FormatException('Invalid number of rails.');
  }

  List<String> decryptedChars = List.filled(ciphertext.length, '');

  int cycleLength = 2 * (rails - 1);
  int charIndex = 0;

  for (int rail = 0; rail < rails; rail++) {
    int increment = 2 * (rails - rail - 1);
    for (int i = rail; i < ciphertext.length; i += cycleLength) {
      decryptedChars[i] = ciphertext[charIndex++];
      if (rail != 0 && rail != rails - 1 && i + increment < ciphertext.length) {
        decryptedChars[i + increment] = ciphertext[charIndex++];
      }
    }
  }

  String plaintext = decryptedChars.join('');
  return plaintext;
}
