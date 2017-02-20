if typeof window isnt "undefined"
    root = window
else if typeof global isnt "undefined"
    root = global

if require?
    heterarchy = require("heterarchy")
    JsUml = require("./js_uml.js")

root.namespace1 = {}
root.namespace2 = {}
root.namespace3 = {}
root.namespace4 = {}

class root.namespace1.A
class root.namespace1.B extends root.namespace1.A
class root.namespace1.C extends root.namespace1.A
class root.namespace1.D extends heterarchy.multi(root.namespace1.B, root.namespace1.C)
class root.namespace1.E extends root.namespace1.A
class root.namespace1.F extends heterarchy.multi(root.namespace1.C, root.namespace1.E)
class root.namespace1.G extends heterarchy.multi(root.namespace1.D, root.namespace1.F)

class root.namespace2.A

class root.namespace3.A
class root.namespace4.A
class root.namespace1.X extends root.namespace3.A
class root.namespace1.X extends heterarchy.multi(root.namespace3.A, root.namespace4.A)

JsUml.setNamespaceGetter (namespace) ->
    if namespace is root.namespace1
        return "namespace1"
    if namespace is root.namespace2
        return "namespace2"
    if namespace is root.namespace3
        return "namespace3"
    return ""
JsUml.generateUml(namespace1, namespace2)
