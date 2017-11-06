function TouchID() {
}

TouchID.prototype.isAvailable = function (checkBiometricType, successCallback, errorCallback) {
  // Make two-argument method for backwards compatibility. If first argument
  // is not a boolean, assume first two arguments are callback functions.
  if (typeof checkBiometricType !== 'boolean') {
    errorCallback = successCallback;
    successCallback = checkBiometricType;
    checkBiometricType = false;
  }
  cordova.exec(successCallback, errorCallback, "TouchID", "isAvailable", [!!checkBiometricType]);
};

TouchID.prototype.didFingerprintDatabaseChange = function (successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, "TouchID", "didFingerprintDatabaseChange", []);
};

TouchID.prototype.verifyFingerprint = function (message, successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, "TouchID", "verifyFingerprint", [message]);
};

TouchID.prototype.verifyFingerprintWithCustomPasswordFallback = function (message, successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, "TouchID", "verifyFingerprintWithCustomPasswordFallback", [message]);
};

TouchID.prototype.verifyFingerprintWithCustomPasswordFallbackAndEnterPasswordLabel = function (message, enterPasswordLabel, successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, "TouchID", "verifyFingerprintWithCustomPasswordFallbackAndEnterPasswordLabel", [message, enterPasswordLabel]);
};

TouchID.install = function () {
  if (!window.plugins) {
    window.plugins = {};
  }

  window.plugins.touchid = new TouchID();
  return window.plugins.touchid;
};

cordova.addConstructor(TouchID.install);
