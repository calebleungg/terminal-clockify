require_relative "../views/clockify-view"
require_relative "../models/clockify-model"


class ClockifyController

    def initialize
        @clockify_view = ClockifyView.new()
    end

    def start
        @clockify_view.title
        @clockify_model = ClockifyModel.new(@clockify_view.get_api_key)
        loop do
            system("clear")
            @clockify_view.title
            @clockify_view.control_panel
            input = gets.chomp
            case input
            when "2"
                @clockify_view.list_entries(@clockify_model.get_entries_data(@clockify_model.auth, @clockify_model.workspace_id, @clockify_model.user_id))
                puts "---"
                puts "Press any key to return"
                gets
            when "x"
                break
            end
        end
    end

end
