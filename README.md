# Analytics

Usage:


```swift
let event = Event(.pair)
    .param(\.user, "1234")
    
let context = EventContext(event)
context.name // prints "pair"
context.parameters // prints "{ 'user': '1234' }"
```
