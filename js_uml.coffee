if typeof window isnt "undefined"
    # create `JsUml` namespace that is created implicitly when using node because
    # `JsUml = require('js_uml.js');`
    exports = (window.JsUml = {})
    heterarchy = window.heterarchy
    _global = window
else if typeof global isnt "undefined"
    exports = module.exports
    _global = global


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
        return classes
    {}
)
isJavaScriptClass = (cls) ->
    return javaScriptClasses[cls] is cls

isClass = (obj) ->
    return typeof(obj) is "function" and obj.prototype? and not isJavaScriptClass(obj)

# # @param visitedClasses [Array] Accumulator
# traverse = (classes) ->
#     plantUml = ""
#     for cls in classes
#         # heterarchy's `extends multi(bases...)`
#         if cls.__bases__?
#             bases = cls.__bases__
#         # CoffeeScript's normal `extends Class`
#         else if cls.__super__
#             bases = [cls.__super__.constructor]
#         # no inheritance
#         else
#             bases = []
#
#         if bases.length > 0
#             for base in bases
#                 plantUml += "#{base.name} <|-- #{cls.name}\n"
#             plantUml += traverse(bases)
#     return plantUml

namespaceId = 1
getNamespaceName = (namespace) ->
    return "namespace##{namespaceId++}"

getNamespaceOfClass = (cls, tuples) ->
    for tuple in tuples when tuple[0] is cls
        return tuple[1]
    return null

unique = (arr) ->
    res = []
    for e in arr when e not in res
        res.push(e)
    return res

inheritsSelf = (line) ->
    parts = line.split(/\s*\<\|\-\-\s*/)
    return parts[0] is parts[1]

# remove duplicates and `A <|-- A` like lines
clean = (lines) ->
    return (line for line in unique(lines) when not inheritsSelf(line))

exports.setNamespaceGetter = (getter) ->
    getNamespaceName = getter

# @param namespaces... [Object] The namespaces that will be checked for classes
exports.generateUml = (namespaces...) ->
    classes = {}
    classNamespaceTuples = []
    classNames = []
    duplicateClassNames = []
    for namespace in namespaces
        namespaceName = getNamespaceName(namespace)
        classes[namespaceName] = []
        for name, cls of namespace when isClass(cls) and cls not in classes
            classes[namespaceName].push(cls)
            classNamespaceTuples.push([cls, namespaceName])
            if name in classNames
                duplicateClassNames.push(name)
            classNames.push(name)

    plantUmlLines = ["@startuml"]

    for namespaceName, classList of classes
        for cls in classList
            # heterarchy's `extends multi(bases...)`
            if cls.__bases__? and cls.__bases__ isnt cls.__super__?.constructor.__bases__
                bases = cls.__bases__
            # CoffeeScript's normal `extends Class`
            else if cls.__super__
                bases = [cls.__super__.constructor]
            # no inheritance
            else
                bases = []

            for base in bases
                plantUmlLine = ""
                if base.name in duplicateClassNames
                    namespaceName = getNamespaceOfClass(base, classNamespaceTuples)
                    if namespaceName?.length > 0
                        plantUmlLine += "#{namespaceName}."
                plantUmlLine += "#{base.name} <|-- #{cls.name}"
                plantUmlLines.push(plantUmlLine)

    plantUmlLines.push("@enduml")
    # make unique because x could inherit from 2 different A
    plantUml = clean(plantUmlLines).join("\n")
    console.log(plantUml)
