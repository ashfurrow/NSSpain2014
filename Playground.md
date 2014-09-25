# Functional Programming in Swift

Let's take a quick tour through some neat examples of how to use functional programming in swift. Recall that functional programming is a paradigm that expresses computation through a series of *functions* (like the math kind of function, sort of). In functional programming, we try and avoid mutable data and state. Let's dive right in!

```swift
import Foundation

var numbers = [1, 52, 4, 90, 17, 42, 72, 101, 55, 3]
```

Pretty straightforward – just an array of some integers. Let's say we'd like to sort that array. How would we do it? Well, we know that Swift has a `sorted` method on the Array type that returns a newly sorted array, according to the closure that we pass into the `sorted` method. Let's take a look. 


```swift
numbers.sorted { (lhs, rhs) -> Bool in
    return lhs < rhs
}
```

That's not bad. But we can do better. If we look at the definition for `sorted`, we see that it takes in a closure of type `(T, T) -> Bool`, where `T` is just the type of the array (in our case, `Int`). The closure takes two parameters, in this case integers, and returns a `Bool` that's true if and only if the first parameter comes before the second one in the sorted list. I know of another function that takes two `Int`s and returns `true` if and only if the first one is "in order": `<`, the less-than operator. 

So revisiting the sorting example above, let's rewrite this. 

```swift
numbers.sorted(<)
```

![Mind. Blown.](http://cloud.ashfurrow.com/image/2k3Q2A0I040H/j74SykU.gif)

I hope that I have piqued your interests, but we are just getting started. 

Let's define our own method called `isPrime` that lets us know whether or not an integer is [prime](http://en.wikipedia.org/wiki/Prime_number).

```swift
func isPrime(number: Int) -> Bool {
    let squareroot = Int(sqrt(Double(number)))
    for var i = 2; i <= squareroot; i++ {
        if (number % i) == 0 {
            return false
        }
    }
    
    return true
}
```

We know from some [pretty cool number theory](http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes) that numbers are prime if and only if they are not divisible by any number between 2 and the square root of themselves. That's what this method does. 

So now let's say we want to filter out non-primes from our `numbers` array. Well, there's the naïve approach:

```swift
numbers.filter { (i) -> Bool in
    return isPrime(i)
}
```

Or, as I think you've probably figured out, the *really cool* approach:

```swift
numbers.filter(isPrime)
```

We can even chain them together if we want a list of sorted primes.

```swift
let sortedPrimes = numbers.sorted(<).filter(isPrime)
```

Neato. OK, onto something more interesting. Let's define a simple data model and an array of those model objects.

```swift 
struct Person {
    let name: String
    let birthdate: NSDate
}

let people = [
    Person(name: "Alice", birthdate: NSDate(timeIntervalSince1970: 577209600)),
    Person(name: "Bob", birthdate: NSDate(timeIntervalSince1970: 690397200)),
    Person(name: "Carol", birthdate: NSDate(timeIntervalSince1970: -211478400))
]
```

Just three people with three names and birthdays. Alice is about my age, while Bob is a bit younger. Carol is an old-timer, but you should never underestimate the wisdom of experience. 

Let's say we want to get the names of everyone in our list. We could write a method to do so using the traditional imperative paradigm, like so.

```swift
func getPeopleNames_Imperatively(people: [Person]) -> [String] {
    var results = [String]()
    for person in people {
        results.append(person.name)
    }
    return results
}

getPeopleNames_Imperatively(people)
```

But this approach has a `results` array that we keep changing. Ew! Functional programming tries to avoid this kind of mutable data. So let's take another approach. 

```swift
func getPeopleNames_Functionally(people: [Person]) -> [String] {
    return people.map{ (person: Person) in
        person.name
    }
}

getPeopleNames_Functionally(people)
```

Way cooler. `map` is a function on `Array` that invokes the closure you pass it on each member of that array. `map` returns a *new array* containing the return values of that closure, with the order corresponding to that of the original array. `map` is *very commonly used* in functional programming. It helps us avoid state and sets up our computations as a result of a function invocation. Super cool. 

Let's say we want to get the people who still have yet to celebrate their birthday *this year*. To do so imperatively, we'd use this function. 

```swift
func getPeopleStillLeftToCelebrateBirthday_Imperatively(people: [Person]) -> [Person] {
    let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
    let currentDay = calendar.ordinalityOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitYear, forDate: NSDate.date())
    
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
```

This uses a very similar technique to the one above that collected names. And just like before, there's a better way to do it. 

```swift
func getPeopleStillLeftToCelebrateBirthday_FunctionallyButCouldBeBetter(people: [Person]) -> [Person] {
    let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
    let currentDay = calendar.ordinalityOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitYear, forDate: NSDate.date())
    
    return people.filter{ (person: Person) -> Bool in
        let birthdayDay = calendar.ordinalityOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitYear, forDate: person.birthdate)
        return birthdayDay >= currentDay
    }
}

getPeopleStillLeftToCelebrateBirthday_FunctionallyButCouldBeBetter(people)
```

Nice. We're using `filter`, another common function in functional programming. But we can make this *even cooler*. Remember earlier when we passed in `isPrime` into `filter`? Well, Swift let's us define functions within other function definitions. So let's take another crack at writing this method.

```swift
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
```

By abstracting the logic from the `filter` function into the new `celebratedBirthdayYet` one, we get better separation of concern: the `filter` block is *only* concerned about what to filter by, not the ins and outs of how to filter. Also, if we ever need the `celebratedBirthdayYet` function elsewhere, it is now easy to abstract into a higher scope to be used by others. 

![Aw yeah](http://cloud.ashfurrow.com/image/3f0w0p0B3F3a/success%20kid.jpg)

Ok, just one more example. Let's say we want to get the oldest person in our list (sorry, Carol). The way to do this imperatively would be very similar to our other two imperative functions. 

```swift
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
```

Let's see how this could be rewritten to be more functional. 

```swift
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
```

This function uses `reduce`, another useful, but somewhat confusing function. `reduce` (sometimes called "fold") can be thought of like a way to iterate over your entire array. At each invocation, the `combine` closure is invoked and passed in the result of the last `combine` invocation, or the first parameter to `reduce` if `combine` hasn't been invoked yet. 

`reduce` is useful for choosing one element out of a long list. However, its uses extend far beyond just choosing values. It can be used for all sorts of things. Take summing up our numbers from earlier, for example. 

```swift
numbers.reduce(0, combine: +)
```

Bam. And that's only scratching the surface. The reduce method signature is pretty complex: `reduce<U>(initial: U, combine: (U, T) -> U) -> U`. The return value of `reduce` is the same type as the return value of the closure and the first parameter. It also is the same value that is passed into the closure. Say we want to just grab the *oldest person's birthday*, but we don't care about the actual `Person` object – we just want the date. Well, `reduce` is such that we can do that. 

```swift
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
```

Super cool. Good job, team!

![We did it!](http://cloud.ashfurrow.com/image/040V1T1p2k3G/anchorman-jump-in-air.gif)

I hope you found this bith informative and awesome. If you have questions or comments, please [get in touch](http://twitter.com/ashfurrow). 
