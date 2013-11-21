require 'active_support/core_ext'
require 'nokogiri'
require 'XMLSimple'

doc = Nokogiri::XML(File.read ARGV.first)

#set listing id
$node_name = '//property'

doc.search($node_name).each do |listing|
  xml_file = listing.to_xml
  obj = XmlSimple.xml_in(xml_file, :ForceArray => false)
  File.write(obj['details']['provider-listingid'] + '.json', obj.to_json)
end