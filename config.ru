require 'rubygems'
require 'bundler/setup'

require 'models'
require 'routes'
require 'bowtie'

map "/devices" do
  run Prey::Standalone
end

map "/login" do
  BOWTIE_AUTH = {:user => 'admin', :pass => 'secret'}
  run Bowtie::Admin
end
