module UsersHelper
  def format_date(date)
    if date
      date.strftime("%m/%d/%Y %I:%M %p")
    end
  end
end
