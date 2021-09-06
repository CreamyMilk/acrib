import 'package:hive/hive.dart';
import 'package:acrib/utils/typeExtensions.dart';

class Constants {
  static const String API_BASE = "http://192.168.0.24:1337";
  static const String UserBoxName = "user";
  static const String IsLoggedInStore = "boomshakalaka";
  static const String TenantIDStore = "tenantsid";
  static const String WalletIDStore = "walletid";
  static const String FullnameStore = "fullname";
  static const String KenyanIDStore = "kenyanidstore";
  static const String PhoneNumberStore = "kenyanidstore";
  static const String ProfilePhotoStore = "profilepicurl";
  static const String WalletBalanceStore = "visualBalance";

  static const String RawFCMTokenStore = "rawfcmtoken";
  static const String NotifcationTopicStore = "notificationTopic";
  static const String AllUserNotifcationTopic = "all";

  static String getWalletID() {
    Box box = Hive.box(UserBoxName);
    String wid = box.get(WalletIDStore, defaultValue: "");
    if (wid == "") {
      print("You Need to login bro");
    }
    return wid;
  }

  static String getPhone() {
    Box box = Hive.box(UserBoxName);
    String phone = box.get(PhoneNumberStore, defaultValue: "");
    if (phone == "") {
      print("You have no stored phoneNumber meed to login bro");
    }
    return phone;
  }

  static String getWalletBalance() {
    Box box = Hive.box(UserBoxName);
    String balance = box.get(WalletBalanceStore, defaultValue: "");
    if (balance == "") {
      print("You don't have any walletBalance");
      return "N/A";
    }
    return balance.addCommas;
  }
}
