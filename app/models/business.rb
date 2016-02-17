class Business
    attr_reader :id
    attr_accessor :company_name, :company_profession, :company_street_address

    def initialize(hash)
    @id = hash["id"]
    @company_name = hash["company_name"] 
    @company_profession = hash["company_profession"] 
    @company_street_address = hash["company_street_address"] 
    end

    def destroy
      Unirest.delete("http://localhost:3000/businesses/#{id}", headers:{ "Accept" => "application/json"}).body

    end

    def self.find(id)
        Business.new(Unirest.get("http://localhost:3000/businesses/#{id}").body)
    end

    def self.all
    api_businesses_array = Unirest.get("http://localhost:3000/businesses").body
      businesses = []
      api_businesses_array.each do |api_business|
       businesses << self.new(api_business)
      end
      businesses
    # Unirest.get("http://localhost:3000/businesses").body.map {||}
    end

end