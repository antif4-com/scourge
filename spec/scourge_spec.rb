require "helper"

describe Scourge do
  context "config" do
    let(:base_config_scourge) do
      Scourge.initialize_scourge(FIXTURES[:BASE_CONFIG])
    end

    let(:bang_key_config_scourge) do
      Scourge.initialize_scourge(FIXTURES[:BANG_KEY_CONFIG])
    end

    let(:saved_config_scourge) do
      Scourge.initialize_scourge(FIXTURES[:WRITE_TEST])
    end

    it "has a config" do
      expect(Scourge.config)
    end

    it "has a sys config" do
      expect(Scourge.sys_config)
    end

    it "can be loaded" do
      base_config_scourge

      expect(Scourge.sys_config[:config_name]).to eq(FIXTURES[:BASE_CONFIG])
    end

    it "can be saved" do
      base_config_scourge

      expect(Scourge.save_config).to_not be_nil
    end

    it "can save to a different file" do
      base_config_scourge

      # first, it's not there, and the file we expect
      expect(Scourge.config['a_random_number']).to eq(nil)

      # so set it
      Scourge.config['a_random_number'] = 42

      Scourge.save_config(FIXTURES[:WRITE_TEST])

      saved_config_scourge

      # and now make sure it's still there
      expect(Scourge.config['a_random_number']).to eq(42)
      expect(Scourge.sys_config[:config_name]).to eq(FIXTURES[:WRITE_TEST])
    end

    it "can save things" do
      base_config_scourge

      # first, it's not there
      expect(Scourge.config['a_random_number']).to be(nil)
      expect(Scourge.config[:a_random_string]).to be(nil)
      expect(Scourge.config["a random object"]).to be(nil)

      # so set it
      Scourge.config['a_random_number'] = 42
      Scourge.config[:a_random_string] = "Forty-two"
      Scourge.config["a random object"] = {thething: Scourge::Key.new("abc") }

      # and now make sure it's still there
      expect(Scourge.config['a_random_number']).to eq(42)
      expect(Scourge.config[:a_random_string]).to eq("Forty-two")
      expect(Scourge.config["a random object"]).to be_a(Hash)
      expect(Scourge.config["a random object"][:thething].key).to eq("abc")
    end

    it "automatically wraps !KEY values" do
      bang_key_config_scourge

      key = Scourge.config['hosts']['keys']['test_host']['apikey']

      expect(key.class).to eq(Scourge::Key)
    end

    it "remembers the name of the config file" do
      bang_key_config_scourge

      expect(Scourge.sys_config[:config_name]).to eq(FIXTURES[:BANG_KEY_CONFIG])
    end
  end
end


describe Scourge::Key do
  it "has a key" do
    key = Scourge::Key.new(FIXTURES[:TEST_KEY])

    expect(key.key)
  end

  it "can save a key" do
    my_key = "<my super private key>"
    s_key = Scourge::Key.new(my_key)
    expect(s_key.key).to eq(my_key)
  end
end