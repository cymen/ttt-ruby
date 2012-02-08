require 'selector'

describe Selector do
  before(:each) do
    @selector = Selector.new
  end

  it "horizontal should return the horizontal row index sets" do
    @selector.horizontal.sort.should eq([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
  end

  it "vertical should return the vertical row index sets" do
    @selector.vertical.sort.should eq([[1, 4, 7], [2, 5, 8], [3, 6, 9]])
  end

  it "diagonal should return the diagonal row index sets" do
    @selector.diagonal.sort.should eq([[1, 5, 9], [3, 5, 7]])
  end
end
