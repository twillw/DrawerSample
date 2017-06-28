const color = require('../utils/color');

module.exports = {

  'font': function(refData) {
    return `UIFont(name: "${refData.$.fontName}", size: ${refData.$.size})`;
  },

  'color': function (refData) {
    console.log('COLOR REF DATA');
    console.log(refData);
    return color.fromString(refData.$.value);
  },

  'dimension': function (refData) {
    return refData.$.value;
  }
};