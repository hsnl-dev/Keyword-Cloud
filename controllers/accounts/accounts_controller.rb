class KeywordCloudAPI < Sinatra::Base
  get '/api/v1/accounts/:uid' do
    content_type 'application/json'
    begin
      uid = params[:uid]
      halt 401 unless authorized_account?(env, uid)
      courseInfo = FindCourseAuth.call(uid: uid)
      JSON.pretty_generate(data: courseInfo)
    rescue => e
      logger.info "FAILED to find authorized courses for account: #{e}"
      halt 404
    end
  end
end
