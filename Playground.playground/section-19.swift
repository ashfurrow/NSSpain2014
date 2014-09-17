func getPeopleNames_Functionally(people: [Person]) -> [String] {
    return people.map{ (person: Person) in
        person.name
    }
}

getPeopleNames_Functionally(people)