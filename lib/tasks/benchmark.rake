require 'benchmark'

namespace :benchmark do
  desc 'For testing sync and async action'

  task async: :environment do
    def sync_query
      user_1 = User.where(id: 1).complex_query
      user_2 = User.where(id: 2).complex_query
      user_3 = User.where(id: 3).complex_query
      sleep(2)
      user_1.first
      user_2.first
      user_3.first
    end

    def async_query
      user_1 = User.where(id: 1).complex_query.load_async
      user_2 = User.where(id: 2).complex_query.load_async
      user_3 = User.where(id: 3).complex_query.load_async
      sleep(2)
      user_1.first
      user_2.first
      user_3.first
    end

    ActiveRecord::Base.logger = nil
    puts '==== Benchmarking ===='
    Benchmark.bmbm do |b|
      b.report('sync') { sync_query }
      b.report('async') { async_query }
    end
  end
end
