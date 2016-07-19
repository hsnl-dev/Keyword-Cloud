class KeywordCloudAPI < Sinatra::Base
  post '/api/v1/accounts/:uid/:course_id/concepts/?' do
    content_type 'application/json'
    begin
      uid = params[:uid]
      halt 401 unless authorized_account?(env, uid)

      course_id = params[:course_id]
      new_data = JSON.parse(request.body.read)
      saved_file = CreateConcepts.call(
        course_id: course_id,
        document: new_data['document'])
    rescue => e
      logger.info "FAILED to create new file: #{e.inspect}"
      halt 400
    end
    status 201
    saved_file.to_json
  end

  post '/api/v1/accounts/:uid/:course_id/slides/?' do
    content_type 'application/json'
    begin
      uid = params[:uid]
      halt 401 unless authorized_account?(env, uid)

      course_id = params[:course_id]
      new_folder_data = JSON.parse(request.body.read)
      saved_folder = CreateFolderForSlide.call(
        course_id: course_id,
        folder_url: new_folder_data['folder_url'])
    rescue => e
      logger.info "FAILED to create new folder: #{e.inspect}"
      halt 400
    end

    status 201
    saved_folder.to_json
  end
end
