const fs = require('fs');
const path = require('path');
const parseString = require('xml2js').parseString;
const SwiftClassGenerator = require('./swift-code-creation/SwiftClassGenerator');

const readStyleXml = function(filePath) {

  return new Promise(function(resolve, reject) {
    fs.readFile(filePath, function (err, data) {

      if (err) {
        console.log(err);
        return reject(err);
      }
      parseString(data, function (err, result) {
        if (err) {
          console.log(err);
          return reject(err);
        }

        const filePathParts = filePath.split('/');
        const fileName = filePathParts[filePathParts.length - 1];
        return resolve(result.resources, fileName);
      });
    });
  });
};

const evaluateStyles = function(stylesDirectory, outputDirectory) {

  fs.readdir(stylesDirectory, function (err, files) {

    const fileName = 'Style';
    const generator = new SwiftClassGenerator(fileName, outputDirectory);

    // iterate over files and load style data for each
    Promise.all(files.map(function (file) {

        console.log('FILE');
        console.log(file);
        return readStyleXml(path.join(stylesDirectory, file))
          .then((data) => generator.loadStyles(data))
      })
    )
    .then(() => generator.createFile())
    .catch((e) => {
      console.log(e);
      throw e;
    });
  });
};

// first argument is output directory
const stylesDirectory = process.argv[2] || (__dirname + '/styles');
const outputDirectory = process.argv[3];

evaluateStyles(stylesDirectory, outputDirectory);


