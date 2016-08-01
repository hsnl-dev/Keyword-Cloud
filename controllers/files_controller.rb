class KeywordCloudAPI < Sinatra::Base
  post '/api/v1/accounts/:uid/:course_id/folders/:folder_id/files/?' do
    content_type 'application/json'
    begin
      uid = params[:uid]
      halt 401 unless authorized_account?(env, uid)

      new_data = JSON.parse(request.body.read)
      folder = Folder[params[:folder_id]]
      saved_file = CreateFileForFolder.call(
        folder: folder,
        filename: new_data['filename'],
        document: new_data['document'])
    rescue => e
      logger.info "FAILED to create new file: #{e.inspect}"
      halt 400
    end

    status 201
    saved_file.to_json
  end

  get '/api/v1/accounts/:uid/:course_id/folders/:folder_id' do
    content_type 'application/json'
    begin
      uid = params[:uid]
      course_id = params[:course_id]
      folder_id = params[:folder_id]
      halt 401 unless authorized_account?(env, uid)
      folder_name = Folder.where(id: folder_id).first.name
      folder_type = Folder.where(id: folder_id).first.folder_type
      simplefile = SimpleFile.where(folder_id: folder_id).all
      fileInfo = simplefile.map do |s|
        {
          'id' => s.id,
          'data' => {
            'filename' => s.filename,
            'document_encrypted' => s.document_encrypted,
            'checksum' => s.checksum
          }
        }
      end
      JSON.pretty_generate(course_id: course_id, folder_name: folder_name, folder_id: folder_id, folder_type: folder_type, data: fileInfo)
    rescue => e
      logger.info "FAILED to find secrets for user #{params[:owner_id]}: #{e}"
      halt 404
    end
  end

  # get '/api/v1/accounts/:uid/:course_id/folders/:folder_id/files/:file_id/?' do
  #   content_type 'application/json'
  #   begin
  #     uid = params[:uid]
  #     folder_id = params[:folder_id]
  #     file_id = params[:file_id]
  #     halt 401 unless authorized_account?(env, uid)
  #     doc_url = URI.join(@request_url.to_s + '/', 'document')
  #     simplefile = SimpleFile.where(folder_id: folder_id, id: file_id).first
  #     halt(404, 'Files not found') unless simplefile
  #     JSON.pretty_generate(data: {
  #                            file: simplefile,
  #                            links: { document: doc_url }
  #                          })
  #   rescue => e
  #     logger.info "FAILED to process GET file request: #{e.inspect}"
  #     halt 404
  #   end
  # end
  #
  # get '/api/v1/accounts/:uid/:course_id/folders/:folder_id/files/:file_id/document' do
  #   content_type 'text/plain'
  #
  #   begin
  #     SimpleFile.where(folder_id: params[:folder_id], id: params[:file_id])
  #               .first
  #               .document
  #   rescue => e
  #     logger.info "FAILED to process GET file document: #{e.inspect}"
  #     halt 404
  #   end
  # end
end
