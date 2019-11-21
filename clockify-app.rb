require "time_difference"
require "date_format"

class Interface
    
    def self.header_display()
        puts "------ terminal Clockify ------"
    end

    def self.control_panel()
        puts "[1] Add Task [2] Dashboard"
    end

    def self.task_list()
        p Task.data
        gets
        for i in Task.data
            puts "----------"
            puts "#{i.name} (#{i.category})"
            puts "#{i.description}"
            puts "Start: #{i.start_time}"
            puts "End: #{i.end_time}"
            puts "Duration: #{TimeDifference.between(i.start_time, Time.now).humanize}"
        end 
    end

end

class Task 
    attr_reader :name, :category, :description, :start_time, :end_time

    @@data = []

    def initialize(name, category, description, start_time, end_time)
        @name = name
        @category = category
        @description = description
        @start_time = DateFormat.change_to(start_time, "MEDIUM_TIME")
        @end_time = "ongoing"
        @duration = 0
    end

    def self.add_task()
        system("clear")
        Interface.header_display()
        print "Task Name: "
        name = gets.chomp.to_s
        print "Category: "
        category = gets.chomp.to_s
        print "Description: "
        description = gets.chomp.to_s
        start_time = Time.now
        task = Task.new(name, category, description, start_time, 0)
        Task.data.push(task)
    end

    def self.data()
        @@data
    end

end

system("clear")

app_on = true
while app_on

    Interface.header_display()
    Interface.task_list()
    Interface.control_panel()
    answer = gets.chomp.to_s
    case answer
    when "1"
        Task.add_task()
    end

end


