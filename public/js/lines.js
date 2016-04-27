/**
 * Text lines
 *
 * @module
 *
 * @param {object} options - setting of text lines
 * @param {object[]} options.format - n-th object is used to format n-th line
 * @param {string} options.format.textField - name of property will be used in function text()
 * @param {string} options.format.classed - classes used to apply to [text](http://www.w3.org/TR/SVG/text.html#TextElement)
 * @param {string} options.format.style - style used to apply to [text](http://www.w3.org/TR/SVG/text.html#TextElement)
 * @param {string} options.format.attr - attribute used to apply to [text](http://www.w3.org/TR/SVG/text.html#TextElement)
 * @param {object[]} options.centralFormat - like #format but used to format central-bubble
 */
d3.svg.BubbleChart.define("lines", function (options) {
  /*
   * @param
   *  options = {
   *    format: [ //n-th object is used to format n-th line
   *      {
   *        textField: #string, name of property will be used in function text(), @link
   *        classed: #object, @link
   *        style: #object, @link
   *        attr: #object, @link
   *      }
   *    ],
   *    centralFormat: [ //@see #format, but used to format central-bubble
   *    ]
   *  }
   * */

  var self = this;

   self.setup = (function () {
    var original = self.setup;
    return function () {
      var fn = original.apply(this, arguments);
      var node = self.getNodes();

      $.each(options.format, function (i, f) {
        node.append("text")
          .attr(f.attr)
          .classed(f.classed)
          .style(f.style)
          .attr("width", "500px")
          .attr("height", "300px")
          .text(function (d) {
            var str = d.item[f.textField];
            if (f.textField == "count")
            {
               str += " min";
             }  
            //str += f.textField;          
            if (str.length > 20) 
            {
              str = str.substring(0, 20) + "...";
            }
            return str; 
          });
      });
      return fn;
    };
  })();

  self.reset = (function (node) {
    var original = self.reset;
    return function (node) {
      var fn = original.apply(this, arguments);
      $.each(options.format, function (i, f) {
        var tNode = d3.select(node.selectAll("text")[0][i]);
        tNode.classed(f.classed).text(function (d) {
           var str = d.item[f.textField];
           if (f.textField == "count")
            {
               str += " min";
             }  
            if (str.length > 20) 
            {
              str = str.substring(0, 20) + "...";
            }
            return str; 
        })
          .transition().duration(self.getOptions().transitDuration)
          .style(f.style)
          .attr(f.attr);
      });
      return fn;
    };
  })();

  self.moveToCentral = (function (node) {
    var original = self.moveToCentral;
    return function (node) {
      var fn = original.apply(this, arguments);
      $.each(options.centralFormat, function (i, f) {
        var tNode = d3.select(node.selectAll("text")[0][i]);
        tNode.transition().duration(self.getOptions().transitDuration)
          .style(f.style)
          .attr(f.attr);
        f.classed !== undefined && tNode.classed(f.classed);
        f.textField !== undefined && tNode.text(function (d) {return d.item[f.textField];});
      });
      return fn;
    };
  })();
});