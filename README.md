# Cordova TouchID Plugin
by [Eddy Verbruggen](http://twitter.com/eddyverbruggen)

## 0. Index

1. [Description](#1-description)
2. [Screenshot](#2-screenshot)
3. [Installation](#3-installation)
	3. [Automatically (CLI / Plugman)](#automatically-cli--plugman)
	3. [Manually](#manually)
4. [Usage](#4-usage)
5. [Quircks](#5-quircks)
6. [License](#6-license)

## 1. Description

Scan the fingerprint of your user with the TouchID sensor (iPhone 5S).

* Compatible with [Cordova Plugman](https://github.com/apache/cordova-plugman).
* Minimum iOS version is 8 (error callbacks will be gracefully invoked on lower versions)
* Requires a fingerprint scanner, so iPhone 5S only

## 2. Screenshot
Distorted a bit because Apple is not a fan of developers posting screenshots of unreleased features.

![ScreenShot](TouchID-demo.png)

## 3. Installation

### Automatically (CLI / Plugman)
Compatible with [Cordova Plugman](https://github.com/apache/cordova-plugman), compatible with [PhoneGap 3.0 CLI](http://docs.phonegap.com/en/3.0.0/guide_cli_index.md.html#The%20Command-line%20Interface_add_features), here's how it works with the CLI (backup your project first!):

```
$ phonegap local plugin add https://github.com/EddyVerbruggen/cordova-touchid-plugin.git
```
or
```
$ cordova plugin add https://github.com/EddyVerbruggen/cordova-touchid-plugin
$ cordova prepare
```

TouchID.js is brought in automatically. There is no need to change or add anything in your html.

### Manually

1\. Add the following xml to your `config.xml` in the root directory of your `www` folder:
```xml
<feature name="TouchID">
  <param name="ios-package" value="TouchID" />
</feature>
```

You'll need to add the `LocalAuthentication.framework` to your project.
Click your project, Build Phases, Link Binary With Libraries, search for and add `LocalAuthentication.framework`.

2\. Grab a copy of TouchID.js, add it to your project and reference it in `index.html`:
```html
<script type="text/javascript" src="js/TouchID.js"></script>
```

3\. Download the source files and copy them to your project.

iOS: Copy the two `.h` and two `.m` files to `platforms/ios/<ProjectName>/Plugins`

## 4. Usage
First you'll want to check whether or not the user has a configured fingerprint scanner.
You can use this to show a 'log in with your fingerprint' button next to a username/password login form.
```js
window.plugins.touchid.isAvailable(
  function(msg) {alert('ok: ' + msg)},    // success handler: TouchID available
  function(msg) {alert('not ok: ' + msg)} // error handler: no TouchID available
);
```

If the onSuccess handler was called, you can scan the fingerprint:
```js
window.plugins.touchid.verifyFingerprint(
  'Scan your fingerprint please', // this will be shown in the native scanner popup
   function(msg) {alert('ok: ' + msg)}, // success handler: fingerprint accepted
   function(msg) {alert('not ok: ' + JSON.stringify(msg))} // error handler with errorcode and localised reason
);
```

You can copy-paste these lines of code for a quick test:
```html
<button onclick="window.plugins.touchid.isAvailable(function(msg) {alert('ok: ' + msg)}, function(msg) {alert('not ok: ' + msg)})">Touch ID available?</button>
<button onclick="window.plugins.touchid.verifyFingerprint('Scan your fingerprint please', function(msg) {alert('ok: ' + msg)}, function(msg) {alert('not ok: ' + JSON.stringify(msg))})">Scan fingerprint</button>
```

## 5. Quircks

### XCode compilation failure
When testing the plugin in XCode, use a real device (not the simulator) to avoid compilation errors.
I think this will be fixed in an upcoming XCode 6 beta version.

### iOS8 beta Phonegap apps broken
Also, iOS8 Phonegap apps are a bit broken at the moment because of an undefined navigator.userAgent.
You will likely run into this issue when testing this plugin as well.
[Here's a fix!](https://gist.github.com/EddyVerbruggen/cd02c73162180793513e#file-ios8-beta-phonegap-fix)

## 6. License

[The MIT License (MIT)](http://www.opensource.org/licenses/mit-license.html)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
