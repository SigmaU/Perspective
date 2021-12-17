//
//  DemoData.swift
//  Perspective
//
//  Created by Csaba on 26.11.2021.
//

import Foundation

let demoModel: _Model = {
    
    let dateFrom: (Int) -> (String) = { timeStamp in
        let date = Date(timeIntervalSince1970: Double(timeStamp))
        let dateFormatted = dateFormatter().string(from: date)
        return dateFormatted
    }
    
    // MARK: - Health & Fitness
    let runningPerspectiveProperties = _Properties(timestamp: String(Date().timeIntervalSince1970), name: "Running Distance", type: "Time Series", yAxisName: "Distance", xAxisName: "Date", yAxisUnit: "km", xAxisUnit: "", horizontalLine: "0.63", verticalLine: "0.0")
    let runningPerspectiveDataSeries = [_DataSeries(timeStamp: "1630828374", name: dateFrom(1630828374), x: "1630828374", y: "0.28"),
                                        _DataSeries(timeStamp: "1631087574", name: dateFrom(1631087574), x: "1631087574", y: "0.33"),
                                        _DataSeries(timeStamp: "1631260374", name: dateFrom(1631260374), x: "1631260374", y: "0.36"),
                                        _DataSeries(timeStamp: "1631346774", name: dateFrom(1631346774), x: "1631346774", y: "0.35"),
                                        _DataSeries(timeStamp: "1631692374", name: dateFrom(1631692374), x: "1631692374", y: "0.45"),
                                        _DataSeries(timeStamp: "1632383574", name: dateFrom(1632383574), x: "1632383574", y: "0.46"),
                                        _DataSeries(timeStamp: "1632642774", name: dateFrom(1632642774), x: "1632642774", y: "0.45"),
                                        _DataSeries(timeStamp: "1632729174", name: dateFrom(1632729174), x: "1632729174", y: "0.48"),
                                        _DataSeries(timeStamp: "1632901974", name: dateFrom(1632901974), x: "1632901974", y: "0.49"),
                                        _DataSeries(timeStamp: "1633074774", name: dateFrom(1633074774), x: "1633074774", y: "0.63"),
                                        _DataSeries(timeStamp: "1633161174", name: dateFrom(1633161174), x: "1633161174", y: "0.61"),
                                        _DataSeries(timeStamp: "1633247574", name: dateFrom(1633247574), x: "1633247574", y: "0.47"),
                                        _DataSeries(timeStamp: "1633333974", name: dateFrom(1633333974), x: "1633333974", y: "0.44"),
                                        _DataSeries(timeStamp: "1633420374", name: dateFrom(1633420374), x: "1633420374", y: "0.46"),
                                        _DataSeries(timeStamp: "1633506774", name: dateFrom(1633506774), x: "1633506774", y: "0.98"),
                                        _DataSeries(timeStamp: "1633765974", name: dateFrom(1633765974), x: "1633765974", y: "1.02"),
                                        _DataSeries(timeStamp: "1633852374", name: dateFrom(1633852374), x: "1633852374", y: "1.19"),
                                        _DataSeries(timeStamp: "1633938774", name: dateFrom(1633938774), x: "1633938774", y: "1.21"),
                                        _DataSeries(timeStamp: "1634716374", name: dateFrom(1634716374), x: "1634716374", y: "0.65"),
                                        _DataSeries(timeStamp: "1634802774", name: dateFrom(1634802774), x: "1634802774", y: "0.63"),
                                        _DataSeries(timeStamp: "1635234774", name: dateFrom(1635234774), x: "1635234774", y: "0.69"),
                                        _DataSeries(timeStamp: "1635321174", name: dateFrom(1635321174), x: "1635321174", y: "0.72"),
                                        _DataSeries(timeStamp: "1635493974", name: dateFrom(1635493974), x: "1635493974", y: "0.69"),
                                        _DataSeries(timeStamp: "1635666774", name: dateFrom(1635666774), x: "1635666774", y: "0.67"),
                                        _DataSeries(timeStamp: "1635839574", name: dateFrom(1635839574), x: "1635839574", y: "0.71"),
                                        _DataSeries(timeStamp: "1636617174", name: dateFrom(1636617174), x: "1636617174", y: "0.66"),
                                        _DataSeries(timeStamp: "1637049174", name: dateFrom(1637049174), x: "1637049174", y: "0.76"),
                                        _DataSeries(timeStamp: "1637221974", name: dateFrom(1637221974), x: "1637221974", y: "0.66"),
                                        _DataSeries(timeStamp: "1637913174", name: dateFrom(1637913174), x: "1637913174", y: "0.94")
    ]
    let runningPerspective = _Perspective(properties: runningPerspectiveProperties, dataSeries: runningPerspectiveDataSeries)
    
    
    let sleepPerspectiveProperties = _Properties(timestamp: String(Date().timeIntervalSince1970), name: "Sleep Quality", type: "Time Series", yAxisName: "Quality", xAxisName: "Date", yAxisUnit: "%", xAxisUnit: "", horizontalLine: "80.0", verticalLine: "0.0")
    let sleepPerspectiveDataSeries = [_DataSeries(timeStamp: "1630828374", name: dateFrom(1630828374), x: "1630828374", y: "84"),
                                      _DataSeries(timeStamp: "1631087574", name: dateFrom(1631087574), x: "1631087574", y: "78"),
                                      _DataSeries(timeStamp: "1631260374", name: dateFrom(1631260374), x: "1631260374", y: "100"),
                                      _DataSeries(timeStamp: "1631346774", name: dateFrom(1631346774), x: "1631346774", y: "92"),
                                      _DataSeries(timeStamp: "1631692374", name: dateFrom(1631692374), x: "1631692374", y: "89"),
                                      _DataSeries(timeStamp: "1632383574", name: dateFrom(1632383574), x: "1632383574", y: "79"),
                                      _DataSeries(timeStamp: "1632642774", name: dateFrom(1632642774), x: "1632642774", y: "83"),
                                      _DataSeries(timeStamp: "1632729174", name: dateFrom(1632729174), x: "1632729174", y: "84"),
                                      _DataSeries(timeStamp: "1632901974", name: dateFrom(1632901974), x: "1632901974", y: "85"),
                                      _DataSeries(timeStamp: "1633074774", name: dateFrom(1633074774), x: "1633074774", y: "94"),
                                      _DataSeries(timeStamp: "1633161174", name: dateFrom(1633161174), x: "1633161174", y: "100"),
                                      _DataSeries(timeStamp: "1633247574", name: dateFrom(1633247574), x: "1633247574", y: "87"),
                                      _DataSeries(timeStamp: "1633333974", name: dateFrom(1633333974), x: "1633333974", y: "92"),
                                      _DataSeries(timeStamp: "1633420374", name: dateFrom(1633420374), x: "1633420374", y: "92"),
                                      _DataSeries(timeStamp: "1633506774", name: dateFrom(1633506774), x: "1633506774", y: "91"),
                                      _DataSeries(timeStamp: "1633765974", name: dateFrom(1633765974), x: "1633765974", y: "100"),
                                      _DataSeries(timeStamp: "1633852374", name: dateFrom(1633852374), x: "1633852374", y: "100"),
                                      _DataSeries(timeStamp: "1633938774", name: dateFrom(1633938774), x: "1633938774", y: "100"),
                                      _DataSeries(timeStamp: "1634716374", name: dateFrom(1634716374), x: "1634716374", y: "88"),
                                      _DataSeries(timeStamp: "1634802774", name: dateFrom(1634802774), x: "1634802774", y: "93"),
                                      _DataSeries(timeStamp: "1635234774", name: dateFrom(1635234774), x: "1635234774", y: "100"),
                                      _DataSeries(timeStamp: "1635321174", name: dateFrom(1635321174), x: "1635321174", y: "98"),
                                      _DataSeries(timeStamp: "1635493974", name: dateFrom(1635493974), x: "1635493974", y: "100"),
                                      _DataSeries(timeStamp: "1635666774", name: dateFrom(1635666774), x: "1635666774", y: "100"),
                                      _DataSeries(timeStamp: "1635839574", name: dateFrom(1635839574), x: "1635839574", y: "98"),
                                      _DataSeries(timeStamp: "1636617174", name: dateFrom(1636617174), x: "1636617174", y: "100"),
                                      _DataSeries(timeStamp: "1637049174", name: dateFrom(1637049174), x: "1637049174", y: "100"),
                                      _DataSeries(timeStamp: "1637221974", name: dateFrom(1637221974), x: "1637221974", y: "97"),
                                      _DataSeries(timeStamp: "1637913174", name: dateFrom(1637913174), x: "1637913174", y: "99")
    ]
    let sleepPerspective = _Perspective(properties: sleepPerspectiveProperties, dataSeries: sleepPerspectiveDataSeries)
    
    let healthAndFitnessFolder = _Folder(timeStamp: String(Date().timeIntervalSince1970), name: "Health & Fitness", perspectives: [sleepPerspective, runningPerspective])
    
    
    // MARK: - Kitchen & Nutrition
    let cookingTimeProperties = _Properties(timestamp: String(Date().timeIntervalSince1970), name: "Cooking Time", type: "Contingency", yAxisName: "Preference", xAxisName: "Duration", yAxisUnit: "", xAxisUnit: "min", horizontalLine: "5.0", verticalLine: "90.0")
    let cookingTimeDataSeries = [_DataSeries(timeStamp: "1630828374", name: "Cherry Soup", x: "30.0", y: "1.0"),
                                 _DataSeries(timeStamp: "1631087574", name: "Green Smoothie", x: "20.0", y: "10.0"),
                                 _DataSeries(timeStamp: "1631260374", name: "Kohlrabi Soup", x: "40.0", y: "7.0"),
                                 _DataSeries(timeStamp: "1631346774", name: "White Bean Cream Soup", x: "50.0", y: "6.0"),
                                 _DataSeries(timeStamp: "1631692374", name: "Boeuf Salad", x: "47.0", y: "7.0"),
                                 _DataSeries(timeStamp: "1632383574", name: "Brocoli Soup", x: "20.0", y: "7.0"),
                                 _DataSeries(timeStamp: "1632642774", name: "Onion Creme Soup", x: "48.0", y: "8.0"),
                                 _DataSeries(timeStamp: "1632729174", name: "Chicken Guizzard Stew", x: "110.0", y: "9.0"),
                                 _DataSeries(timeStamp: "1632901974", name: "Pizza", x: "140.0", y: "10.0"),
                                 _DataSeries(timeStamp: "1633074774", name: "Lasagna", x: "200.0", y: "10.0"),
                                 _DataSeries(timeStamp: "1633161174", name: "Burrito", x: "155", y: "10.0"),
                                 _DataSeries(timeStamp: "1633247574", name: "Cheesecake", x: "130.0", y: "10.0"),
                                 _DataSeries(timeStamp: "1633333974", name: "Tomato Soup", x: "20.0", y: "2.0"),
                                 _DataSeries(timeStamp: "1633420374", name: "Thai Chicken", x: "190.0", y: "10.0"),
                                 _DataSeries(timeStamp: "1633506774", name: "Thai White Curry", x: "40.0", y: "7.0"),
                                 _DataSeries(timeStamp: "1633765974", name: "Thai Green Curry", x: "180.0", y: "10.0"),
                                 _DataSeries(timeStamp: "1633852374", name: "Sushi", x: "190.0", y: "10.0"),
                                 _DataSeries(timeStamp: "1633938774", name: "Banana Pancakes", x: "30.0", y: "10.0"),
                                 _DataSeries(timeStamp: "1634716374", name: "Teriyaki Chicken", x: "165.0", y: "10.0")
    ]
    let cookingTime = _Perspective(properties: cookingTimeProperties, dataSeries: cookingTimeDataSeries)
    
    
    let plantProteinsProperties = _Properties(timestamp: String(Date().timeIntervalSince1970), name: "Plant Proteins (100g)", type: "Contingency", yAxisName: "Proteins", xAxisName: "Preference", yAxisUnit: "g", xAxisUnit: "", horizontalLine: "9.0", verticalLine: "7.5")
    let plantProteinsDataSeries = [_DataSeries(timeStamp: "1630828374", name: "Potatoes", x: "1.0", y: "2.5"),
                                   _DataSeries(timeStamp: "1631087574", name: "Brown Rice", x: "2.58", y: "10.0"),
                                   _DataSeries(timeStamp: "1631260374", name: "Spinach", x: "2.9", y: "8.0"),
                                   _DataSeries(timeStamp: "1631346774", name: "Quinoa", x: "4.4", y: "7.0"),
                                   _DataSeries(timeStamp: "1631692374", name: "Kidney Beans", x: "4.83", y: "7.0"),
                                   _DataSeries(timeStamp: "1632383574", name: "White Beans", x: "4.86", y: "6.0"),
                                   _DataSeries(timeStamp: "1632642774", name: "Green Peas", x: "5.36", y: "3.0"),
                                   _DataSeries(timeStamp: "1632729174", name: "Macademia Nuts", x: "7.79", y: "8.0"),
                                   _DataSeries(timeStamp: "1632901974", name: "Wheat Bread", x: "8.8", y: "3.0"),
                                   _DataSeries(timeStamp: "1633074774", name: "Lentils", x: "9.02", y: "3.0"),
                                   _DataSeries(timeStamp: "1633161174", name: "Soybeans", x: "13.1", y: "6.0"),
                                   _DataSeries(timeStamp: "1633247574", name: "Walnuts", x: "15.3", y: "10.0"),
                                   _DataSeries(timeStamp: "1633333974", name: "Hazelnuts", x: "15.3", y: "11.0"),
                                   _DataSeries(timeStamp: "1633420374", name: "Cashew Nuts", x: "15.31", y: "8.0"),
                                   _DataSeries(timeStamp: "1633506774", name: "Chia Seeds", x: "15.6", y: "8.0"),
                                   _DataSeries(timeStamp: "1633765974", name: "Oats", x: "16.89", y: "10.0"),
                                   _DataSeries(timeStamp: "1633852374", name: "Tofu", x: "17.19", y: "8.0"),
                                   _DataSeries(timeStamp: "1633938774", name: "Flaxseed", x: "19.5", y: "7.0"),
                                   _DataSeries(timeStamp: "1634716374", name: "Pistachio Nuts", x: "21.35", y: "11.0"),
                                   _DataSeries(timeStamp: "1634802774", name: "Almonds", x: "22.09", y: "11.0"),
                                   _DataSeries(timeStamp: "1635234774", name: "Hemp Seed", x: "23.0", y: "9.0"),
                                   _DataSeries(timeStamp: "1635321174", name: "Peanut Butter", x: "25.09", y: "13"),
                                   _DataSeries(timeStamp: "1635493974", name: "Pumpkin Seeds", x: "32.97", y: "11")
    ]
    let plantProteins = _Perspective(properties: plantProteinsProperties, dataSeries: plantProteinsDataSeries)
    
    let kitchenAndNutritionFolder = _Folder(timeStamp: String(Date().timeIntervalSince1970), name: "Kitchen & Nutrition", perspectives: [plantProteins, cookingTime])
    
    
    // MARK: - Hobbies & Passions
    let musicProperties = _Properties(timestamp: String(Date().timeIntervalSince1970), name: "Music", type: "Habit", yAxisName: "Session", xAxisName: "Date", yAxisUnit: "h", xAxisUnit: "", horizontalLine: "1.0", verticalLine: "0.0")
    let musicDataSeries = [_DataSeries(timeStamp: "1630828374", name: dateFrom(1630828374), x: "1630828374", y: "1.1"),
                           _DataSeries(timeStamp: "1631087574", name: dateFrom(1631087574), x: "1631087574", y: "1.4"),
                           _DataSeries(timeStamp: "1631260374", name: dateFrom(1631260374), x: "1631260374", y: "2.0"),
                           _DataSeries(timeStamp: "1631346774", name: dateFrom(1631346774), x: "1631346774", y: "1.4"),
                           _DataSeries(timeStamp: "1631692374", name: dateFrom(1631692374), x: "1631692374", y: "1.4"),
                           _DataSeries(timeStamp: "1632383574", name: dateFrom(1632383574), x: "1632383574", y: "1.5"),
                           _DataSeries(timeStamp: "1632642774", name: dateFrom(1632642774), x: "1632642774", y: "1.0"),
                           _DataSeries(timeStamp: "1632729174", name: dateFrom(1632729174), x: "1632729174", y: "1.0"),
                           _DataSeries(timeStamp: "1632901974", name: dateFrom(1632901974), x: "1632901974", y: "1.7"),
                           _DataSeries(timeStamp: "1633074774", name: dateFrom(1633074774), x: "1633074774", y: "1.1"),
                           _DataSeries(timeStamp: "1633161174", name: dateFrom(1633161174), x: "1633161174", y: "1.2"),
                           _DataSeries(timeStamp: "1633247574", name: dateFrom(1633247574), x: "1633247574", y: "1.1"),
                           _DataSeries(timeStamp: "1633333974", name: dateFrom(1633333974), x: "1633333974", y: "1.0"),
                           _DataSeries(timeStamp: "1633420374", name: dateFrom(1633420374), x: "1633420374", y: "1.0"),
                           _DataSeries(timeStamp: "1633506774", name: dateFrom(1633506774), x: "1633506774", y: "1.4"),
                           _DataSeries(timeStamp: "1633765974", name: dateFrom(1633765974), x: "1633765974", y: "2.0"),
                           _DataSeries(timeStamp: "1633852374", name: dateFrom(1633852374), x: "1633852374", y: "2.0"),
                           _DataSeries(timeStamp: "1633938774", name: dateFrom(1633938774), x: "1633938774", y: "1.9"),
                           _DataSeries(timeStamp: "1634716374", name: dateFrom(1634716374), x: "1634716374", y: "1.8")
    ]
    let music = _Perspective(properties: musicProperties, dataSeries: musicDataSeries)
    
    
    let readingProperties = _Properties(timestamp: String(Date().timeIntervalSince1970), name: "Reading", type: "Time Series", yAxisName: "Reading", xAxisName: "Date", yAxisUnit: "pages", xAxisUnit: "", horizontalLine: "15.0", verticalLine: "0.0")
    let readingDataSeries = [_DataSeries(timeStamp: "1630828374", name: dateFrom(1630828374), x: "1630828374", y: "10.0"),
                             _DataSeries(timeStamp: "1631087574", name: dateFrom(1631087574), x: "1631087574", y: "13.0"),
                             _DataSeries(timeStamp: "1631260374", name: dateFrom(1631260374), x: "1631260374", y: "12.0"),
                             _DataSeries(timeStamp: "1631346774", name: dateFrom(1631346774), x: "1631346774", y: "20.0"),
                             _DataSeries(timeStamp: "1631692374", name: dateFrom(1631692374), x: "1631692374", y: "10.0"),
                             _DataSeries(timeStamp: "1632383574", name: dateFrom(1632383574), x: "1632383574", y: "11.0"),
                             _DataSeries(timeStamp: "1632642774", name: dateFrom(1632642774), x: "1632642774", y: "20.0"),
                             _DataSeries(timeStamp: "1632729174", name: dateFrom(1632729174), x: "1632729174", y: "23.0"),
                             _DataSeries(timeStamp: "1632901974", name: dateFrom(1632901974), x: "1632901974", y: "12.0"),
                             _DataSeries(timeStamp: "1633074774", name: dateFrom(1633074774), x: "1633074774", y: "11.0"),
                             _DataSeries(timeStamp: "1633161174", name: dateFrom(1633161174), x: "1633161174", y: "10.0"),
                             _DataSeries(timeStamp: "1633247574", name: dateFrom(1633247574), x: "1633247574", y: "10.0"),
                             _DataSeries(timeStamp: "1633333974", name: dateFrom(1633333974), x: "1633333974", y: "29.0"),
                             _DataSeries(timeStamp: "1633420374", name: dateFrom(1633420374), x: "1633420374", y: "22.0"),
                             _DataSeries(timeStamp: "1633506774", name: dateFrom(1633506774), x: "1633506774", y: "10.0"),
                             _DataSeries(timeStamp: "1633765974", name: dateFrom(1633765974), x: "1633765974", y: "11.0"),
                             _DataSeries(timeStamp: "1633852374", name: dateFrom(1633852374), x: "1633852374", y: "13.0"),
                             _DataSeries(timeStamp: "1633938774", name: dateFrom(1633938774), x: "1633938774", y: "18.0"),
                             _DataSeries(timeStamp: "1634716374", name: dateFrom(1634716374), x: "1634716374", y: "15.0")
    ]
    let reading = _Perspective(properties: readingProperties, dataSeries: readingDataSeries)
    
    let hobbiesAndPassions = _Folder(timeStamp: String(Date().timeIntervalSince1970), name: "Hobbies & Passions", perspectives: [reading, music])
    
    
    // MARK: - Work & Side Projects
    let swiftProperties = _Properties(timestamp: String(Date().timeIntervalSince1970), name: "Swift", type: "Time Series", yAxisName: "Perspective", xAxisName: "Date", yAxisUnit: "", xAxisUnit: "", horizontalLine: "8.0", verticalLine: "0.0")
    let swiftDataSeries = [_DataSeries(timeStamp: "1572998400", name: dateFrom(1572998400), x: "1572998400", y: "0,2"),
                           _DataSeries(timeStamp: "1575590400", name: dateFrom(1575590400), x: "1575590400", y: "1.0"),
                           _DataSeries(timeStamp: "1578268800", name: dateFrom(1578268800), x: "1578268800", y: "1.0"),
                           _DataSeries(timeStamp: "1580947200", name: dateFrom(1580947200), x: "1580947200", y: "1.25"),
                           _DataSeries(timeStamp: "1583452800", name: dateFrom(1583452800), x: "1583452800", y: "2.5"),
                           _DataSeries(timeStamp: "1586131200", name: dateFrom(1586131200), x: "1586131200", y: "4.0"),
                           _DataSeries(timeStamp: "1588723200", name: dateFrom(1588723200), x: "1588723200", y: "7.0"),
                           _DataSeries(timeStamp: "1591401600", name: dateFrom(1591401600), x: "1591401600", y: "8.0"),
                           _DataSeries(timeStamp: "1593993600", name: dateFrom(1593993600), x: "1593993600", y: "8.5"),
                           _DataSeries(timeStamp: "1596672000", name: dateFrom(1596672000), x: "1596672000", y: "7.0"),
                           _DataSeries(timeStamp: "1599350400", name: dateFrom(1599350400), x: "1599350400", y: "4.0"),
                           _DataSeries(timeStamp: "1601942400", name: dateFrom(1601942400), x: "1601942400", y: "4.5"),
                           _DataSeries(timeStamp: "1604620800", name: dateFrom(1604620800), x: "1604620800", y: "5.0"),
                           _DataSeries(timeStamp: "1607212800", name: dateFrom(1607212800), x: "1607212800", y: "4.0"),
                           _DataSeries(timeStamp: "1609891200", name: dateFrom(1609891200), x: "1609891200", y: "4.5"),
                           _DataSeries(timeStamp: "1612569600", name: dateFrom(1612569600), x: "1612569600", y: "6.0"),
                           _DataSeries(timeStamp: "1614988800", name: dateFrom(1614988800), x: "1614988800", y: "7.0"),
                           _DataSeries(timeStamp: "1617667200", name: dateFrom(1617667200), x: "1617667200", y: "9.0"),
                           _DataSeries(timeStamp: "1620259200", name: dateFrom(1620259200), x: "1620259200", y: "10.0"),
                           _DataSeries(timeStamp: "1622937600", name: dateFrom(1622937600), x: "1622937600", y: "12.0"),
                           _DataSeries(timeStamp: "1625529600", name: dateFrom(1625529600), x: "1625529600", y: "10.0"),
                           _DataSeries(timeStamp: "1628208000", name: dateFrom(1628208000), x: "1628208000", y: "9.0"),
                           _DataSeries(timeStamp: "1630886400", name: dateFrom(1630886400), x: "1630886400", y: "8.0"),
                           _DataSeries(timeStamp: "1633478400", name: dateFrom(1633478400), x: "1633478400", y: "9.0"),
                           _DataSeries(timeStamp: "1636156800", name: dateFrom(1636156800), x: "1636156800", y: "10.0")
    ]
    let swift = _Perspective(properties: swiftProperties, dataSeries: swiftDataSeries)
    
    let workAndSideProjects = _Folder(timeStamp: String(Date().timeIntervalSince1970), name: "Work & Side Projects", perspectives: [swift])
    
    //
    let demoModel = _Model.init(folders: [healthAndFitnessFolder, kitchenAndNutritionFolder, hobbiesAndPassions, workAndSideProjects])
    return demoModel
}()
