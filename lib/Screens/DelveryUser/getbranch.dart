import 'package:flutter/material.dart';

class GetUserBranch extends ChangeNotifier {

  String branchName;
  String branchId;

  void getBranchValue(String name, String id) {

    branchName = name;
    branchId = id;

    notifyListeners();
  }

}