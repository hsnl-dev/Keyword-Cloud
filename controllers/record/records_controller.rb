require 'sinatra'

# find a document by its courseId and chapterid
# testcid = 848

class KeywordCloudAPI < Sinatra::Base
  get '/api/v1/mongo/:course_id' do
    content_type 'application/json'
    begin
      FindVideoRecord.call(course_id: params[:course_id])
      JSON.pretty_generate(status: 'success')
    rescue => e
      logger.info "FAILED to connect mongodb: #{e}"
      halt 404
    end
  end

  get '/api/v1/courses/keywords' do
    content_type 'application/json'
    begin
      course_id = Keyword.select(:course_id).map(&:course_id).uniq
      JSON.pretty_generate(data: course_id)
    rescue => e
      logger.info "FAILED to connect sqlite: #{e}"
      halt 404
    end
  end

  get '/api/v1/courses/keywords/:course_id' do
    content_type 'application/json'
    begin
      course_id = params[:course_id]
      keyword_record = Keyword.where(course_id: course_id).all
      keywordInfo = keyword_record.map do |k|
        {
          'id' => k.id,
          'chapter_id' => k.chapter_id,
          'chapter_name' => k.chapter_name,
          'folder_type' => k.folder_type,
          'priority' => k.priority,
          'keyword' => k.keyword
        }
      end
      JSON.pretty_generate(status: keywordInfo)
    rescue => e
      logger.info "FAILED to get keyword: #{e}"
      halt 404
    end
  end
end
