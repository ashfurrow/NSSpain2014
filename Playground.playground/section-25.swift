func getPeopleStillLeftToCelebrateBirthday_Functionally(people: [Person]) -> [Person] {
    let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
    let currentDay = calendar.ordinalityOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitYear, forDate: NSDate.date())
    
    func celebratedBirthdayYet(person: Person) -> Bool {
        let birthdayDay = calendar.ordinalityOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitYear, forDate: person.birthdate)
        return birthdayDay >= currentDay
    }
    
    return people.filter(celebratedBirthdayYet)
}

getPeopleStillLeftToCelebrateBirthday_Functionally(people)