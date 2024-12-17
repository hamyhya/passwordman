import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';
import 'dart:typed_data';

class EncryptionHelper {
  static final _keyLength = 16; // AES-128 requires a 16-byte key

  // Encrypt the password with the username as the key
  static String encryptPassword(String password, String username) {
    final key = _generateKey(username);
    final iv = encrypt.IV.fromLength(16); // Use random IV (initialization vector)

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(password, iv: iv);

    // Store both encrypted text and IV, as they are both needed for decryption
    final encryptedData = {
      'encrypted': encrypted.base64,
      'iv': base64.encode(iv.bytes),
    };

    // Return the encrypted data as a JSON string for storage
    return jsonEncode(encryptedData);
  }

  // Decrypt the password using the username as the key
  static String decryptPassword(String encryptedData, String username) {
    final key = _generateKey(username);

    // Decode the encrypted data from JSON
    final Map<String, dynamic> data = jsonDecode(encryptedData);

    final iv = encrypt.IV.fromBase64(data['iv']);
    final encryptedBytes = base64Decode(data['encrypted']);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decryptBytes(
      encrypt.Encrypted(encryptedBytes),
      iv: iv,
    );

    // Convert decrypted bytes to string and return
    return utf8.decode(decrypted);
  }

  // Generate a 16-byte key from the username (ensure it's exactly 16 bytes)
  static encrypt.Key _generateKey(String username) {
    final keyBytes = utf8.encode(username.padRight(_keyLength, '0')); // Pad the username to 16 bytes if necessary
    return encrypt.Key(Uint8List.fromList(keyBytes.sublist(0, _keyLength))); // Use only the first 16 bytes
  }
}
