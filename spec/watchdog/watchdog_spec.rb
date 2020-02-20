require 'simplecov'
SimpleCov.start do
  add_filter "monkey.rb"
end

require 'edutils/watchdog'

RSpec.describe EDUtils::Watchdog do
  describe '#apply' do
    context 'multiple directories' do
      let(:base)     { 'watchdog'}
      let(:config)   { yml_fixture("#{base}/_watchdog.yml") }
      let(:expected) { yml_fixture("#{base}/expected.yml") }

      it 'produces expected output' do
        EDUtils::Watchdog::Path.new(config, fixture_path(base)).apply

        Dir.glob("**/*", base: fixture_path(base)).each do |path|
          next if path.eql?('_watchdog.yml') || path.eql?('expected.yml')

          fmode = File.stat(File.join(fixture_path(base), path)).mode & 0o07777
          emode = expected[path]

          expect(fmode).to eq(emode), "for file `#{path}' (#{fmode.to_s(8)}:#{emode.to_s(8)})"
        end
      end
    end
  end
end
