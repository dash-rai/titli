# require 'json' # for when we use json

module Plot
  
  class Bar
    def add_html(script)
      header = File.read("header.html")
      footer = File.read("footer.html")
      puts header + script + footer #change this: return instead
    end
  end
  
  def Plot.bar(data_array) #define more options later. 
    bar = Bar.new
    script = <<D3
         var dataset = #{data_array}
         var svgWidth = 750;
         var svgHeight = 400;
         var barWidth = 20;
         var barSpacing = 2;
         var scalingFactor = 10;

         var svg = d3.select("body").append("svg")
                     .attr("width", svgWidth)
                     .attr("height", svgHeight);
         var bars = svg.selectAll("rect")
                       .data(dataset)
                       .enter()
                       .append("rect");
         var graph = bars.attr("x", function(d, i)
                   {
                 return i * (barWidth + barSpacing);
             })
             .attr("y", function(d) {
             return svgHeight - (d * scalingFactor);
         })
             .attr("width", barWidth)
             .attr("height", function(d) {
                  return d * scalingFactor;
             })
             .attr("fill", "teal");

D3
    
    return bar.add_html(script)
  end
  
end
