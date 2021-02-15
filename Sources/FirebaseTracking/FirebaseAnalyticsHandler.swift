import Tracking
import FirebaseAnalytics

public class FirebaseAnalyticsHandler: AnalyticsHandler {
    public init() {
        
    }
    
    public func logEvent(_ name: String, parameter: Tracking.Analytics.Metadata?) {
        if name == ScreenEvent.name {
            FirebaseAnalytics.Analytics.logEvent(FirebaseAnalytics.AnalyticsEventScreenView, parameters: parameter.toFirebaseEventMetadata())
        }
        else {
            FirebaseAnalytics.Analytics.logEvent(name, parameters: parameter)
        }
    }
}

extension Optional where Wrapped == Tracking.Analytics.Metadata {
    func toFirebaseEventMetadata() -> [String: Any] {
        var parameters: [String: Any] = self ?? [:]
        if let screenName = parameters.removeValue(forKey: "screen-name") {
            parameters[FirebaseAnalytics.AnalyticsParameterScreenName] = screenName
        }
        if let screenClass = parameters.removeValue(forKey: "screen-sender") {
            parameters[FirebaseAnalytics.AnalyticsParameterScreenClass] = screenClass
        }
        return parameters
    }
}
