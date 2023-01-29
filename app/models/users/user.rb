class User < ApplicationRecord
  scope :complex_query, -> { where('SELECT true FROM pg_sleep(2)') }
end
