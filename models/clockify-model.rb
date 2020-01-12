require "httparty"

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

end
 