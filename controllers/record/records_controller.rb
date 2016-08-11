require 'sinatra'

# find a document by its courseId and chapterid
# testcid = 848

class KeywordCloudAPI < Sinatra::Base
  get '/api/v1/mongo/:uid/:course_id' do
    content_type :json
    begin
      uid = params[:uid]
      halt 401 unless authorized_account?(env, uid)
      FindVideoRecord.call(course_id: params[:course_id])
      JSON.pretty_generate(status: 'success')
    rescue => e
      logger.info "FAILED to connect mongodb: #{e}"
      halt 404
    end
  end
end
