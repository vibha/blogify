FactoryGirl.define do

  factory :article do
    blog
    author
    category
    name 'Article One'
    description 'A sample article'

    factory :drafted_article, class: Article do
      workflow_state 'draft'
    end

    factory :published_article, class: Article do
      workflow_state 'published'
    end

    factory :article_with_published_date_in_past, class: Article do
      published_date Date.today.prev_month
    end

    factory :article_with_published_date_today, class: Article do
      published_date Date.today
    end

    factory :article_without_published_date, class: Article do
      published_date nil
    end
  end

end