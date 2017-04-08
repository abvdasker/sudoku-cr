require "../spec_helper.cr"

describe Board do
  it "creates a copy of the input board" do
    input = [
      [1, 2, nil, nil, nil, nil, 9, nil, 3],
      [nil, nil, 4, nil, nil, nil, 1, nil, nil],
      [nil, 3, nil, nil, 4, nil, nil, nil, 2],
      [nil, nil, nil, nil, nil, 3, nil, nil, nil],
      [nil, nil, 1, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, 6, nil, nil, nil, nil, nil],
      [3, nil, 2, nil, nil, nil, nil, nil, 9],
      [nil, nil, nil, nil, 5, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, 7, nil, nil],
    ]
    original = Board.new(input)
    copy = original.duplicate
    copy.set(1, 1, 9)
    copy.get(1, 1).should eq 9
    original.get(1, 1).should eq nil
  end
end
