import UIKit


// MARK: - Structural Design Patterns


// MARK: - 1.Proxy (Protection Proxy)  ========================================================

//EX1:--------------
protocol SMSService {
    func sendSMS(custId: String , mobile: String , sms: String)
}

class ConcreteSMSManager : SMSService {
    func sendSMS(custId: String, mobile: String, sms: String) {
        print("the user with id:\(custId) send msg:\(sms) to mobile:\(mobile) ")
    }
}

class ProxySMSManager {
    lazy var smsService : SMSService = ConcreteSMSManager()
    var sentCount = [String : Int]()
    func sendSMS(custId: String , mobile: String , sms: String){
        if !sentCount.keys.contains(custId){
            sentCount[custId] = 1
            smsService.sendSMS(custId: custId, mobile: mobile, sms: sms)
    
        }else{
            guard var custValue = sentCount[custId] else {
                return
            }
            if custValue >= 3 {
                print("Can't Send!")
            }else {
                custValue = custValue + 1
                sentCount[custId] = custValue
                smsService.sendSMS(custId: custId, mobile: mobile, sms: sms)
            }
        }
    }
}

var smsProxy = ProxySMSManager()
smsProxy.sendSMS(custId: "123", mobile: "0112233", sms: "message 01")
smsProxy.sendSMS(custId: "123", mobile: "0112233", sms: "message 02")
smsProxy.sendSMS(custId: "123", mobile: "0112233", sms: "message 03")
smsProxy.sendSMS(custId: "123", mobile: "0112233", sms: "message 04")
smsProxy.sendSMS(custId: "12", mobile: "13456", sms: "message")


//EX2:--------------
//Implementation
protocol DoorOpening {
    func open(doors: String)-> String
}

class ConcreteDoorManager : DoorOpening {
    func open(doors: String) -> String {
        return "Doors that opening are \(doors) doors "
    }
}

class ProxyDoorManager {
    
     private var computer : ConcreteDoorManager!
    
    func open(door : String)-> String {
        guard computer != nil else {
            return "Access Denied"
        }
        return computer.open(doors: door)
    }
    
    func authenticate(password: String) -> Bool{
            guard password == "pass" else{
                return false
            }
            computer = ConcreteDoorManager()
            return true
        }
}

//Usage ------------------
let computer = ProxyDoorManager()
let door = "4"
computer.open(door: door)

computer.authenticate(password: "pass")
computer.open(door: door)



// MARK: - 2.Decorator (Wrapper) ========================================================

//Implementation
protocol DataHaving {
    var ingredient : [String] {get}
    var cost : Double {get}
}

struct Pizza : DataHaving {
    var ingredient: [String] = ["Pizza"]
    
    var cost: Double = 50
}


protocol componentDecorator : DataHaving {
    var component : DataHaving {get}
}

struct chesse : componentDecorator {
    var component: DataHaving
    
    var ingredient: [String] {
        return component.ingredient + ["of chesse"]
    }
    
    var cost: Double {
        return component.cost + 10
    }
}


struct Cheichen : componentDecorator {
    var component: DataHaving
    
    var ingredient: [String] {
        return component.ingredient + ["of Cheichen"]
    }
    
    var cost: Double {
        return component.cost + 20
    }
}

struct Mozzarell: componentDecorator{
    var component: DataHaving
    
    var ingredient: [String] {
        return component.ingredient + ["Mozzarell"]
    }
    
    var cost: Double{
        return component.cost + 5
    }
      
}

//Usage ------------------
var pizza : DataHaving = Pizza()
pizza.cost
pizza.ingredient

pizza = Mozzarell(component: pizza)
pizza.cost
pizza.ingredient

pizza = Cheichen(component: pizza)
pizza.cost
pizza.ingredient



// MARK: - 3.Adapter  ========================================================

//Implementation
struct OldStarAngle {
    let angleH : Float
    let angleV : Float
    init(angleH: Float, angleV: Float) {
        self.angleH = angleH
        self.angleV = angleV
    }
}
struct NewStarAngle {
    let target : OldStarAngle
    
    var angleH : Int {
        return Int(target.angleH)
    }
    var angleV : Int {
        return Int(target.angleV)
    }
    
    init(target: OldStarAngle) {
        self.target = target
    }
}
//Usage ------------------
let angle = OldStarAngle(angleH: 10.345, angleV: 12.32454)
let newFormat = NewStarAngle(target: angle)
newFormat.angleH
newFormat.angleV



// MARK: - 5.Facade  ========================================================

//The facade pattern is used to define a simplified interface to a more complex subsystem.


//Implementation
class Defaults {
    private let defaults : UserDefaults
    init(defaults: UserDefaults ) {
        self.defaults = defaults
    }
    subscript(key : String)-> String?{
        get {
            return defaults.string(forKey: key)
        }
        set{
            defaults.setValue(newValue, forKey: key)
        }
    }
}

//Usage ------------------
let storage = Defaults(defaults: .standard)
storage["myName"] = "Mohamed"
storage["myName"]
storage["mm"] = "Ahmed"
storage["myName"] = "Ali"
storage["myName"]
storage["mm"]




// MARK: - Interview Question in Awmmer Alshabaka

protocol ServiceDelegate {
    func makeAction()
}
class Controller1: ServiceDelegate{
    
//        var controller2 = Controller2(delegate: self)  // problem
    
//    var controller2 = Controller2(delegate: Controller1()) // may be solution
    lazy var controller2 = Controller2(delegate: self)  // second solution
    
    func makeAction() {
//        var controller2 = Controller2(delegate: self) // first solution
        print("action")
        controller2.makeAny()
    }
}

class Controller2 {
    let delegate: ServiceDelegate
    init(delegate: ServiceDelegate) {
        self.delegate = delegate
    }
    func makeAny(){
        print("dkfjklaj")
    }
}
