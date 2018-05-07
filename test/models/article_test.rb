require './test/test_helper'

class ArticleTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  test 'article state machine' do
    article = create(:article)
    assert_equal 'new', article.workflow_state

    article.save_as_draft!
    assert_equal 'draft', article.workflow_state

    article.publish!
    assert_equal 'published', article.workflow_state

    article.delete_article!
    assert_equal 'deleted', article.workflow_state
  end

  test 'save article as a draft' do
    article = create(:article)
    assert_equal 'new', article.workflow_state

    article.save_as_draft!
    assert_equal 'draft', article.workflow_state
  end

  test 'publish a drafted article' do
    article = create(:drafted_article)
    assert_equal 'draft', article.workflow_state

    article.publish!
    assert_equal 'published', article.workflow_state
  end

  test 'delete drafted article' do
    article = create(:drafted_article)
    assert_equal 'draft', article.workflow_state

    article.delete_article!
    assert_equal 'deleted', article.workflow_state
  end

  test 'delete published article' do
    article = create(:published_article)
    assert_equal 'published', article.workflow_state

    article.delete_article!
    assert_equal 'deleted', article.workflow_state
  end

  test 'switch published article back to draft mode' do
    article = create(:published_article)
    assert_equal 'published', article.workflow_state

    article.save_as_draft!
    assert_equal 'draft', article.workflow_state
  end

  test 'viewable article with published_date in past' do
    article = create(:article_with_published_date_in_past)
    assert_equal true, article.viewable?
  end

  test 'viewable article if published_date is today' do
    article = create(:article_with_published_date_today)
    assert_equal true, article.viewable?
  end

  test 'non-viewable article without published_date' do
    article = create(:article_without_published_date)
    assert_equal false, article.viewable?
  end

end

