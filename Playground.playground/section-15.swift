struct Person {
    let name: String
    let birthdate: NSDate
}

let people = [
    Person(name: "Alice", birthdate: NSDate(timeIntervalSince1970: 577209600)),
    Person(name: "Bob", birthdate: NSDate(timeIntervalSince1970: 690397200)),
    Person(name: "Carol", birthdate: NSDate(timeIntervalSince1970: -211478400))
]