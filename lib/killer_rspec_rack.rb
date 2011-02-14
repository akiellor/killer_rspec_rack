require 'killer_rspec_rack/macros'
require 'killer_rspec_rack/matchers'

module KillerRspecRack
  def self.included base
    base.extend KillerRspecRack::Macros
    base.send :include, KillerRspecRack::Matchers
  end
end
