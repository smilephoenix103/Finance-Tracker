class Stock < ApplicationRecord
  def self.new_lookup(symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex[:publishable_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )

    begin
      new(
        ticker: symbol,
        name: client.company(symbol).company_name,
        last_price: client.price(symbol)
      )
    rescue => ex
      return nil
    end
  end
end
