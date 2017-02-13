if typeof window isnt "undefined"
    # create `JsUml` namespace that is created implicitly when using node because
    # `JsUml = require('js_uml.js');`
    exports = (window.JsUml = {})
    heterarchy = window.heterarchy
    _global = window
else if typeof global isnt "undefined"
    exports = module.exports
    _global = global


is_class = (obj) ->
    return typeof(obj) is "function" and obj.prototype?

javaScriptClassNames = [
    "Array"
    "Boolean"
    "Date"
    "Error"
    "Function"
    "Number"
    "RegExp"
    "String"
    "Object"
    "EvalError"
    "RangeError"
    "ReferenceError"
    "SyntaxError"
    "TypeError"
    "URIError"
    # non-standard classes
    "Symbol"
    # typed arrays
    "Int8Array"
    "Uint8Array"
    "Uint8ClampedArray"
    "Int16Array"
    "Uint16Array"
    "Int32Array"
    "Uint32Array"
    "Float32Array"
    "Float64Array"
    # Keyed collections
    "Map"
    "Set"
    "WeakMap"
    "WeakSet"
    # Structured data
    "ArrayBuffer"
    "DataView"
    # Control abstraction objects
    "Promise"
    "Generator"
    "GeneratorFunction"
    # Reflection
    "Reflect"
    "Proxy"
]
javaScriptClasses = javaScriptClassNames.reduce(
    (classes, name) ->
        classes[_global[name]] = _global[name]
        classes
    {}
)
isJavaScriptClass = (cls) ->
    javaScriptClasses[cls] is cls

# @param namespaces... [Object] The namespaces that will be checked for classes
exports.generateUml = (namespaces...) ->
    classes = []
    for namespace in namespaces
        for name, cls of namespace when is_class(cls) and cls not in classes
            classes.push(cls)

    plant_uml = "@startuml\n"
    for cls in classes
        # heterarchy's `extends multi(bases...)`
        if cls.__bases__?
            bases = cls.__bases__
        # CoffeeScript's normal `extends Class`
        else if cls.__super__
            bases = [cls.__super__.constructor]
        # no inheritance
        else
            bases = []

        for base in bases
            plant_uml += "#{base.name} <|-- #{cls.name}\n"

    plant_uml += "@enduml"
    console.log(plant_uml)
