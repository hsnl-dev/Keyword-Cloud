class KeywordCloudAPI < Sinatra::Base
  post '/api/v1/accounts/:uid/:course_id/folders/?' do
    content_type 'application/json'
    begin
      uid = params[:uid]
      halt 401 unless authorized_account?(env, uid)

      course_id = params[:course_id]
      new_folder_data = JSON.parse(request.body.read)
      saved_folder = CreateFolderForCourse.call(
        course_id: course_id,
        folder_type: new_folder_data['folder_type'],
        folder_url: new_folder_data['folder_url'])
    rescue => e
      logger.info "FAILED to create new folder: #{e.inspect}"
      halt 400
    end

    status 201
    saved_folder.to_json
  end
end
