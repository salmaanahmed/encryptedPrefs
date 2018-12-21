# EncryptedPrefs

# Description
Default shared prefrences in android comes with limitations.
Developers cant save objects to it, neither are those encrypted.
This is to make the storage much more easy, you can now save the models to local storage by calling a single function.
And guess what, its also encrypted!
Zero boilerplate!

<br>
<img height="400" src="https://raw.githubusercontent.com/salmaanahmed/encryptedPrefs/master/screenshots/demo.gif" />
<br>

# Installation
For installation you may see: https://pub.dartlang.org/packages/encrypted_prefs

# How to use

Add serialization/deserialization technique to your object
```dart
/// Sample class used for storing locally
class User {
  final String username;
  final String password;

  User(this.username, this.password);

  bool operator == (user) => user is User && user.username == username && user.password == password;

  /// Serializing technique
  User.fromJson(Map<String, dynamic> json)
      : username = json['Username'],
        password = json['Password'];

  /// And deserializing
  Map<String, dynamic> toJson() => {
        'Username': username,
        'Password': password,
      };
}
```

Generate a secure key and keep it in the safe place.
```EncryptedPrefs``` also provide you the method for generating a secure random key.
```dart
/// You can generate encryption key using EncryptedPrefs
encryptionKey = await prefs.generateRandomKey();
```

Extend your adapter with FlagChatAdapter and pass context to the adapter
```kotlin
class ChatAdapter(context: Context, private var list: ArrayList<Any>) : FlagChatAdapter(context)
```

# Store and retrieve objets with encryption
Its one liner code
To encrypt and save, you just need to call set method
```dart
/// Save data in local storage with your object against key and encryption key
    await prefs.set("User", user, encryptionKey);
```

To get the decrypted object all you need to do is following
```dart
/// Retrieve your data from local storage with your key, encryption key and the serialization technique you are using
    prefs.get("User", encryptionKey, (json) => User.fromJson(json)).then((value) {
        if (user == value) {
          /// Do whatever you want :)
        }
    });
```

# Yes! Is it async
Yes! ```EncryptedPrefs``` are created by using the best technique and approaches availabe.
This is async and you dont have to worry about anything.

# Contributions
```EncryptedPrefs``` wouldnt be here without help of Stefano Rodriguez. Special thanks to him for the encryption/decryption.

Pull requests are welcome! The best contributions will consist of substitutions or configurations for classes/methods known to block the main thread during a typical app lifecycle.

I would love to know if you are using FlagChatAdapter in your app, send an email to [Salmaan Ahmed](mailto:salmaan.ahmed@hotmail.com)
