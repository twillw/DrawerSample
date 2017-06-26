const fs = require('fs');
const Mustache = require('mustache');

const TEMPLATE_PATH = __dirname + '/swift/__template.swift';

class SwiftClassGenerator {

  constructor(fileName) {

    // set instance variables
    this._fileName = fileName;
    this._filePath = __dirname + `/swift/${this._fileName}.swift`;
  }

  createFile() {

    // render template
    fs.readFile(TEMPLATE_PATH, 'utf8', (err, data) => {
      if (err) {
        console.log('Error reading template file: ', err);
      }

      const renderedTemplate = Mustache.render(data, { className: this._fileName });

      fs.writeFile(this._filePath, renderedTemplate, (err) => {
        if (err) {
          console.log('Error creating file: ', this._filePath);
        }
        else {
          console.log('Successfully wrote file');
        }
      });
    });
  }
}

module.exports = SwiftClassGenerator;