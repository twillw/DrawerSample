const color = require('../utils/color');

module.exports = {

  'backgroundColor': color.fromString,
  'heightAnchor': function (value) {
    return `heightAnchor.constraint(equalToConstant: ${value})`
  }

};

