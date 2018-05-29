//
// Created by Иван Lardis on 29.05.18.
// Copyright (c) 2018 ivanlarin. All rights reserved.
//

import UIKit

class SetingViewControler: UITableViewController {

    @IBOutlet weak var preparationTimeTextView: UILabel!
    @IBOutlet weak var restTimeTextView: UILabel!
    @IBOutlet weak var workTimeTextView: UILabel!
    @IBOutlet weak var cycleTimeTextView: UILabel!
    @IBOutlet weak var countSetTimeTextView: UILabel!
    @IBOutlet weak var restBetweenSetsTimeTextView: UILabel!
    var userDefaults = UserDefaults.init()


    func minus(prefs: Prefs, minValue: Int) -> Int {
        var integer = userDefaults.integer(forKey: prefs.rawValue)
        if (integer > minValue) {
            integer -= 1;
        }

        userDefaults.set(integer, forKey: prefs.rawValue)
        return integer

    }

    func plus(prefs: Prefs) -> Int {
        var integer = userDefaults.integer(forKey: prefs.rawValue)
        integer += 1;
        userDefaults.set(integer, forKey: prefs.rawValue)

        return integer

    }

    func getIntByPrefs(_ prefs: Prefs) -> Int {
        print(prefs.rawValue)
        return userDefaults.integer(forKey: prefs.rawValue)

    }

    func initViews() {
        preparationTimeTextView.text = "\(getIntByPrefs(Prefs.PREPARATION_TIME))"
        restTimeTextView.text = "\(getIntByPrefs(Prefs.REST_TIME))"
        workTimeTextView.text = "\(getIntByPrefs(Prefs.WORK_TIME))"
        cycleTimeTextView.text = "\(getIntByPrefs(Prefs.CYCLE_COUNT))"
        countSetTimeTextView.text = "\(getIntByPrefs(Prefs.SET_COUNT))"
        restBetweenSetsTimeTextView.text = "\(getIntByPrefs(Prefs.REST_BETWEEN_SETS_COUNT))"

    }

    @IBAction func preparationPlusTime(_ sender: Any) {
print("preparationPlusTime")
        plus(prefs: Prefs.PREPARATION_TIME)
        initViews()
    }
    @IBAction func preparationMinusTime(_ sender: Any) {
        print("preparationMinusTime")
        minus(prefs: Prefs.PREPARATION_TIME, minValue: 0)
        initViews()
    }

    @IBAction func workMinusTime(_ sender: Any) {
        print("workMinusTime")
        minus(prefs: Prefs.WORK_TIME, minValue: 0)
        initViews()
    }

    @IBAction func workPlusTime(_ sender: Any) {
        print("workPlusTime")
        plus(prefs: Prefs.WORK_TIME)
        initViews()
    }

    @IBAction func restMinusTime(_ sender: Any) {
        print("restMinusTime")
        minus(prefs: Prefs.REST_TIME, minValue: 0)
        initViews()
    }


    @IBAction func restPlusTimeButton(_ sender: Any) {
        print("restPlusTimeButton")
        plus(prefs: Prefs.REST_TIME)
        initViews()
    }

    @IBAction func cycleMinusTimeButton(_ sender: Any) {
        print("cycleMinusTimeButton")
        minus(prefs: Prefs.CYCLE_COUNT, minValue: 0)
        initViews()
    }

    @IBAction func cyclePlusTimeButton(_ sender: Any) {
        print("cyclePlusTimeButton")
        plus(prefs: Prefs.CYCLE_COUNT)
        initViews()
    }

    @IBAction func countSetPlusTime(_ sender: Any) {
        print("preparationPlusTime")
        plus(prefs: Prefs.SET_COUNT)
        initViews()
    }

    @IBAction func countSetMinusTimeButton(_ sender: Any) {
        print("countSetMinusTimeButton")
        minus(prefs: Prefs.SET_COUNT, minValue: 0)
        initViews()
    }

    @IBAction func restBetweenSetsMinusTime(_ sender: Any) {
        print("restBetweenSetsMinusTime")
        minus(prefs: Prefs.REST_BETWEEN_SETS_COUNT, minValue: 0)
        initViews()
    }

    @IBAction func restBetweenSetsPlusTime(_ sender: Any) {
        print("restBetweenSetsPlusTime")
        plus(prefs: Prefs.REST_BETWEEN_SETS_COUNT)
        initViews()
    }


}
