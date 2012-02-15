module HtmlPrinter
  def self.print_board board, writer=Writer
    writer.display_board board
  end
  
  class Writer
    def self.display_board board, output_stream=$stdout
      row_indexes = board.get_horizontal_row_index_sets
      row_indexes.inject('') do |html, row_index|
        html << "<div class='row'>"
        (row_index.first..row_index.last).inject(html) do |row_html, index|
          row_html << "<div class='space' id='space_#{index}'>#{board.get index}</div>"
        end
        html << "</div>"
      end
    end
  end
end
