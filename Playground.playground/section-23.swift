func getPeopleStillLeftToCelebrateBirthday_FunctionallyButCouldBeBetter(people: [Person]) -> [Person] {
    let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
    let currentDay = calendar.ordinalityOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitYear, forDate: NSDate())
    
    return people.filter{ (person: Person) -> Bool in
        let birthdayDay = calendar.ordinalityOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitYear, forDate: person.birthdate)
        return birthdayDay >= currentDay
    }
}

getPeopleStillLeftToCelebrateBirthday_FunctionallyButCouldBeBetter(people)