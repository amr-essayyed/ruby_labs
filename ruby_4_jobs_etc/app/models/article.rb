# == Schema Information
#
# Table name: articles
#
#  id            :integer          not null, primary key
#  archived      :boolean          default(FALSE), not null
#  body          :text
#  reports_count :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Article < ApplicationRecord
    belongs_to :user
    has_one_attached :image

    def report!
        increment!(:reports_count)
        archive! if reports_count >= 3
    end

    def archive!
        update!(archived: true)
    end
end
