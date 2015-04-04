#!/usr/bin/env ruby
require 'zip'
require 'carmen'
require 'open-uri'
require 'net/http'
include Carmen


# Returns a collection of the subregions
# Needed because some countries are special snowflakes for geonames.org
# (US, CH, BE, GB, and GR ) 
def subregion_codes( country_code )
  codes = { } 
  carmen_subregions = Country.coded( country_code ).subregions.sort

  # puts carmen_subregions
  case country_code
  when 'US', 'CH', 'GB', 'BE', 'PS' # these ones follow the ISO standard    
    for i in 0 ... carmen_subregions.size
      codes[ carmen_subregions[i].code ] = carmen_subregions[i].name
    end
    return codes      
  when 'GB', 'GR' # these ones have crazy subregions
    codes = { } # Will do later
  else # These ones have their subregions numbered
    for i in 0 ... carmen_subregions.size
      codes[ (i+1).to_s.to_s.rjust(2, "0") ] = carmen_subregions[i].name
    end   
  end
  
  return codes # Functional style would be useful here. Sorry for the repetition and  not knowing how to do it on ruby.
end


# This method organizes the content from the geonames file for some country.
# Information about how the files are organized can be found in
# http://download.geonames.org/export/dump/readme.txt
def parse_country_content( spots, current_country )

  case current_country
  when 'GB', 'GR' # lol, too crazy for subregions. Will ask to the rest of the team later.
    return nil
  end

  country_codes = subregion_codes( current_country )
  
  spots.each do |spot|
    spot_features = spot.split( "\t" )
    if spot_features[6]=="P" and spot_features.size >= 3 and spot_features[7]!="PPLH"  and spot_features[7][0..2]=="PPL"
      # if the place is a population and it still exists (PPLH means dead)
      if spot_features[14]!="" and spot_features[14].to_i >= 15000 and spot_features[10].to_i < country_codes.size
        # if the population has >= 15000 habitants  and it is a valid region
        # puts "#{spot_features[1]}, #{spot_features[10]}"
        # puts "#{spot_features[1].class}, #{spot_features[10].class}"
        if country_codes[ spot_features[10] ]
          Location.create!( country: Country.coded( current_country ), region: country_codes[ spot_features[10] ], city: spot_features[1] )
        else
          Location.create!( country: Country.coded( current_country ), region: spot_features[10], city: spot_features[1] )
        end
      end
    end
  end
end



def create_zip_file( country_code )
  uri = "http://download.geonames.org/export/dump/#{country_code}.zip"
  country_data = open(uri).read
  country_zip_file = open("#{country_code}.zip", "wb") 

  # puts country_data.class
  country_zip_file.write(country_data)
  country_zip_file.close 
end


def seed_country( country_code = "" )
  puts Country.coded( country_code ) 

  create_zip_file( country_code ) 
  country_file = "#{country_code}.zip"

  Zip::File.open(country_file) do |zipfile|
    zipfile.each do |entry|
      if entry.name=="readme.txt"
        next
      end
      dest_file = entry.name

      if File.exist?(dest_file) then File.delete(dest_file) end
      
      entry.extract(dest_file)

      content = entry.get_input_stream.read.split( /\r?\n/ )

      parse_country_content( content, country_code )

      if File.exist?(dest_file) then File.delete(dest_file) end
    end
  end

  if File.exist?(country_file) then File.delete(country_file) end
end


def country_file_exists( country_code = "" )
  if country_code == ""
    return
  end
  url = URI.parse("http://download.geonames.org/export/dump/#{country_code}.zip")
  req = Net::HTTP.new(url.host, url.port)
  res = req.request_head(url.path)
  return res.code == "200"
end


def seed_world
  (0 ... Country.all.size).each do |i|
    country_code = Country.all[i].code
    if country_file_exists( country_code )
      seed_country( country_code )
    end
  end
end
  

# country_file = ARGV[0]
