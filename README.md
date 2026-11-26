# mapagu_mobprog

Laboratory Activity 1A: File Structuring | Design Pattern
Name: Joshua Mapagu  |  Section: INF243

A Facebook-like newsfeed built in Flutter. The goal is file structuring,
not the feed itself.

## Project structure

```
mapagu_mobprog/
|-- assets/
|   |-- fonts/
|   |-- icons/
|   |-- images/        (post_image.jpg, avatar_me.png, avatar_classmate.png)
|-- lib/
|   |-- screens/
|   |   |-- home_screen.dart       (app bar + bottom navigation)
|   |   |-- newsfeed_screen.dart   (Post model + list of posts)
|   |-- widgets/
|   |   |-- custom_text.dart       (reusable text, DRY)
|   |   |-- newsfeed_card.dart     (one post card)
|   |-- constants.dart             (colors)
|   |-- main.dart                  (ScreenUtilInit 360x690, routes /home, /newsfeed)
|-- pubspec.yaml                   (flutter_screenutil ^5.9.3, provider ^6.1.5)
|-- README.md
```

## Run it

```
flutter pub get
flutter run
```

## Enhancements

1. **Image area as a widget** - `_PostImage` uses `Image.asset`.
2. **Profile avatar** - `_Avatar` uses `CircleAvatar` with an `AssetImage`.
3. **Widget-based Like / Comment / Share** - `_ActionButton` (InkWell + Icon + CustomText).
   Like toggles blue and the like count goes up/down.

## Lab Activity 1: discussion

**How do I integrate the Image to newsfeed_card.dart and make it dynamic
whether it has an image or not?**

1. The image is part of the data, not the card design. In
   `newsfeed_screen.dart` the `Post` model has an optional field
   `final String? imageAsset;`. The `?` means it can be `null`.
   Post 1 (mine) sets `imageAsset: null`, and Post 2 sets
   `imageAsset: 'assets/images/post_image.jpg'`.
2. `NewsFeedScreen` passes `imageAsset` to `NewsFeedCard`, which also
   declares it as `String?`, so the card accepts both cases.
3. Inside the card's `Column`, the image is added with a collection `if`:

   ```dart
   if (imageAsset != null) ...[
     _PostImage(assetPath: imageAsset!),
     SizedBox(height: 10.h),
   ],
   ```

   When `imageAsset` is `null`, nothing is added to the list. The card
   shrinks naturally with no empty gap. When it has a path, the
   `_PostImage` widget is built.
4. `_PostImage` wraps `Image.asset` in a `ClipRRect` (rounded corners) with
   `width: double.infinity`, `height: 200.h`, and `fit: BoxFit.cover`.
   `errorBuilder` shows a grey "Post image" box if the file is missing,
   so the app never crashes.
5. The image file is registered in `pubspec.yaml` under `assets:`
   (`assets/images/`), so Flutter can find it.

Because of this, one `NewsFeedCard` widget is reused for every post, with
or without an image. That is the point of the file structuring: data
(`Post`), screen (`NewsFeedScreen`), and widget (`NewsFeedCard`) each live
in their own file.
