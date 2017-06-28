module.exports = {

  fromString: function(colorString) {

    // check if value provided is hex value
    if (colorString.indexOf('#') >= 0) {
      return `self?.hexStringToUIColor("${colorString}")`;
    }
    // otherwise use rgb format - assuming this format: rgba(0,0,0,1)
    const start = colorString.indexOf('(') + 1;
    const end = colorString.indexOf(')');

    const values = colorString.slice(start, end).split(',');
    return `UIColor(colorLiteralRed: ${values[0]}/255, green: ${values[1]}/255, blue: ${values[2]}/255, alpha: ${values[3]})`
  }
};
