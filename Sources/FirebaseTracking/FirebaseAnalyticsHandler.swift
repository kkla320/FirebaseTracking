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
        var parameters: [String: Tracking.Analytics.MetadataValue] = self ?? [:]
        if let screenName = parameters.removeValue(forKey: "screen-name") {
            parameters[FirebaseAnalytics.AnalyticsParameterScreenName] = screenName
        }
        if let screenClass = parameters.removeValue(forKey: "screen-sender") {
            parameters[FirebaseAnalytics.AnalyticsParameterScreenClass] = screenClass
        }
        
        return parameters.mapValues({ $0.toNSObject() })
    }
}

extension Tracking.Analytics.MetadataValue {
    func toNSObject() -> NSObject {
        switch self {
        case .string(let string):
            return NSString(string: string)
        case .nil:
            return NSNull()
        case .float(let float):
            return NSNumber(value: float)
        case .int(let int):
            return NSNumber(value: int)
        case .bool(let bool):
            return NSNumber(booleanLiteral: bool)
        case .array(let array):
            return NSArray(array: array.map{ $0.toNSObject() })
        case .dictionary(let dictionary):
            return NSDictionary(dictionary: dictionary)
        }
    }
}
