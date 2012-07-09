require 'sinatra'
require 'builder'

module Prey

  REPORT_MODULES = %w(geo network session webcam)

  class Check_Update < Sinatra::Base

    post '/devices.xml' do

      newDevice = Device.new

      newDevice.name = params[:device][:title]
      newDevice.device_type = params[:device][:device_type]
      newDevice.os_version = params[:device][:os_version]
      newDevice.os = params[:device][:os]
      newDevice.key = SecureRandom.hex(12)
      newDevice.save
      generate_xml(newDevice)
      
    end

    get '/devices.xml' do
      content_type 'text/xml'

      key = 200

      Device.all.each do |device|

        if device.key == nil
          key = 401
        end
      end

      status key

      builder do |xml|
        xml.instruct!
        xml.devices do

          Device.all.each do |device|
            #generate_xml(device) #NOT WORKING
            xml.device do
              xml.key device.key
              xml.state device.missing
              xml.title device.name
            end
          end
        end
      end
    end

    def generate_xml(device)
      builder do |xml|
        xml.instruct!
        xml.device do
          xml.key device.key
          xml.state device.missing
          xml.title device.name
        end
      end
    end
  end

  class Setup_Verify < Sinatra::Base

    get '/:id.xml' do
      if device = Device.find(params[:id])
        content_type 'text/xml'
        status device.missing? ? 404 : 200
        generate_xml(device)
      else
        status 400 # bad request
      end
    end

    def generate_xml(device)
      builder do |xml|
        xml.instruct!
        xml.device do
          xml.status do
            xml.missing device.missing?
          end
          xml.configuration do
            xml.delay device.delay
          end
          xml.modules do
            device.module_list.split.each do |mod|
              xml.module :active => true, :name => mod.downcase, :type => module_type(mod) do
                xml.enabled true
              end
            end
          end
        end
      end
    end

    def module_type(mod)
      REPORT_MODULES.include?(mod.downcase) ? 'report' : 'action'
    end

  end

end
