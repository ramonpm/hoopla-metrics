require 'rails_helper'

describe Synchronizer do
  it 'raise error for unimplemented import' do
    expect { Synchronizer.import({}) }.to raise_error('not implemented!')
  end

  it 'calls import for each object on sync' do
    allow(Synchronizer).to receive(:import) { true }
    expect(Synchronizer).to receive(:import).twice
    Synchronizer.sync([{}, {}])
  end
end
