require 'nokogiri'
require 'mechanize'
require "net/http"
require "uri"
require 'awesome_print'

class PermitScrape
  def initialize
    
  end
  
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
      link = row.first.css('td')[0].css('a').first
      link_text = link.content.split("\n")
      node_id = row.first.css('td')[5].at_css('a')['oid']
      results <<  Permit.first_or_create({:document_id => link_text[1]},{
        :type => link_text[0],
        :detail_url => link['href'],
        :grantor => row.first.css('td')[2].at_css('b').next_sibling(),
        :grantee => row.first.css('td')[3].at_css('b').next_sibling(),
        :legal => row.first.css('td')[4].at_css('b').next_sibling(),
        :node_id => node_id,
        :pdf_url => eagleweb_base + "downloads/#{link_text[1]}.pdf?id=#{node_id}.A0&parent=#{node_id}"
      })
    end
    results
  end
end
