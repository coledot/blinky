require 'cctray'
module Blinky
  module CCTrayServer
    def watch_cctray_server url, options = {}
      watched_project_name = options[:include]
      tray = CCTray.new(url, options[:user], options[:password])

      while true
        begin
          projects = tray.fetch
          watched_project_name ||= projects.first.name
          watched_project = projects.select{ |p| p.name == watched_project_name }.first
          light_for_project! watched_project
        rescue StandardError => e
          warning!
          puts e # fixme log
          sleep 30
        end

        sleep 1
      end
    end

    def light_for_project! project
      (warning!  ; return) if project.nil?
      (building! ; return) if project.activity == 'Building'

      mod_time = Time.parse project.last_build_time_str
      # no activity for 8 hours -> dim light
      intensity = ((Time.now - mod_time) <= 8*60*60) ? 192 : 32

      case project.last_build_status
        when 'Success' then success! intensity
        when 'Failed'  then failure! intensity
        else                warning! intensity
      end
    end
  end
end
