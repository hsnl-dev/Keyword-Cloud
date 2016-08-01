require 'sinatra'
require 'mongo'
require 'json'
require 'csv'

class GetMongoDataByCid < Sinatra::Base
  def self.call(course_id:,chapter_id:)
    Mongo::Logger.logger.level = ::Logger::FATAL

    db = Mongo::Client.new( ENV['MONGODB_HOSTNAME'], :database => ENV['MONGODB_DATABASE'])
    data = db[ENV['MONGODB_COLLECTION_NAME']]
           .find({'courseId' => course_id.to_i,
                  'chapterId' => chapter_id.to_i,
                  'action' =>'seek'
                  }).limit(100).to_a
    # 目前用course_id = 848  chapter_id = 5209
    # 只抓出action = "seek"的100筆資料然後寫成.csv檔，再存到mongodb的資料夾，之後會回傳"success"
    # 之後還要修改：資料筆數、以及不需要用chapter_id

    #userId,videoStartTime,videoEndTime,videoTotalTime,videoId,time
    csv_path = "mongoDB/"+course_id+".csv"
    CSV.open(csv_path, "w") do |csv|
      csv << ["userId", "videoStartTime", "videoEndTime", "videoTotalTime","videoId","time"]
      data.each do |data_tmp|
        csv << [data_tmp["userId"] , data_tmp["videoStartTime"], data_tmp["videoEndTime"], data_tmp["videoTotalTime"],data_tmp["videoId"],data_tmp["time"].iso8601]
      end
    end
    "success".to_json
  end
end
