class ClockifyView
    
    def title
        puts "------ terminal Clockify ------\n\n"
    end

    def control_panel
        puts "[1] Add Task [2] Dashboard [3] Refresh [x] Quit"
    end

    def get_api_key
        puts "Login"
        puts "---"
        print "Enter API Key: "
        return gets.chomp
    end

    def list_entries(data)
        for entry in data
            puts "Description: #{entry["description"]}"
            puts "Start Time: #{entry["timeInterval"]["start"]}"
            puts "End Time: #{entry["timeInterval"]["end"]}"
            puts "Duration: #{entry["timeInterval"]["duration"]}"
            puts "------"
        end
    end

end
