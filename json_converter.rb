require 'active_support/core_ext'
require 'nokogiri'
require 'XMLSimple'

doc = Nokogiri::XML(File.read "test.xml")

xml_files = []
doc.search('//property').each do |listing|
  xml_file = listing.at('provider-listingid').text + '.xml'
  xml_files << xml_file
  File.write(xml_file, listing.to_xml)
end


xml_files.each do |file|
  obj = XmlSimple.xml_in(File.read(file), :ForceArray => false)
  File.write(obj['details']['provider-listingid'] + '.json', obj.to_json)
end