# A Social Media App

Social Media App that allows users to share their photos and videos
with other users. Users can also follow other users and like and comment on
their posts.

- The app is developed using Flutter and GetX state management. The app is
currently in development and is not yet ready for production.

- Right now, the app is only available for Android devices.
 

- We are also open to bug reports. If you would like to report a bug, please feel free to open an [issue](https://github.com/erkripa/Social-Media-App-Flutter-GetX-Advance). We will try to fix the bug as soon as possible.


## Setup

- Create `secrets.dart` file in constants folder.
- Add the following code to the file.

```dart
abstract class AppSecrets {
  static const cloudinaryUploadPreset = 'XXX-XXX-XXX-XXX';
  static const cloudinaryCloudName = 'XXX-XXX-XXX-XXX';
}
```

- Replace XXX-XXX-XXX-XXX with your values in the file.
- Now run the following commands:

```dart
flutter clean
flutter pub get packages
```

## Screenshots

## Download

You can download the app from the [releases page][releases].

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of
conduct, and the process for submitting pull requests to us.

## Authors

- **[Er Kripa Nand][portfolio]** - *Owner & Lead Developer*

## Features

- [x] User Authentication
- [x] Post Feed
- [x] Post Creation
- [x] Post Editing
- [x] Post Deletion
- [x] Post Liking
- [x] Post Commenting
- [ ] Post Sharing
- [x] Post Searching
- [ ] Post Filtering
- [ ] Post Sorting
- [ ] Post Reporting
- [ ] Post Blocking
- [ ] Post Muting
- [x] Profile Creation
- [x] Profile Editing
- [x] Profile Deactivation
- [x] User Following
- [x] User Unfollowing
- [ ] User Blocking
- [ ] User Muting
- [x] User Searching
- [ ] User Filtering
- [x] Trending Posts
- [ ] Hashtag Searching
- [ ] Post Tagging
- [ ] User Mentioning
- [x] Recommendations
- [ ] Search Suggestions
- [x] Settings
- [x] Support
- [x] Dynamic Theme
- [x] P2P Messaging
- [x] Push Notifications

## Upcoming Features

- [ ] Group Messaging
- [ ] Group Creation
- [ ] Post Sharing
- [ ] Post and Chat Settings
- [ ] End-to-End Encryption

## License

This project is licensed under the GPL-3.0 License - see the
[LICENSE.md](LICENSE.md) file for details.
