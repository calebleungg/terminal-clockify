class ClockifyView
    
    def title
        puts "------ terminal Clockify ------"
        puts
        puts
    end

    def control_panel
        puts "[1] Add Task [2] Dashboard [3] Refresh [x] Quit"
    end

    def back_prompt
        puts "---"
        puts "Press Enter key to return"
        gets
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

    def display_ongoing_entry(data)
        if data[0]["timeInterval"]["end"] == nil
            puts "------------------------------------------"
            puts "Description: #{data[0]["description"]}"
            puts "Start Time: #{data[0]["timeInterval"]["start"]}"
            puts "Status: Ongoing"
            puts "------------------------------------------"
            puts
        else
            puts "------------------------------------------"
            puts "No Ongoing Entries"
            puts "Select [1] to start a new Entry"
            puts "------------------------------------------"
            puts
        end
    end

end
