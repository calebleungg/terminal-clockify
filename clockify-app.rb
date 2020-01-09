require "yaml"
require "time_difference"
require "date_format"

def load_yaml(yaml_file)
    data = []
    YAML.load_stream(File.read yaml_file) { |f| data << f }
    return data
end

class Interface
    
    def self.header_display()
        puts "------ terminal Clockify ------\n\n"
    end

    def self.control_panel()
        puts "[1] Add Task [2] Dashboard [x] Exit"
    end

    def self.task_list()
        for i in Task.data
            puts "#{i.name} (#{i.category})"
            puts "#{i.description}"
            puts "Start: #{DateFormat.change_to(i.start_time, "MEDIUM_DATE")} #{DateFormat.change_to(i.start_time, "MEDIUM_TIME")} "
            puts "End: #{i.end_time}"
            x = TimeDifference.between(i.start_time, Time.now).in_general

            puts "Duration: #{x[:hours]}h #{x[:minutes]}m #{x[:seconds]}s"
            puts "----------\n\n"
        end 
    end

end

class Task 
    attr_reader :name, :category, :description, :start_time, :end_time

    @@data = []

    def initialize(name, category, description, start_time)
        @name = name
        @category = category
        @description = description
        @start_time = start_time
        @end_time = "ongoing"
        @duration = 0
    end

    def self.add_task()
        print "Task Name: "
        name = gets.chomp.to_s
        print "Category: "
        category = gets.chomp.to_s
        print "Description: "
        description = gets.chomp.to_s
        start_time = Time.now
        task = Task.new(name, category, description, start_time)
        Task.data.push(task)
        data = load_yaml('task-data.yml')
        data[0].push({"name" => task.name, "category" => task.category, "description" => task.description, "start_time" => task.start_time})
        File.open("./task-data.yml", 'w') { |file| file.write(data[0].to_yaml, file) }
        p task.start_time
        gets
    end

    def self.data()
        @@data
    end

end



system("clear")

data = load_yaml('task-data.yml')
for i in data[0]
    task = Task.new(i["name"], i["category"], i["description"], i["start_time"])
    Task.data.push(task)
end



app_on = true
while app_on
    system("clear")

    Interface.header_display()
    Interface.task_list()
    Interface.control_panel()
    sleep 1

end


