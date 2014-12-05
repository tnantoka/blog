module Cacheable
  extend ActiveSupport::Concern

  private
    def cached(method)
      return send(method) if new_record?
      Rails.cache.fetch("#{cache_key}/#{method}") do
        send(method)
      end
    end
end

