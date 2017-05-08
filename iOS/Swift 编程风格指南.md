>**Swift 编程风格指南**
>尝试这种代码风格是为了达到以下目标:
1. 提升代码的精度并且减少人为出错的可能性.
2. 让代码表意更清晰.
3. 减少冗余.
4. 减少关于代码美学的争论.

如果你对这篇指南有任何建议,请参阅"contribution guidelines",并发起" pull request ".


-------
#空格
>* 使用"Tabs", 不要使用空格.
* 使用换行符结束文件(在文件的代码末尾后留空行)
* 使用足够的空行把逻辑代码块分隔成块.(Make liberal use of vertical whitespace to divide code into logical chunks.)
* 不要在右侧结尾处使用空格
    * 不要在一个空行处缩进
  
#在任何可能的情况下尽量使用`let` 替代` var`
>在声明变量时使用` let foo = ... ` 替代 ` var foo = .... ` 即使你不知道`foo`是不是会改变.除非你确定必须使用`var`来申明.(换句话说,你知道变量的值可能会改变 . 例如 当变量的内存管理你使用`weak`时候).
理由: 这两个关键字的表意都很清楚,但是默认使用 `let` 会使程序更加安全和代码更加干净. 

>一个使用 `let` 关键字申明的常量能够明确的告诉程序他的值是永远不会改变的.因此之后在review代码过程中能够很容易的推测出他的用途.

>这让你的代码变得更容易.如果你曾使用`var`声明一个变量 , 你需要去推测他的值是否会改变,这时你不得不手动去确认.
>
>综上, 不论何时你看到使用`var`关键字声明变量的时候,都是在假设他的值是会改变的,并且你应该问自己为什么(值会改变).


#尽早的使用 return break
>当你需要保证一段逻辑的执行需要通过一个条件语句进行判断,应尽可能早的退出判断. 不应该这样写:

```
if n.isNumber {
    // Use n here
} else {
    return
}
```
而应当这样:

```
guard n.isNumber else {
    return
}
// Use n here

```

>尽管你依然可以使用` if `表达式,但是使用`guard` 会更好 , 因为一旦使用` guard` 编译器会强制要求你 搭配使用` return, break, continue`,否则编译器将会报错,这样判断条件不成立时将能保证程序正确运行.(You can also do it with if statement, but using guard is prefered, because guard statement without return, break or continue produces a compile-time error, so exit is guaranteed.)


#对可选类型避免使用强制解包
>如果有一个变量`foo` 的类型是`FootType?`或者` FooType!`,如果可以不要使用强制解包` foo!` 来获取他的值.
>更好的替代方法

```
if let foo = foo {
    // Use unwrapped `foo` value in here
} else {
    // If appropriate, handle the case where the optional is nil
}

```
>另外你可以使用 swift 提供的可选链式调用来解包,比如像酱:

```
// Call the function if `foo` is not nil. If `foo` is nil, ignore we ever tried to make the call
foo?.callSomethingIfFooIsNotNil()
```

>理由: 使用显式的` if-let` 可选绑定解包会更加安全.强制解包会更容易导致运行时的崩溃.

#避免使用隐式的解包可选类型
>在申明的时候如果`foo` 的值可能为` nil `, 尽可能的使用` let foo : FooType?` 替代 `let foo: FooType!`.(通常情况下?可以被!替代).
>理由:显示解包的代码是安全的.隐式解包可选类型在运行时有潜在的可能导致程序崩溃.

#用隐式的getter 方法设置只读属性和下标
>任何可能的时候,只读的计算属性和只读的下标省略`get` 关键字
>所以酱紫写:

```
var myGreatProperty: Int {
	return 4
}

subscript(index: Int) -> T {
    return objects[index]
}
```
>而不要酱紫写:

```
var myGreatProperty: Int {
	get {
		return 4
	}
}

subscript(index: Int) -> T {
    get {
        return objects[index]
    }
}
```
>理由:代码的意图和表意上面的写法已经很清晰了,并且代码量可以更少.


#对于顶层定义,明确的给予权限控制
>顶层的 function , types , variables 应该有显示的访问控制说明符:(Top-level functions, types, and variables should always have explicit access control specifiers)

```
public var whoopsGlobalState: Int
internal struct TheFez {}
private func doTheThings(things: [Thing]) {}
```
>燃鹅 指定了顶层访问控制的定义其内部隐式的也会具有合适的访问控制.

```
internal struct TheFez {
	var owner: Person = Joshaber()
}
```
>理由：因为顶级定义很少有合适的情况指定为 `internal `，(所以在对一个顶级定义使用 `internal`时)要确保经过了仔细的思考。在一个定义内层中，重复使用相同的访问控制符是重复的 ,所以默认的上层控制符通常是就是合理的。

#在指定一个类型时标识符总是连着":"
>在指定一个标识符类型时,总是在名字的后面紧跟冒号空格再写类型名.

```
class SmallBatchSustainableFairtrade: Coffee { ... }

let timeToCoffee: NSTimeInterval = 2

func makeCoffee(type: CoffeeType) -> Coffee { ... }
```
>理由: 类型名是为了表示所声明的类型,所以类名应该紧跟在后面.

>同样的,在指定一个字典的类型时候,总是在键名的后面紧跟冒号,之后空格跟着键值.

```
let capitals: [Country: City] = [sweden: stockholm]

```
#只有在必要的时候显示的使用 "self"
>当在访问当前类的属性或者方法时,默认使用隐式的"self"
```
private class History {
	var events: [Event]

	func rewrite() {
		events = []
	}
}

```
>只有当语法要求必须使用的时候才显示使用` self`, 例如在闭包中或者当参数名有冲突时:
```
extension History {
	init(events: [Event]) {
		self.events = events
	}

	var whenVictorious: () -> () {
		return {
			self.rewrite()
		}
	}
}
```
>理由:在闭包中使用` self `更能凸显它的语义,并且避免冗余代码.(Rationale: This makes the capturing semantics of self stand out more in closures, and avoids verbosity elsewhere.)

#首选使用结构体
>除非你需要 class 才能提供的功能（比如 identity 或 deinitializers），不然就用 struct
要注意到继承通常不是用 类 的好理由，因为 多态 可以通过 协议 实现，重用 可以通过 组合 实现。
>比如，这个类的分级
(Unless you require functionality that can only be provided by a class (like identity or deinitializers), implement a struct instead.

>Note that inheritance is (by itself) usually not a good reason to use classes, because polymorphism can be provided by protocols, and implementation reuse can be provided through composition.

>For example, this class hierarchy:)

```
class Vehicle {
    let numberOfWheels: Int

    init(numberOfWheels: Int) {
        self.numberOfWheels = numberOfWheels
    }

    func maximumTotalTirePressure(pressurePerWheel: Float) -> Float {
        return pressurePerWheel * Float(numberOfWheels)
    }
}

class Bicycle: Vehicle {
    init() {
        super.init(numberOfWheels: 2)
    }
}

class Car: Vehicle {
    init() {
        super.init(numberOfWheels: 4)
    }
}

```
>可以这样重构

```
protocol Vehicle {
    var numberOfWheels: Int { get }
}

func maximumTotalTirePressure(vehicle: Vehicle, pressurePerWheel: Float) -> Float {
    return pressurePerWheel * Float(vehicle.numberOfWheels)
}

struct Bicycle: Vehicle {
    let numberOfWheels = 2
}

struct Car: Vehicle {
    let numberOfWheels = 4
}
```

>理由: 值的类型更简单，容易辨别，并且通过let关键字可猜测行为。




#默认使用" final" 关键字 修饰类
>类应当用`final` 关键字修饰,并且在已经确定的需要继承时候才做更改.即使在这种情况下类还是应该使用` final` 来修饰,遵循同样的规则.
>理由:组合通常比继承更合适，选择使用继承则很可能意味着在做出决定时需要更多的思考。



#尽可能的省略参数类型
>当参数的接受者参数类型和方法的中的参数一致时,可以省略参数类型.例如:
```
struct Composite<T> {
	…
	func compose(other: Composite<T>) -> Composite<T> {
		return Composite<T>(self, other)
	}
}
```
>可以这样改写

```
struct Composite<T> {
	…
	func compose(other: Composite) -> Composite {
		return Composite(self, other)
	}
}
```
>理由:省略多余的参数类型可以让表意更清晰,在返回值类型不同于参数类型时形成鲜明对比.

#在操作符前后添加空格
>在使用操作符的地方前后添加空格例如不要酱:

```
func <|(lhs: Int, rhs: Int) -> Int
func <|<<A>(lhs: A, rhs: A) -> A
```
>应该酱写:

```
func <| (lhs: Int, rhs: Int) -> Int
func <|< <A>(lhs: A, rhs: A) -> A

```
>理由:操作符是由标点字符组成的,如果后面紧跟类型或者值会让代码变得难以阅读.在操作符前后添加空格会使你的代码更整洁.


