### New Interfaces
- Added `func topView<Content: View> (@ViewBuilder content: @escaping (MessageInputViewContent.TopView.ViewConfig) -> Content) -> Self` in `GroupChannelView`
- Added `QuoteMessageInputView` 

### Improvements
We have fixed warnings caused by the underlying autolayouts. 
