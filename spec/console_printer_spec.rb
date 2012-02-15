require 'console_printer'

describe ConsolePrinter do
  it "can create the output for a row via a callback for each item with pipe as seperator" do
    ConsolePrinter::Writer.board_row [1, 2, 3] do |index|
      'x'
    end.should eq('x|x|x')
  end
end
