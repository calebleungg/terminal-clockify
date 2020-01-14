require "date_format"
require "terminal-table"

class ClockifyView
    
    def title
        puts "------ Terminal Clockify ------"
        puts
        puts
    end

    def control_panel
        puts "[1] Add       [2] Stop " 
        puts "[3] History   [4] Refresh   [x] Quit"
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

    def date_only_format(date)
        utc_time = Time.parse(date).utc
        date_layout = DateFormat.change_to(utc_time, "MEDIUM_DATE")
        return date_layout
    end

    def time_only_format(date)
        utc_time = Time.parse(date).utc
        time_layout = DateFormat.change_to(utc_time, "MEDIUM_TIME")
        return time_layout
    end

    def format_duration(duration)
        letters = duration.length
        return duration[2..(letters-1)]
    end

    def list_table(data)
        rows = []
        live = []
        last_entry = ""
        for entry in data
            if date_only_format(entry["timeInterval"]["start"]) != last_entry
                rows.push([" ", " ", " ", " "])
                rows.push(["#{date_only_format(entry["timeInterval"]["start"])}\n------------", " ", " ", " "])
                last_entry = date_only_format(entry["timeInterval"]["start"])
            end
            if entry["timeInterval"]["end"] == nil
                rows.push([entry["description"], time_only_format(entry["timeInterval"]["start"]), "Ongoing", "    -    "])
            else
                rows.push([entry["description"], time_only_format(entry["timeInterval"]["start"]), time_only_format(entry["timeInterval"]["end"]), format_duration(entry["timeInterval"]["duration"])])
            end
        end

        if live.length > 0 
            table = Terminal::Table.new :rows => rows, :style => {:width => 80, :border_x => "="}
        else
            table = Terminal::Table.new :rows => rows, :style => {:width => 80, :border_x => "="} 
        end
        puts table
    end

    def short_entry_list(data)
        short_list = []
        count = 0
        rows = []
        live = []
        last_entry = ""
        until count == 6
            short_list.push(data[count])
            count += 1
        end

        for entry in short_list
            if date_only_format(entry["timeInterval"]["start"]) != last_entry
                rows.push([" ", " ", " ", " "])
                rows.push(["#{date_only_format(entry["timeInterval"]["start"])}\n------------", " ", " ", " "])
                last_entry = date_only_format(entry["timeInterval"]["start"])
            end
            if entry["timeInterval"]["end"] == nil
                rows.push([entry["description"], time_only_format(entry["timeInterval"]["start"]), "Ongoing", "    -    "])
            else
                rows.push([entry["description"], time_only_format(entry["timeInterval"]["start"]), time_only_format(entry["timeInterval"]["end"]), format_duration(entry["timeInterval"]["duration"])])
            end
        end

        if data[0]["timeInterval"]["end"] != nil
            live.push(["Press [1] to Add Entry", "Start Time", "End Time", "Duration"]) if live.length == 0
        end

        table = Terminal::Table.new :headings => live, :rows => rows, :style => {:width => 80, :border_x => "="}

        puts table

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
