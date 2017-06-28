module.exports = function(className) {
  console.log(className);
  return require(`./${className.toLowerCase()}.js`);
};