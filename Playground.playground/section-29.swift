func getOldestPerson_Functionally(people: [Person]) -> Person? {
    func olderPerson(lhs: Person!, rhs: Person) -> Person {
        if lhs.birthdate.compare(rhs.birthdate) == NSComparisonResult.OrderedAscending {
            return lhs
        } else {
            return rhs
        }
    }
    
    return people.reduce(people.first, combine: olderPerson)
}

getOldestPerson_Functionally(people)