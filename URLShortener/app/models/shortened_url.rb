# == Schema Information
#
# Table name: shortened_urls
#
#  id           :bigint           not null, primary key
#  short_url    :string           not null
#  long_url     :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  submitter_id :integer          not null
#
class ShortenedUrl < ApplicationRecord
    validates :short_url, :long_url, presence: true, uniqueness: true

    belongs_to :submitter,
        primary_key: :id,
        foreign_key: :submitter_id,
        class_name: :User


    def self.random_code
        short_url = SecureRandom.urlsafe_base64
        until !ShortenedUrl.exists?(short_url)
            short_url = SecureRandom.urlsafe_base64
        end
        short_url
    end

    after_initialize do |url|
        @short_url = self.generate_short_url if url.new_record?
    end

    # private
    def generate_short_url
        ShortenedUrl.random_code
    end
end
