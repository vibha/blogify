class Article < ActiveRecord::Base

  include Workflow

  belongs_to :blog
  belongs_to :author
  belongs_to :category

  workflow do
    state :new do
      event :save_as_draft, :transitions_to => :draft
    end
    state :draft do
      event :publish, :transitions_to => :published
      event :delete_article, :transitions_to => :deleted
    end
    state :published do
      event :save_as_draft, :transitions_to => :draft
      event :delete_article, :transitions_to => :deleted
    end
    state :deleted
  end

  def viewable?
    published_date.present? ? Date.today >= published_date : false
  end

end
