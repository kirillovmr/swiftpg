


struct Dog {
    var name : String
    
    mutating func setName(_ newName:String) {
        name = newName
    }
}

var dog = Dog(name: "Lol") {
    didSet {
        print("Dog was instantiated")
    }
}
dog.name = "Max"
//dog.name
//dog.setName("sasha")
//dog.name



protocol Walker {
    func walk()
}

class Cat : Walker {
    func walk() {
        print("walk")
    }
    func meow() {
        print("Meow")
    }
}

class Kitten : Cat {
    override func meow() {
        print("MEOEOEOEW")
        super.meow()
    }
}

extension Walker {
    func walk1() {
        print("walking!")
    }
}

var str:String? = "Hey"
if var string = str as? String {
    print("String")
}
else if var string = str as? Int {
    print("Int")
}
else {
    print("Not success")
}

label: do {
    if false {
        break label
    }
    print ("check")
}

print ("hey")

1 + 2
