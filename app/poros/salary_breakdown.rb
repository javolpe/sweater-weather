class SalaryBreakdown
  attr_reader :title,
              :min,
              :max

  def initialize(data)
    @title = data[:job][:title]
    @min = format_min(data[:salary_percentiles][:percentile_25])
    @max = format_max(data[:salary_percentiles][:percentile_75])
  end

  def format_min(data)
    sprintf("$%2.2f", data)
  end

  def format_max(data)
    sprintf("$%2.2f", data)
  end

end