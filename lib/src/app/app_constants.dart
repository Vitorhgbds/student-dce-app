import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppConstants {
  static const String appName = "Meia Entrada DCE PUCRS";
  static const String appNameDev = "[DEV] Meia Entrada DCE PUCRS";
  static const String endpoint = "https://nyc.cloud.appwrite.io/v1";
  static String get projectId => dotenv.env['PROJECT_ID'] ?? '';
  static String get profileBucketId => dotenv.env['PROFILE_BUCKET_ID'] ?? '';
}
