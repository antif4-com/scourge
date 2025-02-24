require "helper"

describe Scourge do
  it "has a config" do
    Scourge.config
  end
end

describe Scourge::Key do
  it "has a key" do
    expect(Scourge::Key.new("key").key)
  end
end