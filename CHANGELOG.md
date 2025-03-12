## New Interfaces
New view adaptor interfaces for `GroupChannelType.ListItem` have been added.
- `public func quotedFileMessageView<Content: View>(@ViewBuilder content:)`
  - An interface that customizes a quoted file message view.  
- `public func quotedMultipleFilesMessageView<Content: View>(@ViewBuilder content:)`
  - An interface that customizes a quoted multiple files message view.
