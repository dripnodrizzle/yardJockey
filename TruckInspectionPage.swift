//
//  preTrip.swift
//  Jockey
//
//  Created by Dripno Drizzle on 2/18/23.
//

#if canImport(UIKit)
import UIKit
#endif
import Foundation
import JavaScriptCore
import SwiftUI

struct PreTrip: View {
    var body: some View {
        let context = JSContext()!
        if let dateJs = Bundle.main.path(forResource: "date", ofType: "js"), let dateJsContent = try? String(contentsOfFile: dateJs) {
            context.evaluateScript(dateJsContent)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: context.objectForKeyedSubscript("getCurrentDate").call(withArguments: []).toDate())
        
        class TruckInspectionPage: UIView {
            var inspectionData: [String: Any] = [
                "truck_number": "",
                "engine_hours": ["start": "", "end": ""],
                "mileage": ["start": "", "end": ""],
                "engine_start_ok": false,
                "engine_start_repair": false,
                "engine_coolant_ok": false,
                "engine_coolant_repair": false,
                "engine_oil_ok": false,
                "engine_oil_repair": false,
                "engine_belts_ok": false,
                "engine_belts_repair": false,
                "engine_hoses_ok": false,
                "engine_hoses_repair": false,
                "transmission_ok": false,
                "transmission_repair": false,
                "brakes_ok": false,
                "brakes_repair": false,
                "steering_ok": false,
                "steering_repair": false,
                "suspension_ok": false,
                "suspension_repair": false,
                "tires_ok": false,
                "tires_repair": false
            ]
            
            let truckNumLabel = UILabel()
            let truckNumEntry = UITextField()
            let dateLabel = UILabel()
            let mileageLabel = UILabel()
            let mileageStartLabel = UILabel()
            let mileageStartEntry = UITextField()
            let mileageEndLabel = UILabel()
            let mileageEndEntry = UITextField()
            let engineHoursLabel = UILabel()
            let engineStartLabel = UILabel()
            let engineStartEntry = UITextField()
            let engineEndLabel = UILabel()
            let engineEndEntry = UITextField()
            let engineLabel = UILabel()
            let engineStartCheckbox = UISwitch()
            let engineRepairCheckbox = UISwitch()
            let engineRepairEntry = UITextField()
            let engineCoolantCheckbox = UISwitch()
            let engineCoolantRepairCheckbox = UISwitch()
            let engineCoolantRepairEntry = UITextField()
            let engineOilCheckbox = UISwitch()
            let engineOilRepairCheckbox = UISwitch()
            let engineOilRepairEntry = UITextField()
            let engineBeltsCheckbox = UISwitch()
            let engineBeltsRepairCheckbox = UISwitch()
            let engineBeltsRepairEntry = UITextField()
            let engineHosesCheckbox = UISwitch()
            let engineHosesRepairCheckbox = UISwitch()
            let engineHosesRepairEntry = UITextField()
            let transmissionLabel = UILabel()
            let transmissionCheckbox = UISwitch()
            let transmissionRepairCheckbox = UISwitch()
            let transmissionRepairEntry = UITextField()
            let brakeLabel = UILabel()
            let brakeCheckbox = UISwitch()
            let brakeRepairCheckbox = UISwitch()
            let brakeRepairEntry = UITextField()
            let steeringLabel = UILabel()
            let steeringCheckbox = UISwitch()
            let steeringRepairCheckbox = UISwitch()
            let steeringRepairEntry = UITextField()
            let suspensionLabel = UILabel()
            let suspensionCheckbox = UISwitch()
            let suspensionRepairCheckbox = UISwitch()
            let suspensionRepairEntry = UITextField()
            let tireLabel = UILabel()
            let tireCheckbox = UISwitch()
            let tireRepairCheckbox = UISwitch()
            let tireRepairEntry = UITextField()
            let saveButton = UIButton(type: .system)
            let resetButton = UIButton(type: .system)
            func resetButton() {
                var setTitle = ("RESET", for: .normal),
                    resetButton;backgroundColor = .red
                resetButton.setTitleColor(.white, for: .normal)
                resetButton.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(resetButton)
                NSLayoutConstraint.activate([
                    resetButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
                    resetButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
                ])}}
            
            
            // other code omitted for brevity
            
            func saveInspection() {
                // Get the values from the text input boxes
                let truckNumEntryText = truckNumEntry.text ?? ""
                let engineStartEntryText = engineStartEntry.text ?? ""
                let engineEndEntryText = engineEndEntry.text ?? ""
                let mileageStartEntryText = mileageStartEntry.text ?? ""
                let mileageEndEntryText = mileageEndEntry.text ?? ""
                
                // Store the values in the inspection_data dictionary
                inspectionData
                inspectionData["truck_number"] = truckNumEntryText
                inspectionData["engine_hours"]["start"] = engineStartEntryText
                inspectionData["engine_hours"]["end"] = engineEndEntryText
                inspectionData["mileage"]["start"] = mileageStartEntryText
                inspectionData["mileage"]["end"] = mileageEndEntryText
                
                // Get the values of the checkboxes and store them in the dictionary
                inspectionData["engine_start_ok"] = engineStartCheckbox.isOn
                inspectionData["engine_start_repair"] = engineRepairCheckbox.isOn
                inspectionData["engine_coolant_ok"] = engineCoolantCheckbox.isOn
                inspectionData["engine_coolant_repair"] = engineCoolantRepairCheckbox.isOn
                inspectionData["engine_oil_ok"] = engineOilCheckbox.isOn
                inspectionData["engine_oil_repair"] = engineOilRepairCheckbox.isOn
                inspectionData["engine_belts_ok"] = engineBeltsCheckbox.isOn
                inspectionData["engine_belts_repair"] = engineBeltsRepairCheckbox.isOn
                inspectionData["engine_hoses_ok"] = engineHosesCheckbox.isOn
                inspectionData["engine_hoses_repair"] = engineHosesRepairCheckbox.isOn
                inspectionData["transmission_ok"] = transmissionCheckbox.isOn
                inspectionData["transmission_repair"] = transmissionRepairCheckbox.isOn
                inspectionData["brakes_ok"] = brakeCheckbox.isOn
                inspectionData["brakes_repair"] = brakeRepairCheckbox.isOn
                inspectionData["steering_ok"] = steeringCheckbox.isOn
                inspectionData["steering_repair"] = steeringRepairCheckbox.isOn
                inspectionData["suspension_ok"] = suspensionCheckbox.isOn
                inspectionData["suspension_repair"] = suspensionRepairCheckbox.isOn
                inspectionData["tires_ok"] = tireCheckbox.isOn
                inspectionData["tires_repair"] = tireRepairCheckbox.isOn
                
                // Write the inspection data to a file
                let fileURL = URL(fileURLWithPath: "inspection_data.json")
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: inspectionData, options: .prettyPrinted)
                    try jsonData.write(to: fileURL, options: .atomic)
                } catch {
                    print(error)
                }
            }
        }
    }
