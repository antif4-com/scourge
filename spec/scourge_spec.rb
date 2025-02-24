require "helper"

describe Scourge do
  context "config" do
    it "has a config" do
      Scourge.config
    end

    it "can be saved" do

    end

    it "can be loaded" do

    end

    it "automatically wraps !KEY values" do
      Scourge.initialize_scourge(make_fixture('config_with_bangkey.yaml'))

      key = Scourge.config['hosts']['keys']['test_host']['apikey']

      expect(key.class).to eq(Scourge::Key)
    end

    it "remembers the name of the config file" do
      file = make_fixture('config_with_bangkey.yaml')

      Scourge.initialize_scourge(file)

      expect(Scourge.sys_config[:config_name]).to eq(file)
    end
  end

end

describe Scourge::Key do
  it "has a key" do
    expect(Scourge::Key.new("key").key)
  end

  it "can save a key" do
    my_key = "<my super private key>"
    s_key = Scourge::Key.new(my_key)
    expect(s_key.key).to eq(my_key)
  end
end