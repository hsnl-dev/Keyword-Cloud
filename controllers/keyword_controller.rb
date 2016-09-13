# show keyword
class KeywordCloudAPI < Sinatra::Base
  get '/api/v1/accounts/:uid/:course_id/:chapter_id/makekeyword' do
    content_type 'application/json'

    begin
      uid = params[:uid]
      course_id = params[:course_id]
      halt 401 unless authorized_account?(env, uid)
      coursename = Course.where(id: course_id).first.course_name
      keyword = Hash.new
      chap_folder = Folder.where(course_id: params[:course_id], chapter_id: params[:chapter_id]).all
      folderInfo = chap_folder.map do |f|
        keyword.merge!({f.id => SlideSegment.call(folder_id: f.id)})
        keyword[f.id]
      end
      info = keyword.map do |id, s|
        if s.any?
          chapter_id = Folder[id].chapter_id
          folder_type = Folder[id].folder_type
          if folder_type == 'slides'
            priority = 2
          elsif folder_type == 'subtitles'
            priority = 1
          end
          name = Folder[id].name
          json = SlideTfidf.call(arr: folderInfo, signal: s)
          CreateKeywordForChap.call(
            course_id: course_id,
            folder_id: id,
            chapter_id: chapter_id,
            chapter_name: name,
            folder_type: folder_type,
            priority: priority,
            keyword: json)
        end
      end
      JSON.pretty_generate(data: coursename, content: info)
    rescue => e
      logger.info "FAILED to make keyword: #{e.inspect}"
      halt 404
    end
  end

  get '/api/v1/accounts/:uid/:course_id/:chapter_id/showkeyword' do
    content_type 'application/json'
    begin
      uid = params[:uid]
      course_id = params[:course_id]
      chapter_id = params[:chapter_id]
      halt 401 unless authorized_account?(env, uid)
      name = Course.where(id: course_id).first.course_name
      if Keyword.where(course_id: course_id, chapter_id: chapter_id, priority: 1).first
        content = Keyword.where(course_id: course_id, chapter_id: chapter_id, priority: 1).first
      else
        content = Keyword.where(course_id: course_id, chapter_id: chapter_id, priority: 2).first
      end
      JSON.pretty_generate(data: name, content: content)
    rescue => e
      logger.info "FAILED to show keyword: #{e.inspect}"
      halt 404
    end
  end
end
