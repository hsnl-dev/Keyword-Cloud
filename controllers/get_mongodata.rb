require 'sinatra'
require 'json' # required for .to_json
class KeywordCloudAPI < Sinatra::Base
  # find a document by its courseId and chapterid
  # testcid = 848  testchapterid = 5209
  get '/api/v1/mongo/:uid/:course_id/:chapter_id' do
    content_type :json
    begin
      data = GetMongoDataByCid.call(course_id: params[:course_id],chapter_id: params[:chapter_id])
    rescue => e
      logger.info "FAILED to connect mongodb: #{e}"
      halt 404
    end
  end
end
