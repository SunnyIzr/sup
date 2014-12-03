module ApplicationHelper
  def hour_time(num)
    if num < 12
      "#{num}am"
    elsif num == 12
      "#{num}pm"
    else
      num -= 12
      "#{num}pm"
    end
  end
end
