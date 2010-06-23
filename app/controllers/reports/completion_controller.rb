require 'fastercsv'

class Reports::CompletionController < ApplicationController
  before_filter :login_required

  def index
    campers = Camper.find(:all).detect {|x| x.troop}
    logger.debug campers

    # Ditto here
    counselors_hash = {}
    Counselor.find(:all).each {|x| counselors_hash[x.merit_badge] = name}

    stream_csv('completion_sheet.csv') do |csv|
      csv << ['Week', 'Troop', 'Name', 'Session Number', 'Merit Badge']

      0.upto(6) do |mb|
        Camper.find(:all).each do |camper|
          next unless camper.meritbadge(mb) and camper.troop
          csv << [camper.troop.session, camper.troop.number, camper.name, mb+1, 
            camper.meritbadge_text(mb)] 
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
