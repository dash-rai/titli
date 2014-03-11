# require 'json' # for when we use json

module Plot
  
  class Bar
    #internal methods
    def add_html(script, height)
      header = File.read("/home/darshan/gsoc/code/titli/header.html")
      footer = File.read("/home/darshan/gsoc/code/titli/footer.html")
      result = header + script + footer
      File.open("/home/darshan/www/titli/output.html", 'w') { |file| file.write(result) }
      IRuby.html "<iframe src=http://localhost/titli/output.html width=500 height=#{height} style=\"border: none;\"></iframe>"
    end
  end
  
  def Plot.bar(data_array) #define more options later.
    bar = Bar.new
    scaling_factor = 1
    height = data_array.max * scaling_factor + 20 #padding
    script = <<D3
         var dataset = #{data_array}
         var svgWidth = 750;
         var svgHeight = #{height};
         var barWidth = 20;
         var barSpacing = 2;
         var scalingFactor = #{scaling_factor};

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
    
    return bar.add_html(script, height + 100)
  end
  
end
