func getOldestPerson_Imperatively(people: [Person]) -> Person? {
    var oldestPersonSoFar = people.first
    
    for person in people {
        if oldestPersonSoFar!.birthdate.compare(person.birthdate) == NSComparisonResult.OrderedDescending {
            oldestPersonSoFar = person
        }
    }
    
    return oldestPersonSoFar
}

getOldestPerson_Imperatively(people)