require 'mongo_mapper'

MongoMapper.database = ENV['mongo_db'] || 'prey_standalone_control_panel'

class Device
  include MongoMapper::Document

  key :name, String, :required => true
  key :device_type, String, :required => false
  key :os_version, String, :required => false
  key :os, String, :required => false
  key :key, String, :required => false
  key :missing, Boolean, :default => false
  key :delay, Integer, :default => 20, :in => 2..59
  key :module_list, String, :default => 'geo network session webcam'

end
