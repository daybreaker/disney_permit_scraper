require 'nokogiri'
require 'mechanize'
require "net/http"
require "uri"
require 'awesome_print'

module PermitScrape
  def get_permits(from,to)
    from ||= (Date.today - 1.day).strftime('%m/%d/%Y')
    to ||= Date.today.strftime('%m/%d/%Y')
    web_base = "http://or.occompt.com/recorder/web/"
    eagleweb_base = "http://or.occompt.com/recorder/eagleweb/"

    search = {
      'AllDocuments' => 'ALL',
      'docTypeTotal' => '49',
      'RecordingDateIDStart' => from,
      'RecordingDateIDEnd' => to,
      'BothNamesIDSearchType' => 'Exact Match',
      'GrantorIDSearchString' => 'walt disney world'
    }

    agent = Mechanize.new
    login_page = agent.get(web_base + "login.jsp")

    post_login_uri = web_base + "loginPOST.jsp?submit=I+Acknowledge&guest=true"
    login_result_page = agent.get(post_login_uri)

    search_page = agent.get(eagleweb_base + "docSearch.jsp")
    search_result_page = agent.post(eagleweb_base + "docSearchPOST.jsp",search)

    results = []
    Nokogiri::HTML(search_result_page.body).css("#searchResultsTable tbody tr").each_slice(3) do |row|
      link = row.first.css('td')[0].css('a').first.content.split("\n")
      
      results << {
        :type => link[0],
        :document_id => link[1],
        :detail_url => link['href'],
        :grantor => row.first.css('td')[2].at_css('b').next_sibling(),
        :grantee => row.first.css('td')[3].at_css('b').next_sibling(),
        :legal => row.first.css('td')[4].at_css('b').next_sibling(),
        :node_id => row.first.css('td')[5].at_css('a')['oid'],
        :pdf_url => eagleweb_base + "downloads/#{document_id}.pdf?id=#{node_id}.A0&parent=#{node_id}"
      }
    end
    results
  end
  
  module_function :get_permits
end
