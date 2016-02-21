require 'spec_helper'

SimpleCov.command_name('Tag') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Tag, Unit' do

  clazz = CukeModeler::Tag

  it_should_behave_like 'a nested element', clazz
  it_should_behave_like 'a bare bones element', clazz
  it_should_behave_like 'a prepopulated element', clazz
  it_should_behave_like 'a sourced element', clazz
  it_should_behave_like 'a raw element', clazz


  it 'can be parsed from stand alone text' do
    source = '@a_tag'

    expect { @element = clazz.new(source) }.to_not raise_error
    @element.name.should == '@a_tag'
  end

  it 'provides a descriptive filename when being parsed from stand alone text' do
    source = 'bad tag text'

    expect { clazz.new(source) }.to raise_error(/'cuke_modeler_stand_alone_tag\.feature'/)
  end

  it 'stores the original data generated by the parsing adapter', :gherkin3 => true do
    tag = clazz.new('@a_tag')
    raw_data = tag.raw_element

    expect(raw_data.keys).to match_array([:type, :location, :name])
    expect(raw_data[:type]).to eq('Tag')
  end

  it 'stores the original data generated by the parsing adapter', :gherkin2 => true do
    tag = clazz.new('@a_tag')
    raw_data = tag.raw_element

    expect(raw_data.keys).to match_array(['name', 'line'])
    expect(raw_data['name']).to eq('@a_tag')
  end


  before(:each) do
    @element = clazz.new
  end


  it 'has a name' do
    @element.should respond_to(:name)
  end

  it 'can get and set its name' do
    @element.name = :some_name
    @element.name.should == :some_name
    @element.name = :some_other_name
    @element.name.should == :some_other_name
  end

  context 'tag output edge cases' do

    it 'is a String' do
      @element.to_s.should be_a(String)
    end

    it 'can output an empty tag' do
      expect { @element.to_s }.to_not raise_error
    end

  end

end
