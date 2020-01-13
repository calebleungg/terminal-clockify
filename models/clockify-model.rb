require "httparty"
require "json"

class ClockifyModel

    attr_reader :auth, :user_id, :workspace_id

    def initialize(auth)
        @auth = auth
        @user_id = get_user_id
        @workspace_id = get_workspace_id
    end

    def get_user_id
        response = HTTParty.get("https://api.clockify.me/api/v1/user", :headers => {"X-Api-Key" => @auth})
        data = JSON.parse(response.body)
        return data["id"]
    end

    def get_workspace_id
        response = HTTParty.get("https://api.clockify.me/api/v1/workspaces", :headers => {"X-Api-Key" => @auth})
        data = JSON.parse(response.body)
        return data[0]["id"]
    end

    def get_project_ids
        response = HTTParty.get("https://api.clockify.me/api/v1/workspaces/#{@workspace_id}/projects", :headers => {"X-Api-Key" => @auth})
        data = JSON.parse(response.body)

        project_ids = {}
        for entry in data
            project_ids[entry["name"]] = entry["id"]
        end
        return project_ids
    end

    def get_entries_data
        response = HTTParty.get("https://api.clockify.me/api/v1/workspaces/#{@workspace_id}/user/#{@user_id}/time-entries", :headers => {"X-Api-Key" => @auth})
    end

    def stop_current
        time_now = {"end" => Time.parse(Time.now.utc.to_s).iso8601}.to_json
        HTTParty.patch("https://api.clockify.me/api/v1/workspaces/#{@workspace_id}/user/#{@user_id}/time-entries", 
            :headers => {"X-Api-Key" => @auth, "Content-Type" => "application/json"},
            :body => time_now
        )
    end

    def add_new_entry(description, project, billable)
        new_entry = {
            "start": Time.parse(Time.now.utc.to_s).iso8601,
            "billable": billable,
            "description": description,
            "projectId": get_project_ids[project],
            "taskId": nil,
            "tagIds": nil
        }.to_json
        HTTParty.post("https://api.clockify.me/api/v1/workspaces/#{@workspace_id}/user/#{@user_id}/time-entries", 
            :headers => {"X-Api-Key" => @auth, "Content-Type" => "application/json"},
            :body => new_entry
        )
    end

end
 