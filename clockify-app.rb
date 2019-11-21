require "time_difference"

class Interface
    
    def self.header_display()
        puts "------ terminal Clockify ------"
    end

    def self.control_panel()
        puts "[1] Add Task [2] Dashboard"
    end

end

class Task 

    @@task_data []

    def initialize(name, category, description, start_time, end_time)
        @name = name
        @category = category
        @description = description
        @start_time = start_time
        @end_time = end_time
    end

    def add_task()
        print "Task Name: "
        name = gets.chomp.to_s
        print "Category: "
        category = gets.chomp.to_s
        print "Description: "
        description = gets.chomp.to_s
        start_time = Time.now
        Task.new(name, category, description, start_time, 0)
    end

end

# time1 = Time.now
# sleep 5
# time2 = Time.now

# diff = TimeDifference.between(time1, time2).humanize

# puts diff

