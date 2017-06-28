const color = require('../utils/color');
const uiview  = require('./uiview');

const uibutton = {

  'contentEdgeInsets': function(values) {
    return `UIEdgeInsetsMake(${values})`;
  },
  'tintColor': color.fromString,
};

// merge uibutton property helpers with uiview helpers
module.exports = Object.assign({}, uiview, uibutton);