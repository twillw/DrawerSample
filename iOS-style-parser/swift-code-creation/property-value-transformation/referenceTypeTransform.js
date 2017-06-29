const color = require('../utils/color');

module.exports = {

  'font': function(refData) {
    return `UIFont(name: "${refData.$.fontName}", size: ${refData.$.size})`;
  },

  'color': function (refData) {
    return color.fromString(refData.$.value);
  },

  'cg-color': function (refData) {
    return `${color.fromString(refData.$.value)}.cgColor`
  },

  'dimension': function (refData) {
    return refData.$.value;
  }
};