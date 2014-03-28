require 'spec_helper'

SimpleCov.command_name('ModelElement') unless RUBY_VERSION.to_s < '1.9.0'

describe 'ModelElement, Unit' do

  clazz = CukeModeler::ModelElement

  describe 'generic tests' do
    it_should_behave_like 'a modeled element', clazz
  end

end
