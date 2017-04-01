// Generated by CoffeeScript 1.10.0
var append3bytes, compress, encode64, encode6bit;

encode64 = function(data) {
  var i, r;
  r = "";
  i = 0;
  while (i < data.length) {
    if (i + 2 === data.length) {
      r += append3bytes(data.charCodeAt(i), data.charCodeAt(i + 1), 0);
    } else if (i + 1 === data.length) {
      r += append3bytes(data.charCodeAt(i), 0, 0);
    } else {
      r += append3bytes(data.charCodeAt(i), data.charCodeAt(i + 1), data.charCodeAt(i + 2));
    }
    i += 3;
  }
  return r;
};

append3bytes = function(b1, b2, b3) {
  var c1, c2, c3, c4, r;
  c1 = b1 >> 2;
  c2 = (b1 & 0x3) << 4 | b2 >> 4;
  c3 = (b2 & 0xF) << 2 | b3 >> 6;
  c4 = b3 & 0x3F;
  r = "";
  r += encode6bit(c1 & 0x3F);
  r += encode6bit(c2 & 0x3F);
  r += encode6bit(c3 & 0x3F);
  r += encode6bit(c4 & 0x3F);
  return r;
};

encode6bit = function(b) {
  if (b < 10) {
    return String.fromCharCode(48 + b);
  }
  b -= 10;
  if (b < 26) {
    return String.fromCharCode(65 + b);
  }
  b -= 26;
  if (b < 26) {
    return String.fromCharCode(97 + b);
  }
  b -= 26;
  if (b === 0) {
    return "-";
  }
  if (b === 1) {
    return "_";
  }
  return "?";
};

compress = function(s) {
  s = unescape(encodeURIComponent(s));
  return encode64(RawDeflate.deflate(s, 9));
};