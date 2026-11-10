## Improvements

- Fixed crashes in channel and member lists when the list changed before the list reloaded
- Fixed crashes when no rows are visible during a huge gap, and when reaction or category lists change before a reload
- Fixed a data race on the photo library list
- Fixed a crash when a message template, notification setting, or config cache was reset while cells were reading it
- Fixed template message cells reloading repeatedly after the template cache was reset
- Fixed a crash when an animated GIF had a frame that could not be decoded
- Fixed a crash when a voice message's duration metadata was empty, non-finite, or out of range. Such durations, and negative durations, are now shown as 00:00
- Fixed a crash when `SBUUserMentionConfiguration.suggestionLimit` was negative or `Int.max`. A negative limit is treated as 0 and `Int.max` as `Int.max - 1` where the limit is used. The stored value is unchanged
- Fixed a crash when the alert countdown seconds exceeded `Int.max`. The countdown is capped at `Int.max`
- Fixed a crash when a message template had non-finite or very large margin, padding, spacing, or max child width values, or when `TemplateConfig.defaultChildTemplateWidth` was not finite. The renderer treats non-finite layout values as 0 and clips very large ones. Public model values are unchanged
- Fixed a crash on launch when the cached UIKit version contained a number too large to compare. Such a version is treated as the oldest version, so the image cache is cleared once
- Fixed a potential crash caused by logging the full channel when loading or creating a channel
- Fixed the message thread view layout with Liquid Glass on iOS 26: the gap between the header and the parent message, the parent message being pushed off screen when the keyboard appears, and an empty glass circle on the right side of the header
- Reduced memory use of GIF thumbnails, video thumbnails, and pending multiple files message previews
- Reduced main thread work when sending videos
- Improved performance by skipping log message creation when the log level is disabled
- Removed debug console output from the message menu and photo picker

## Changes

- Updated dependency SDK version to the latest stable release
    - SendbirdChatSDK: 4.39.13
    - SendbirdMessageTemplate: 3.36.4
