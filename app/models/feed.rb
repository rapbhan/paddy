class Feed < ActiveRecord::Base

def self.create_from_url2(url)

end

def self.create_from_url(url)
	  response = read_xml(url)
	  if response.kind_of?(Net::HTTPSuccess)
	    doc = REXML::Document.new(response.body)		
		doc.elements.each("//rss/channel/item") {|element| 
		self.new do |new_record|
			element.each do |node|
			new_record.send("#{node.name}=", node.text)
			end
		new_record.save
		end
		}
	  end		
end

def self.read_xml(url)
	  uri = URI.parse(url)
	  http = Net::HTTP.new(uri.host, uri.port)
	  response = http.get(uri.path+'?'+uri.query)
	  return response
end
	
end
