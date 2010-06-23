require 'fastercsv'

class Reports::AttendanceController < ApplicationController
  before_filter :login_required

  def index
    # FIXME: There's a clever AR way to do this, but f that noise
    week_hash = {}
    Camper.find(:all).each { |x| next unless x.troop; week_hash[x.troop.session] ?
      week_hash[x.troop.session] << x : week_hash[x.troop.session] = [x] }

    # Ditto here
    counselors_hash = {}
    Counselor.find(:all).each {|x| counselors_hash[x.merit_badge] = name}

    stream_csv('attendance_sheet.csv') do |csv|
      csv << ['Week', 'Troop', 'Name', 'Session Number', 'Merit Badge', 'Counselor']

      1.upto(4) do |week|
        next unless week_hash[week]

        week_hash[week].each do |camper|
          0.upto(5) do |mb|
            next unless camper.meritbadge(mb)
            csv << [week, camper.troop.number, camper.name, mb+1, 
                    camper.meritbadge_text(mb), counselors_hash[camper.meritbadge_text(mb)] || "(None)"]
          end
        end
      end

    end

  end


  def stream_csv(filename)
    #this is required if you want this to work with IE        
    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = 'public'
      headers["Content-type"] = "text/plain" 
      headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
      headers['Content-Disposition'] = "attachment; filename=\"#{filename}\"" 
      headers['Expires'] = "0" 
    else
      headers["Content-Type"] ||= 'text/csv'
      headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
    end

    render :text => Proc.new { |response, output|
      csv = FasterCSV.new(output, :row_sep => "\r\n") 
      logger.info "Rendering:\n#{csv}"
      yield csv
    }
  end

end
