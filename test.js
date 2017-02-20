// Generated by CoffeeScript 1.10.0
(function() {
  var JsUml, heterarchy, root,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  if (typeof window !== "undefined") {
    root = window;
    heterarchy = window.heterarchy;
    JsUml = window.JsUml;
  } else if (typeof global !== "undefined") {
    root = global;
    heterarchy = require("heterarchy");
    JsUml = require("./js_uml.js");
  }

  root.namespace1 = {};

  root.namespace2 = {};

  root.namespace3 = {};

  root.namespace4 = {};

  root.namespace1.A = (function() {
    function A() {}

    return A;

  })();

  root.namespace1.B = (function(superClass) {
    extend(B, superClass);

    function B() {
      return B.__super__.constructor.apply(this, arguments);
    }

    return B;

  })(root.namespace1.A);

  root.namespace1.C = (function(superClass) {
    extend(C, superClass);

    function C() {
      return C.__super__.constructor.apply(this, arguments);
    }

    return C;

  })(root.namespace1.A);

  root.namespace1.D = (function(superClass) {
    extend(D, superClass);

    function D() {
      return D.__super__.constructor.apply(this, arguments);
    }

    return D;

  })(heterarchy.multi(root.namespace1.B, root.namespace1.C));

  root.namespace1.E = (function(superClass) {
    extend(E, superClass);

    function E() {
      return E.__super__.constructor.apply(this, arguments);
    }

    return E;

  })(root.namespace1.A);

  root.namespace1.F = (function(superClass) {
    extend(F, superClass);

    function F() {
      return F.__super__.constructor.apply(this, arguments);
    }

    return F;

  })(heterarchy.multi(root.namespace1.C, root.namespace1.E));

  root.namespace1.G = (function(superClass) {
    extend(G, superClass);

    function G() {
      return G.__super__.constructor.apply(this, arguments);
    }

    return G;

  })(heterarchy.multi(root.namespace1.D, root.namespace1.F));

  root.namespace2.A = (function() {
    function A() {}

    return A;

  })();

  root.namespace3.A = (function() {
    function A() {}

    return A;

  })();

  root.namespace4.A = (function() {
    function A() {}

    return A;

  })();

  root.namespace1.X = (function(superClass) {
    extend(X, superClass);

    function X() {
      return X.__super__.constructor.apply(this, arguments);
    }

    return X;

  })(root.namespace3.A);

  root.namespace1.X = (function(superClass) {
    extend(X, superClass);

    function X() {
      return X.__super__.constructor.apply(this, arguments);
    }

    return X;

  })(heterarchy.multi(root.namespace3.A, root.namespace4.A));

  JsUml.setNamespaceGetter(function(namespace) {
    if (namespace === root.namespace1) {
      return "namespace1";
    }
    if (namespace === root.namespace2) {
      return "namespace2";
    }
    if (namespace === root.namespace3) {
      return "namespace3";
    }
    return "";
  });

  JsUml.generateUml(namespace1, namespace2);

}).call(this);
