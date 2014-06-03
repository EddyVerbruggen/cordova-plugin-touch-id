function TouchID() {
}

TouchID.prototype.testMethod = function (successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, "TouchID", "testMethod", []);
};

TouchID.install = function () {
  if (!window.plugins) {
    window.plugins = {};
  }

  window.plugins.touchid = new TouchID();
  return window.plugins.touchid;
};

cordova.addConstructor(TouchID.install);