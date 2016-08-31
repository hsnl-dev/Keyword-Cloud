# show keyword
class KeywordCloudAPI < Sinatra::Base
  get '/api/v1/accounts/:uid/:course_id/folders/slides/segment' do
    content_type 'application/json'

    begin
      uid = params[:uid]
      course_id = params[:course_id]
      halt 401 unless authorized_account?(env, uid)
      name = Course.where(id: course_id).first.course_name
      keyword = Hash.new
      folder_slides = Folder.where(course_id: params[:course_id], folder_type: 'slides').all
      folderInfo = folder_slides.map do |f|
        keyword.merge!({f.id => SlideSegment.call(folder_id: f.id)})
        SlideSegment.call(folder_id: f.id)
      end
      slides = keyword.map do |id, s|
        if s.any?
          chapter_id = Folder[id].chapter_id
          name = Folder[id].name
          json = SlideTfidf.call(arr: folderInfo, signal: s)
          CreateKeywordForChap.call(
            course_id: course_id,
            folder_id: id,
            chapter_id: chapter_id,
            chapter_name: name,
            folder_type: 'slides',
            keyword: json)
        end
      end
      JSON.pretty_generate(data: name, slides: slides)
    rescue => e
      logger.info "FAILED to process GET file document: #{e.inspect}"
      halt 404
    end
  end

  get '/api/v1/accounts/:uid/:course_id/keyword' do
    content_type 'application/json'
    begin
      uid = params[:uid]
      course_id = params[:course_id]
      halt 401 unless authorized_account?(env, uid)
      keywordInfo = Keyword.where(course_id: course_id).first
      # k = keywordInfo.map do |s|
      #   puts s
      #   # {
      #   #   'id' => s.id,
      #   #   'data' => {
      #   #     'course_id' => s['attributes'].course_id,
      #   #     'folder_id' => s['attributes'].folder_id,
      #   #     'folder_type' => s['attributes'].chapter_id
      #   #     'chapter_id' => s['attributes'].checksum
      #   #     'chapter_name' => s['attributes'].chapter_name
      #   #     'keyword' => s['attributes'].keyword
      #   #   }
      #   # }
      # end
      JSON.pretty_generate(data: keywordInfo)
    rescue => e
      logger.info "FAILED to find authorized courses for account: #{e}"
      halt 404
    end
  end
end
