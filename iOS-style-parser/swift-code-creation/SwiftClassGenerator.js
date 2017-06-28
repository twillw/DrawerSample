const fs = require('fs');
const Mustache = require('mustache');
const refTypeTransform = require('./property-value-transformation/referenceTypeTransform');
const propertyValueTransform = require('./property-value-transformation');

const TEMPLATE_PATH = __dirname + '/../swift/templates/__template.swift';

class SwiftClassGenerator {

  // constructor

  constructor(fileName, outDirectory) {

    const outputPath = outDirectory || __dirname + '/../output';
    // set instance variables
    this._fileName = fileName;
    this._filePath = `${outputPath}/${this._fileName}.swift`;
    this._styleData = [];
    this._referenceData = {};
  }


  // public methods

  loadStyles(styleData) {

    const style = styleData.style;
    delete styleData.style;

    // merge reference data with existing ref data
    Object.assign(this._referenceData, styleData);
    console.log(this._referenceData);

    // build object to render template with
    if (typeof style === 'undefined') {
      return;
    }
    style.forEach((style) => {

      // add each new style object to array
      this._styleData.push(style);
    });

    return this;
  }

  createFile() {

    // render template
    fs.readFile(TEMPLATE_PATH, 'utf8', (err, data) => {
      if (err) {
        console.log('Error reading template file: ', err);
      }

      // format style data to fit template
      const styleData = this._styleData.map(this._buildStyleObject.bind(this));

      // render class template with style data
      const renderedTemplate = Mustache.render(data, { styles: styleData });

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

  // private methods

  _buildStyleObject(style) {

    let styleObject = {
      name: style.$.name,
      className: style.$.target,
      variableName: style.$.target.toLowerCase()
    };

    if (typeof style.setter !== 'undefined') {

      styleObject.properties = style.setter.map((setter) => {
        return {
          propertyName: setter.$.property,
          value: this._transformPropertyValue(setter.$.property, setter.$.value, style.$.target,
            setter.$.reference, setter.$.referenceType)
        }
      })
    }
    if (typeof style.method !== 'undefined') {
      styleObject.methods = style.method.map((method) => {
        return {
          methodCall: this._transformPropertyValue(method.$.property, method.$.value, style.$.target,
            method.$.reference, method.$.referenceType)
        }
      })
    }

    return styleObject;
  }

  _transformPropertyValue(propertyName, value, className, referenceName, referenceType) {

    // first check if this is a reference
    console.log('REF NAME:', referenceName);
    console.log('REF TYPE: ', referenceType);
    if (typeof referenceName !== 'undefined') {
      return this._referenceDataForReference(referenceName, referenceType);
    }

    // get transform for swift class
    const transform = propertyValueTransform(className)[propertyName];

    if (typeof transform !== 'undefined') {
      // transform property value
      return transform(value) || value;
    }

    // just return value by default
    return value;
  }

  _referenceDataForReference(referenceName, referenceType) {

    console.log('REF NAME:', referenceName);
    console.log(this._referenceData);
    const refData = this._referenceData[referenceType].find(function(data) {
      return data.$.name === referenceName;
    });
    console.log(refData);

    return refTypeTransform[referenceType](refData);
  }
}

module.exports = SwiftClassGenerator;