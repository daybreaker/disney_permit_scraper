#*********** MODELS *****************

class Permit
  include DataMapper::Resource
  property :id,         Serial
  property :document_id,String, :unique_index => true
  property :type,       String
  property :grantor,    Text
  property :grantee,    Text
  property :legal,      Text
  property :detail_url, Text
  property :node_id,    String
  property :pdf_url,    Text
  property :status,     Flag[:new, :verified_bad, :verified_good, :unsure]
  property :notes,      Text
  property :rec_date,   DateTime
  property :created_at, DateTime
    
end

DataMapper.finalize.auto_upgrade!

#********* END MODELS ***************
