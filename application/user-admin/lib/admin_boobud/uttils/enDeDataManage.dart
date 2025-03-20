import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:tuple/tuple.dart';

// Encrypt Text
String encryptAESCryptoJS(String plainText, String passphrase) {
  final salt = genRandomWithNonZero(8);
  var keyndIV = deriveKeyAndIV(passphrase, salt);
  final key = encrypt.Key(keyndIV.item1);
  final iv = encrypt.IV(keyndIV.item2);

  final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  Uint8List encryptedBytesWithSalt = Uint8List.fromList(
      utf8.encode("Salted__") + salt + encrypted.bytes);
  return base64.encode(encryptedBytesWithSalt);
}

// Decrypt Text
String decryptAESCryptoJS(String encrypted, String passphrase) {
  Uint8List encryptedBytesWithSalt = base64.decode(encrypted);
  Uint8List encryptedBytes = encryptedBytesWithSalt.sublist(16);
  final salt = encryptedBytesWithSalt.sublist(8, 16);
  var keyndIV = deriveKeyAndIV(passphrase, salt);
  final key = encrypt.Key(keyndIV.item1);
  final iv = encrypt.IV(keyndIV.item2);

  final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
  final decrypted = encrypter.decryptBytes(encrypt.Encrypted(encryptedBytes), iv: iv);
  return utf8.decode(decrypted);
}

// Encrypt File (Image, Video, etc.)
Future<void> encryptFile(File file, String passphrase, String outputPath) async {
  Uint8List fileBytes = await file.readAsBytes();
  final salt = genRandomWithNonZero(8);
  var keyndIV = deriveKeyAndIV(passphrase, salt);
  final key = encrypt.Key(keyndIV.item1);
  final iv = encrypt.IV(keyndIV.item2);

  final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
  final encrypted = encrypter.encryptBytes(fileBytes, iv: iv);

  Uint8List encryptedFileBytes = Uint8List.fromList(utf8.encode("Salted__") + salt + encrypted.bytes);
  await File(outputPath).writeAsBytes(encryptedFileBytes);
}

// Decrypt File
Future<void> decryptFile(File file, String passphrase, String outputPath) async {
  Uint8List fileBytes = await file.readAsBytes();
  Uint8List encryptedBytes = fileBytes.sublist(16);
  final salt = fileBytes.sublist(8, 16);
  var keyndIV = deriveKeyAndIV(passphrase, salt);
  final key = encrypt.Key(keyndIV.item1);
  final iv = encrypt.IV(keyndIV.item2);

  final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
  final decrypted = encrypter.decryptBytes(encrypt.Encrypted(encryptedBytes), iv: iv);

  await File(outputPath).writeAsBytes(decrypted);
}

// Helper Methods
Tuple2<Uint8List, Uint8List> deriveKeyAndIV(String passphrase, Uint8List salt) {
  var password = Uint8List.fromList(utf8.encode(passphrase));
  Uint8List concatenatedHashes = Uint8List(0);
  Uint8List currentHash = Uint8List(0);
  Uint8List preHash;

  while (concatenatedHashes.length < 48) {
    preHash = Uint8List.fromList((currentHash + password + salt).toList());
    currentHash = Uint8List.fromList(md5.convert(preHash).bytes);
    concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
  }

  return Tuple2(concatenatedHashes.sublist(0, 32), concatenatedHashes.sublist(32, 48));
}

Uint8List genRandomWithNonZero(int length) {
  final random = Random.secure();
  return Uint8List.fromList(List.generate(length, (_) => random.nextInt(255) + 1));
}


// Function to Download and Decrypt File
Future<void> downloadAndDecryptFile(String fileUrl, String savePath, String passphrase) async {
  try {
    // Download File
    Response response = await Dio().get(fileUrl, options: Options(responseType: ResponseType.bytes));

    // Get Encrypted Data
    Uint8List encryptedData = Uint8List.fromList(response.data);

    // Decrypt Data
    Uint8List decryptedData = decryptData(encryptedData, passphrase);

    // Save Decrypted File
    File file = File(savePath);
    await file.writeAsBytes(decryptedData);

    print("File Decrypted & Saved Successfully: $savePath");
  } catch (e) {
    print("Download or Decryption Failed: $e");
  }
}

// Function to Encrypt and Upload File
Future<void> encryptAndUploadFile(File file, String passphrase, String uploadUrl) async {
  try {
    // Read File as Bytes
    Uint8List fileBytes = await file.readAsBytes();

    // Encrypt File
    Uint8List encryptedData = encryptData(fileBytes, passphrase);

    // Upload Encrypted File
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(encryptedData, filename: "encrypted.enc"),
    });

    Response response = await Dio().post(uploadUrl, data: formData);
    print("Upload Response: ${response.data}");
  } catch (e) {
    print("Encryption or Upload Failed: $e");
  }
}

// Encrypt Data using AES
Uint8List encryptData(Uint8List data, String passphrase) {
  final key = encrypt.Key.fromUtf8(passphrase.padRight(32));
  final iv = encrypt.IV.fromLength(16);

  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
  final encrypted = encrypter.encryptBytes(data, iv: iv);
  return encrypted.bytes;
}

// Decrypt Data using AES
Uint8List decryptData(Uint8List encryptedData, String passphrase) {
  final key = encrypt.Key.fromUtf8(passphrase.padRight(32));
  final iv = encrypt.IV.fromLength(16);

  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
  final decrypted = encrypter.decryptBytes(encrypt.Encrypted(encryptedData), iv: iv);
  return Uint8List.fromList(decrypted);
}
