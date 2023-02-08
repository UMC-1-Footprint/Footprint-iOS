//
//  SelectGoalWalkTimeView.swift
//  Footprint-iOSTests
//
//  Created by 김영인 on 2023/02/05.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import UIKit

import RxSwift

class SelectGoalWalkTimeView: BaseView {
    
    enum Time: Int {
        case hour
        case minute
    }
    
    // MARK: - Properties
    
    private var hours: [String] = []
    private var minutes: [String] = []
    
    var selectedHour = BehaviorSubject<String>(value: "0시간")
    var selectedMinute = BehaviorSubject<String>(value: "0분")
    
    // MARK: - UI Components
    
    let pickerView = UIPickerView()
    
    // MARK: - Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        setupPickerView()
    }
    
    override func setupDelegate() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    override func setupHierarchy() {
        addSubview(pickerView)
    }
    
    override func setupLayout() {
        pickerView.snp.makeConstraints() {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupPickerView() {
        for hour in Array(0...23) {
            hours.append("\(hour)시간")
        }
        
        for minute in Array(0...5) {
            minutes.append("\(minute * 10)분")
        }
    }
}

extension SelectGoalWalkTimeView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case Time.hour.rawValue:
            return hours.count
        case Time.minute.rawValue:
            return minutes.count
        default:
            return 0
        }
    }
}

extension SelectGoalWalkTimeView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case Time.hour.rawValue:
            return hours[row]
        case Time.minute.rawValue:
            return minutes[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case Time.hour.rawValue:
            selectedHour.onNext(hours[row])
        case Time.minute.rawValue:
            selectedMinute.onNext(minutes[row])
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        
        switch component {
        case Time.hour.rawValue:
            label.text = hours[row]
        case Time.minute.rawValue:
            label.text = minutes[row]
        default:
            break
        }
        
        return label
    }
}
