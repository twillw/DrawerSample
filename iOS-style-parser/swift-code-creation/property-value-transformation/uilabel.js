const color = require('../utils/color');
const uiview  = require('./uiview');

const uilabel = {

  'textColor': color.fromString,
};

// merge uilabel property helpers with uiview helpers
module.exports = Object.assign({}, uiview, uilabel);
