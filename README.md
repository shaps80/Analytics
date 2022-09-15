# Analytics

A package that provides a type-safe Analytics API that's backend agnostic 

## Track a view

Views are defined very similarly to how you'd define a custom `Notification.Name`

```swift
extension Analytics.View {
    static var taskList = Self(rawValue: "task-list") 
}

struct TaskListView: View {
    @Environment(\.analytics) private var log
    var body: some View {
        List { /* content hidden */ }
            .onAppear {
                log(view: .taskList)
            }
    }
}
```

## Track an interaction

Interactions are defined very similarly to how you'd define a custom `Notification.Name`

```swift
extension Analytics.Interaction {
    static var submit = Self(rawValue: "submit")
}

struct SubmitButton: View {
    @Environment(\.analytics) private var log
    var body: some View {
        Button("Submit") {
            log(interaction: .submit)
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

Once defined, injecting the parameter into a `View` is all that's needed for it to be automatically added to all `view` and `interaction` events within that hierarchy.

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
    log(interaction: .submit)
}

/*
Prints:

interaction
- action: submit
- source: task-list
*/
```
