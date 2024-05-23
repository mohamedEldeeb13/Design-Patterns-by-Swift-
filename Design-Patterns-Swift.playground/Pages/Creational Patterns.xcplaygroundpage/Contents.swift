
import Foundation

// MARK: - Creational Design Patterns

// MARK: - 1. Singleton ========================================================

//ده باترن بيخليني أعمل اوبجكت واحد بس من الكلاس ويكون عام علي مستوي التطبيق
//تستخدمه من أي كلاس تاني عالطول من غير متعمل كل شويه اوبجكت جديد


class Singleton {
    
    static let shared = Singleton()
    private init(){
        
    }
    
    func printingMethod() {
            print("Hello, I'm a singleton, and this is how to use me to call other functions inside me")
        }
}

//Using ------------------
Singleton.shared.printingMethod()



// if i want to Create instance only if needed in first call
class MySingleton {
  private static var _sharedInstance: MySingleton? // Optional to hold the instance

  static var shared: MySingleton {
    if _sharedInstance == nil {
      _sharedInstance = MySingleton() // Create instance only if needed
    }
    return _sharedInstance!
  }
    func printingMethod() {
            print("Hello, I'm a singleton, and this is how to use me to call other functions inside me")
        }

}

//Using ------------------
MySingleton.shared.printingMethod()





// MARK: - 2. Prototype ========================================================

//الباترن ده بيسمحلك انك تعمل ابجكت جديد عن طريق انك تعمل نسخ للأبجكت الموجود وتبدأ تغير في بعض الأتربيوت
// بدل متعمل كل شويه ابجكت جديد في اتربيوت كتير متشابهه

//Implementation
class ProtoType {
    var name : String
    var health : Int = 100
    init(name: String) {
        self.name = name
    }
    
    func clone() -> ProtoType {
        return ProtoType(name: name)
    }
}

//Using ------------------
 let prototype = ProtoType(name: "Mohamed")
prototype.clone()

let proto2 = prototype.clone()
proto2.name = "Ahmed"
proto2.health = 50
proto2.name





// MARK: - 3. Builder ========================================================

// Build complex object step by step
//هي أنك بتبني الاوبجكت بتاعك جزي جزء وفي الأخر تستخدم ميثود تجمع كل الاجزاء مع بعض وتكونلك الاوبجكت بتاعك

// ------------------ Example 1: Building car

//Implementation
struct Product {
    var parts : [String] = []
    
    mutating func addPart(part : String){
       parts.append(part)
    }
    
    func show(){
        var allParts = ""
        for part in parts {
            allParts += part + "\n"
        }
        print(allParts)
    }
}


protocol Builder{
    func startOperations()
    func buildBody()
    func insertWheels()
    func addHeadLights()
    func endOperations()
    func getVehicle() -> Product
}


//ConcreteBuilder Class
class Car : Builder {
    private var brandName: String = ""
    private var product: Product
    
    init(brandName: String) {
        self.brandName = brandName
        product = Product()
    }
    
    func startOperations() {
            product.addPart(part: "Car Model name is \(brandName)")
        }
        func buildBody() {
            product.addPart(part: "Body of car is added")
        }
        func insertWheels() {
            product.addPart(part: "Wheels are added")
        }
        func addHeadLights() {
            product.addPart(part: "HeadLights are added")
        }
        func endOperations() {
            
        }
        func getVehicle() -> Product {
            return product
        }
}

class Motocycle: Builder {
    private var brandName : String = ""
    private var product : Product
    init(brandName: String) {
        self.brandName = brandName
        product = Product()
    }
    func startOperations() {
            product.addPart(part: "MotorCycle Model name is \(brandName)")
        }
        func buildBody() {
            product.addPart(part: "Body of MotorCycle is added")
        }
        func insertWheels() {
            product.addPart(part: "Wheels are added")
        }
        func addHeadLights() {
            product.addPart(part: "HeadLights are added")
        }
        func endOperations() {
            
        }
        func getVehicle() -> Product {
            return product
        }
}

class Director {
    var builder : Builder?
    
    func construct(builder : Builder){
        self.builder = builder
        builder.startOperations()
        builder.buildBody()
        builder.insertWheels()
        builder.addHeadLights()
        builder.endOperations()
    }
    
}


//Using ------------------
let carBuilder : Builder = Car(brandName: "Jeep")
let motoCycleBuilder : Builder = Motocycle(brandName: "BMW")

let director = Director()

//Making Car
director.construct(builder: carBuilder)
let car : Product = carBuilder.getVehicle()
car.show()

//Making MotorCycle
director.construct(builder: motoCycleBuilder)
let motorCycle: Product = motoCycleBuilder.getVehicle()
motorCycle.show()




// MARK: - 4. Factory Method ========================================================

// Create object without exposing the creation logic to the client and
// refer to created object using  a common interface
// هو باترن بيخلي فيه حاجه زي كلاس مثلا يكون هو اللي مسئول عن انشاء ال ابجيكت
// بحيث لو عايز اضيف او اعدل في اوبجيكت اكون عارف المكان ال هضيف فيه


// ------------------ EXample 1:
//Implementation
protocol CurrencyDescribing {
    var symbol : String {get}
    var code : String {get}
}

final class Euro: CurrencyDescribing {
    var symbol: String {
        return "€"
    }
    
    var code: String {
        return "EUR"
    }
}

final class UnitedStatesDolar: CurrencyDescribing {
    var symbol: String {
        return "$"
    }
    
    var code: String{
        return "USD"
    }
}

enum country {
    case unitedStates
    case spain
    case uk
    case greece
}

enum CurrencyFactory {
    static func currency(for country : country)-> CurrencyDescribing? {
        switch country {
        case .unitedStates:
            return UnitedStatesDolar()
        case .spain , .greece:
            return Euro()
        default:
            return nil
        }
    }
}


//Using ------------------
let noCurrencyCode = "No Currency Code Available"
CurrencyFactory.currency(for: .spain)?.code ?? noCurrencyCode
CurrencyFactory.currency(for: .unitedStates)?.code ?? noCurrencyCode
CurrencyFactory.currency(for: .uk)?.code ?? noCurrencyCode
CurrencyFactory.currency(for: .greece)?.code ?? noCurrencyCode



//  ------------------ Example 2: Bank - ATM
//Implementation
protocol Bank {
    func withdrow()-> String
}


class BankA : Bank {
    func withdrow() -> String {
        return "Your request is handling by BankA"
    }
    
    
}

class BankB : Bank {
    func withdrow() -> String {
        return "Your request is handling by BankB"
    }
}

protocol BankService {
    func getBank(bankCode : String)-> Bank?
    func getPaymentCard(cardNumber: String) -> PaymentCard?
}

class BankFactory : BankService {
    func getBank(bankCode: String) -> Bank? {
        switch bankCode {
        case "123":
            return BankA()
        case "111":
            return BankB()
        default:
            return nil
        }
    }
    func getPaymentCard(cardNumber: String) -> PaymentCard? {
            switch cardNumber{
            case "123":
                return VisaCard()
            case "111":
                return MasterCard()
            default:
                return nil
            }
        }
}


//Using ------------------
let bankFactory = BankFactory()
let bank : Bank? = bankFactory.getBank(bankCode: "123")
bank?.withdrow()


// MARK: - 5. Abstract Factory ========================================================



//------------------ Example 1: Bank - ATM .. Continue..
protocol PaymentCard{
    func getName() -> String
    func getProviderInfo() -> String
}

class VisaCard: PaymentCard{
    func getName() -> String {
        return "Visa Card"
    }
    
    func getProviderInfo() -> String {
        return "Visa"
    }
}
class MasterCard: PaymentCard{
    func getName() -> String {
        return "Master Card"
    }
    
    func getProviderInfo() -> String {
        return "Master"
    }
}

let paymentCard: PaymentCard? = bankFactory.getPaymentCard(cardNumber: "123")
paymentCard?.getName()

