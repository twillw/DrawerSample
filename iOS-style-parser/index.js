const fs = require('fs');
const parseString = require('xml2js').parseString;

const SwiftClassGenerator = require('./SwiftClassGenerator');

const readStyleXml = (fileName) => {

  return new Promise((resolve, reject) => {
    fs.readFile(__dirname + `/styles/${fileName}`, function (err, data) {

      if (err) {
        console.log(err);
        return reject(err);
      }
      parseString(data, function (err, result) {
        if (err) {
          console.log(err);
          return reject(err);
        }

        console.dir(result);
        console.log(result.resources.style);
        console.log('Done');
        return resolve(result);
      });
    });
  });
};

const generateSwiftClass = (styleObject) => {

  // create file generator
  const generator = new SwiftClassGenerator('TestClass');

  // create new swift class file
  generator.createFile();
};

readStyleXml('sample.xml')
  .then(generateSwiftClass);
