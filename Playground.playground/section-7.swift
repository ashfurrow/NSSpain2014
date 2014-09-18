func isPrime(number: Int) -> Bool {
    let squareroot = Int(sqrt(Double(number)))
    for var i = 2; i <= squareroot; i++ {
        if (number % i) == 0 {
            return false
        }
    }
    
    return true
}