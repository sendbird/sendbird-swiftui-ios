## New Interfaces 
- Added `GlobalOptions.enableViewAdaptorAutoReset`
  - This option decides  whether to reset customized view adaptors whenever SendbirdSwiftUI View's `onDisappear` is called.
  - Set this flag to `false` before a specific SendbirdSwiftUI View appears, if you want to prevent its customized views from resetting, even after its `onDisappear` is called.

## Improvements
- Fixed customized SendbirdSwiftUI View's customized styles being reset whenever a SendbirdSwiftUI View 's `onDisappear` is called (e.g., when coming back from another `TabView`)
