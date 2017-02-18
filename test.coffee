window.namespace1 = {}
window.namespace2 = {}
window.namespace3 = {}

class namespace1.A
class namespace1.B extends namespace1.A
class namespace1.C extends namespace1.A
class namespace1.D extends heterarchy.multi(namespace1.B, namespace1.C)
class namespace1.E extends namespace1.A
class namespace1.F extends heterarchy.multi(namespace1.C, namespace1.E)
class namespace1.G extends heterarchy.multi(namespace1.D, namespace1.F)

class namespace2.A

class namespace3.A
class namespace1.X extends namespace3.A

JsUml.setNamespaceGetter (namespace) ->
    if namespace is window.namespace1
        return "namespace1"
    if namespace is window.namespace2
        return "namespace2"
    if namespace is window.namespace3
        return "namespace3"
    return ""
JsUml.generateUml(namespace1, namespace2)
