require "csv"
require 'google/apis/civicinfo_v2'
require "erb"
require "date"

hourly_distribution = Array.new(24, 0)
weekly_distribution = Array.new(7, 0)

def clean_zipcodes(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
end

def correct_phonenumber_format(number)
    i = 0
    correct_number = []
    number.split("").each do |x|
        correct_number[i] = x[/\d+/]
        i += 1
    end
    correct_number.compact.join("")
end

def clean_phonenumbers(phone)
    if phone.length < 10
        phone = "bad number"
    elsif (phone.length == 11)
        if phone[0] == 1
            phone = [1..10]
        else
            phone = "bad number"
        end
    elsif phone.length > 11
        phone = "bad number"
    else
        phone
    end
end

def legislators_by_zipcodes(zip)

    civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
    civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

    begin
        civic_info.representative_info_by_address(
                                address: zip,
                                levels: 'country',
                                roles: ['legislatorUpperBody', 'legislatorLowerBody']
                                ).officials  
        rescue
            "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
        end
end

def save_thank_you_letters(id,form_letter)
    Dir.mkdir("output") unless Dir.exists?("output")
  
    filename = "output/thanks_#{id}.html"
  
    File.open(filename,'w') do |file|
      file.puts form_letter
    end
end

def get_hour(datetime)
    time = DateTime.strptime(datetime, '%m/%d/%Y %H:%M')
    time.hour
end

def get_day(datetime)
    time = DateTime.strptime(datetime, '%m/%d/%Y %H:%M')
    time.wday
end

def hours_tabulation(time)
    puts "Time      No. of People"
    for i in 1..23 do
        puts "#{i}:00      #{time[i]}"
    end
end


template_letter = File.read "form_letter.html"
erb_template = ERB.new template_letter

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

i = 0
hours = []
contents.each do |row|

    id = row[0]
    name = row[:first_name]
    reg_time = row[:regdate]
    phone = correct_phonenumber_format(row[:homephone])

    zipcode = clean_zipcodes(row[:zipcode])
    legislators = legislators_by_zipcodes(zipcode)
    correct_number = clean_phonenumbers(phone)

    hours[i] = get_hour(reg_time)
    i += 1
    
    days = get_day(reg_time)
    
    form_letter = erb_template.result(binding)
    
    save_thank_you_letters(id,form_letter)

end


hours.each do |time|
    for i in 1..23 do 
        if time == i
            hourly_distribution[i] += 1
        end
    end
end

hours_tabulation(hourly_distribution)
