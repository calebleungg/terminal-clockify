require "date_format"

class ClockifyView
    
    def title
        puts "------ terminal Clockify ------"
        puts
        puts
    end

    def control_panel
        puts "[1] Add Entry [2] Stop Current Entry" 
        puts "[3] Dashboard [4] Refresh             [x] Quit"
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

    def format_date(date)
        utc_time = Time.parse(date).utc
        date_layout = DateFormat.change_to(utc_time, "MEDIUM_DATE")
        time_layout = DateFormat.change_to(utc_time, "MEDIUM_TIME")
        return "#{date_layout} | #{time_layout}"
    end

    def list_entries(data)
        for entry in data
            puts "Description: #{entry["description"]}"
            puts "Start Time: #{format_date(entry["timeInterval"]["start"])}"
            if entry["timeInterval"]["end"] == nil
                puts "End Time: Ongoing"
            else
                puts "End Time: #{format_date(entry["timeInterval"]["end"])}"
            end
            puts "Duration: #{entry["timeInterval"]["duration"]}"
            puts "------"
        end
    end

    def display_ongoing_entry(data)
        if data[0]["timeInterval"]["end"] == nil
            puts "------------------------------------------"
            puts "Description: #{data[0]["description"]}"
            puts "Start Time: #{format_date(data[0]["timeInterval"]["start"])}"
            puts "Status: Ongoing"
            puts "------------------------------------------"
            puts
        else
            puts "Last Entry"
            puts "------------------------------------------"
            puts "Description: #{data[0]["description"]}"
            puts "Start Time: #{format_date(data[0]["timeInterval"]["start"])}"
            puts "End Time: #{format_date(data[0]["timeInterval"]["end"])}"
            puts "Duration: #{data[0]["timeInterval"]["duration"]}"
            puts
            puts "Select [1] to start a new Entry"
            puts "------------------------------------------"
            puts
        end
    end

    def new_entry_prompt
        puts "Please enter the required details: "
        print "Description: "
        description = gets.chomp
        print "Project: "
        project = gets.chomp.capitalize
        print "Billable (true/false): "
        billable = gets.chomp.downcase
        return description, project, billable
    end

end
