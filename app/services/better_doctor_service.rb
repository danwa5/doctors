class BetterDoctorService
  include HTTParty

  base_uri Figaro.env.better_doctor_api_url

  format :json

  def self.call(search_params)
    new.call(search_params)
  end

  def call(search_params)
    if Rails.cache.exist?(search_params)
      JSON.parse(Rails.cache.read(search_params))
    else
      query = { user_key: Figaro.env.better_doctor_access_key }.merge(search_params)
      response = self.class.get('/doctors', query: query.symbolize_keys)
      Rails.cache.write(search_params, response.body, expires_in: 30.minutes)
      response.body
    end
  end
end
