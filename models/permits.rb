#*********** MODELS *****************

class Permit
  include DataMapper::Resource
  property :id,         Serial
  property :document_id,String, :unique_index => true
  property :type,       String
  property :grantor,    String
  property :grantee,    String
  property :legal,      String
  property :detail_url, String
  property :node_id,    String
  property :pdf_url,    String
  property :status,     Flag[:new, :verified_bad, :verified_good, :unsure]
  property :notes,      String
  property :created_at, DateTime
  
  
end
