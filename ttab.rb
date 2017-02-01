require 'yaml'

table = YAML::load_file(File.join(__dir__, 'table.yaml'))

head_align = ""
header = ""
splitted_header = table['header'].split(/[[:blank:]]/)
splitted_header.count.times do |i|
  if(table['meta']['vertical_bar'] == i + 1)
    head_align += 'c|'
  else
    head_align += 'c'
  end
  if(i == 0)
    header += "$#{splitted_header[i]}$"
  else
    header += " & $#{splitted_header[i]}$"
  end
end

data = ""

table['data'].each do |row| 
  i = 0
  row.split(" ").each do |num|
    if(i == 0)
      data += "  #{num}"
    else 
      if(table['meta']['bold'] == i + 1)
        data += " & \\bf{#{num}}"
      else
        data += " & #{num}"
      end
    end
    i += 1
  end
  data += " \\\\ \n"
end

puts "\\begin{tabular}{#{head_align}}"
puts "  #{header} \\\\"
puts "  \\midrule"
puts "#{data}"
puts "\\end{tabular}"
