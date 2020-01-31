require 'puppet_x/external_data/cache/example'

describe Puppet_X::ExternalData::Cache::Example do
  let(:cache) { Puppet_X::ExternalData::Cache::Example.new }

  it 'has the correct methods' do
    expect(cache).to respond_to(:get)
    expect(cache).to respond_to(:delete)
    expect(cache).to respond_to(:update)
  end

  it 'can store data' do
    data = {
      'foo' => 'bar',
    }

    expect(cache.update('foo.example.com', data)).to be(data)
    expect(cache.get('foo.example.com')).to be(data)
  end

  it 'can delete data' do
    data = {
      'foo' => 'bar',
    }

    expect(cache.update('foo.example.com', data)).to be(data)
    expect(cache.get('foo.example.com')).to be(data)
    cache.delete('foo.example.com')
    expect(cache.get('foo.example.com')).to be(nil)
  end
end
