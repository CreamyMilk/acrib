import 'package:acrib/constants.dart';
import 'package:acrib/widgets/snackBars.dart';
import 'package:hive/hive.dart';

class LoginResponseTenant {
  String? phonenumber;
  String? teneantid;
  String? walletid;
  String? fullname;
  String? idnumber;
  String? photo;
  String? balance;

  LoginResponseTenant({
    this.phonenumber,
    this.teneantid,
    this.walletid,
    this.fullname,
    this.idnumber,
    this.photo,
    this.balance,
  });
  LoginResponseTenant.fromJson(Map<String, dynamic> json) {
    phonenumber = json["phonenumber"]?.toString();
    teneantid = json["teneantid"]?.toString();
    walletid = json["walletid"]?.toString();
    fullname = json["fullname"]?.toString();
    idnumber = json["idnumber"]?.toString();
    photo = json["photo"]?.toString();
    balance = json["balance"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["phonenumber"] = phonenumber;
    data["teneantid"] = teneantid;
    data["walletid"] = walletid;
    data["fullname"] = fullname;
    data["idnumber"] = idnumber;
    data["photo"] = photo;
    data["balance"] = balance;
    return data;
  }
}

class LoginResponse {
  String? message;
  int? status;
  LoginResponseTenant? tenant;

  LoginResponse({
    this.message,
    this.status,
    this.tenant,
  });
  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json["message"]?.toString();
    status = json["status"]?.toInt();
    tenant = (json["tenant"] != null)
        ? LoginResponseTenant.fromJson(json["tenant"])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["message"] = message;
    data["status"] = status;
    if (tenant != null) {
      data["tenant"] = tenant!.toJson();
    }
    return data;
  }

  bool persist() {
    try {
      Box usersBox = Hive.box(Constants.UserBoxName);
      usersBox.put(Constants.PhoneNumberStore, tenant!.phonenumber);
      usersBox.put(Constants.TenantIDStore, tenant!.idnumber);
      usersBox.put(Constants.WalletIDStore, tenant!.walletid);
      usersBox.put(Constants.FullnameStore, tenant!.fullname);
      usersBox.put(Constants.KenyanIDStore, tenant!.idnumber);
      usersBox.put(Constants.ProfilePhotoStore, tenant!.photo);
      usersBox.put(Constants.WalletBalanceStore, tenant!.balance);
      return true;
    } catch (err) {
      showSnack(err);
      return false;
    }
  }
}
