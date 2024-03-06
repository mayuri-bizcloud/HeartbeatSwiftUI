//
//  ContentView.swift
//  HeartbeatSwiftUI Watch App
//
//  Created by Work on 3/5/24.
//

import SwiftUI
import HealthKit
import CoreLocation

struct ContentView: View {
    @State private var heartRate: Double = 0.0
    @State private var location: CLLocationCoordinate2D? = nil
   
    let healthStore = HKHealthStore()
    let locationManager = CLLocationManager()
    let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
    let date = Date()
    
    private func getHeartRate() {
        let predicate = HKQuery.predicateForSamples(withStart: date.addingTimeInterval(-60), end: date, options: .strictEndDate)
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, _ in
            guard let result = result, let quantity = result.averageQuantity() else {
                return
            }
            self.heartRate = quantity.doubleValue(for: HKUnit(from: "count/min"))
            }
        healthStore.execute(query)
    }
   
    init() {
        self.locationManager.startUpdatingLocation()
       
        /*if HKHealthStore.isHealthDataAvailable() {
            let heartRateType = HKQuantityType(.heartRate)
            healthStore.fetch(self.heartRate,
                                quantitySamplePredicate: nil,
                                limit: 1,
                                sortDescriptors: []) { (hearRateSamples, error) in
                    if let heartRateSample = hearRateSamples?.first {
                        self.heartRate = Double(heartRateSample.quantity.doubleValue(for: HKUnit(from: .count())) / 60)
                    }
            }
        }*/
    }
   
    var body: some View {
        VStack {
            if let location = location {
                Text("Heart Rate: \(heartRate.rounded()) bpm")
                Button(action: {
                                self.getHeartRate()
                            }) {
                                Text("Get Heart Rate")
                                    .font(.headline)
                            }
                Text("Location: (\(location.latitude), \(location.longitude))")
            } else {
                Text("No heart rate or location available.")
            }
        }
    }
}

#Preview {
    ContentView()
}
