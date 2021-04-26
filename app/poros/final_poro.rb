class FinalPoro 
  attr_reader :id,
              :destination,
              :forecast,
              :salaries 
  
  def initialize(salary_info, weather_info, destination)
    @id = id
    @destination = destination
    @forecast = format_forecast(weather_info)
    @salaries = format_salaries(salary_info)
  end

  def format_forecast(weather_info)
    {summary: weather_info[:current][:weather].first[:description],
    temperature: "#{weather_info[:current][:temp].to_i} F"}
  end

  def format_salaries(salary_info)
    titles = ["Data Analyst", "Data Scientist", "Mobile Developer", "QA Engineer", "Software Engineer", "Systems Administrator", "Web Developer"]
    desired_jobs = []
    salary_info.each do |job|
      if titles.include?(job[:job][:title])
        desired_jobs << job
      end
    end
    desired_jobs.map{|job| SalaryBreakdown.new(job)}
  end
end