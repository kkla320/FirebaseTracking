import Tracking
import FirebaseAnalytics

public class FirebaseAnalyticsHandler: AnalyticsHandler {
    public func logEvent(_ name: String, parameter: Tracking.Analytics.Metadata?) {
        FirebaseAnalytics.Analytics.logEvent(name, parameters: parameter)
    }
}
