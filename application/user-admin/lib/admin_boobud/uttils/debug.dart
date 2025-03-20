class Debug {
  static const debug = true;

  static printLog(String str) {
    if (debug) print(str.toString());
  }
}