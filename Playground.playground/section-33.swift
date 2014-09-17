func oldest(date: NSDate?, person: Person) -> NSDate? {
    if let date = date {
        if date.compare(person.birthdate) == NSComparisonResult.OrderedAscending {
            return date
        } else {
            return person.birthdate
        }
    } else {
        return person.birthdate
    }
}

people.reduce(nil, combine: oldest)