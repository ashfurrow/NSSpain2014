func getPeopleStillLeftToCelebrateBirthday_Imperatively(people: [Person]) -> [Person] {
    let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
    let currentDay = calendar.ordinalityOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitYear, forDate: NSDate())
    
    var results = [Person]()
    for person in people {
        let birthdayDay = calendar.ordinalityOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitYear, forDate: person.birthdate)
        if birthdayDay >= currentDay {
            results.append(person)
        }
    }
    
    return results
}

getPeopleStillLeftToCelebrateBirthday_Imperatively(people)