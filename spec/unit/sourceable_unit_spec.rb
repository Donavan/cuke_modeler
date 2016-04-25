require 'spec_helper'

SimpleCov.command_name('Sourceable') unless RUBY_VERSION.to_s < '1.9.0'

describe 'Sourceable, Unit' do

  let(:nodule) { CukeModeler::Sourceable }
  let(:element) { Object.new.extend(nodule) }


  it 'has a source line - #source_line' do
    element.should respond_to(:source_line)
  end

end
