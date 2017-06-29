const color = require('../utils/color');

module.exports = {

  'backgroundColor': color.fromString,
  'heightAnchor': function (value) {
    return `heightAnchor.constraint(equalToConstant: ${value}).isActive = true`
  },
  'layer.shadowColor': function (value) {
    return `${color.fromString(value)}.CGColor`
  }

};

