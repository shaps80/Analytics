# Analytics

A package that provides a type-safe Analytics API that's backend agnostic 

## Make an `AnalyticsEvent`

Such as a view or interaction:

```swift
public extension Analytics {
    struct View: AnalyticsEvent {
        public var name: String { "view" }
    }
}

public extension AnalyticsEvent where Self == Analytics.View {
    static var view: Self { .init() }
}
```

## Track an event

From using the `Analytics.View` above you can simply do the following to log the event:

```swift
struct ContactListView: View {
    @Environment(\.analytics) private var log
    var body: some View {
        List { /* content hidden */ }
            .onAppear {
                log(.view)
            }
    }
}
```

## Define Parameters

Parameters are defined very similarly to how you'd define a custom `EnvironmentKey` in SwiftUI

```swift
private struct SourceAnalyticsKey: AnalyticsKey {
    typealias Value = String
    static var key: String { "source" }
}

extension AnalyticsValues {
    // note: values must be `Optional`
    var source: String? {
        get { self[SourceAnalyticsKey.self] }
        set { self[SourceAnalyticsKey.self] = newValue }
    }
}
```

Once defined, injecting the parameter into a `View` is all that's needed for it to be automatically added to all `AnalyticsEvent`s events within that hierarchy.

```swift
struct RootView: View {
    var body: some View {
        TabView { /* content hidden */ }
            .analytics(\.source, "app-tabs")
    }
}
```

**Example**

```swift
Button("Submit") {
    log(.interaction)
}

/*
Prints:

interaction
- source: app-tabs
*/
```

## Append or replace params without `Environment` propagation
```swift 
var values = AnalyticsValues()
values[keyPath: \.source] = .contactList

// You can append values to specific logs, while retaining any inherited values
// note: any existing values with matching keys will have their values overwritten
log(.view, appending: values)

// Or you can replace the inherited values entirely for a specific log
log(.view, replacing: values)
```
