require_relative "../views/clockify-view"
require_relative "../models/clockify-model"


class ClockifyController

    def initialize
        @clockify_view = ClockifyView.new()
        @clockify_view.title
        @clockify_model = ClockifyModel.new(@clockify_view.get_api_key)
    end

    def start
        loop do
            system("clear")
            @clockify_view.title
            @clockify_view.short_entry_list(@clockify_model.get_entries_data)
            @clockify_view.control_panel
            input = gets.chomp
            case input
            when "1"
                description, project, billable = @clockify_view.new_entry_prompt
                @clockify_model.add_new_entry(description, project, billable)
            when "2"
                @clockify_model.stop_current
            when "3"
                # @clockify_view.list_entries(@clockify_model.get_entries_data)
                @clockify_view.list_table(@clockify_model.get_entries_data)
                @clockify_view.back_prompt
            when "x"
                break
            end
        end
    end

end
