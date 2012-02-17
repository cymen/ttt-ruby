module HtmlPrinter
  def self.print_board board, http_path, writer=Writer
    writer.display_board board, http_path
  end
  
  class Writer
    def self.display_board board, http_path, output_stream=$stdout
      row_indexes = board.get_horizontal_row_index_sets
      row_indexes.inject('') do |html, row_index|
        html << "<div class='row'>"
        (row_index.first..row_index.last).inject(html) do |row_html, index|
          if !board.get(index).nil?
            value = board.get(index)
          else
            value = "<a href='#{http_path}/#{index}'>?</a>"
          end
          row_html << "<div class='space' id='space_#{index}'>#{value}</div>"
        end
        html << "</div>"
      end
    end
  end
end
