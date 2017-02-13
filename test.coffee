window.Test = {}

class Test.A
class Test.B extends Test.A
class Test.C extends Test.A
class Test.D extends heterarchy.multi(Test.B, Test.C)



JsUml.generateUml(Test)
