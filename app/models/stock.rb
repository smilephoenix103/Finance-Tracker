class Stock < ApplicationRecord
  before_save :adjust_ticker

  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex[:publishable_key],
      endpoint: "https://sandbox.iexapis.com/v1",
    )

    begin
      new(
        ticker: symbol.upcase,
        name: client.company(symbol).company_name,
        last_price: client.price(symbol),
      )
    rescue => ex
      return nil
    end
  end

  def self.check_db(symbol)
    where(ticker: symbol.upcase).first
  end

  private

  def adjust_ticker
    ticker.upcase!
  end
end
