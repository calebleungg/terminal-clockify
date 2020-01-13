require_relative "../views/clockify-view"
require_relative "../models/clockify-model"


class ClockifyController

    def initialize
        @clockify_view = ClockifyView.new()
        @clockify_view.title
        @clockify_model = ClockifyModel.new(@clockify_view.get_api_key)
        @auth = @clockify_model.auth
        @workspace_id = @clockify_model.workspace_id
        @user_id = @clockify_model.user_id
    end

    def start
        loop do
            system("clear")
            @clockify_view.title
            @clockify_view.display_ongoing_entry(@clockify_model.get_entries_data(@auth, @workspace_id, @user_id))
            @clockify_view.control_panel
            input = gets.chomp
            case input
            when "2"
                @clockify_model.stop_current(@auth, @workspace_id, @user_id)
            when "3"
                @clockify_view.list_entries(@clockify_model.get_entries_data(@auth, @workspace_id, @user_id))
                @clockify_view.back_prompt
            when "x"
                break
            end
        end
    end

end
