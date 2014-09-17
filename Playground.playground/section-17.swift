func getPeopleNames_Imperatively(people: [Person]) -> [String] {
    var results = [String]()
    for person in people {
        results.append(person.name)
    }
    return results
}

getPeopleNames_Imperatively(people)