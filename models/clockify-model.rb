require "httparty"
require "json"

class ClockifyModel

    attr_reader :auth, :user_id, :workspace_id

    def initialize(auth)
        @auth = auth
        @user_id = get_user_id(@auth)
        @workspace_id = get_workspace_id(@auth)
    end

    def get_user_id(auth)
        response = HTTParty.get("https://api.clockify.me/api/v1/user", :headers => {"X-Api-Key" => @auth})
        data = JSON.parse(response.body)
        return data["id"]
    end

    def get_workspace_id(auth)
        response = HTTParty.get("https://api.clockify.me/api/v1/workspaces", :headers => {"X-Api-Key" => @auth})
        data = JSON.parse(response.body)
        return data[0]["id"]
    end

    def get_entries_data(auth, workspace_id, user_id)
        response = HTTParty.get("https://api.clockify.me/api/v1/workspaces/#{workspace_id}/user/#{user_id}/time-entries", :headers => {"X-Api-Key" => auth})
    end

    def stop_current(auth, workspace_id, user_id)
        # time_now = Time.parse(Time.now.utc.to_s).iso8601

        time_now = {"end" => Time.parse(Time.now.utc.to_s).iso8601}.to_json

        HTTParty.patch("https://api.clockify.me/api/v1/workspaces/#{workspace_id}/user/#{user_id}/time-entries", 
            :headers => {"X-Api-Key" => auth, "Content-Type" => "application/json"},
            :body => time_now
        )
    end

end
 