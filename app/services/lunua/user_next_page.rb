# :nodoc:
class Lunua::UserNextPage

  def initialize(user, feature_page_searcher = Lunua::FullFeature)
    @user                  = user
    @feature_page_searcher = feature_page_searcher
  end

  def call
    @call ||= user_feature_next_page
  end

  def found_count
    all_pages.count
  end

  def current_index
    current_user_feature.page_index
  end

  private

  def all_pages
    return @all_pages if @all_pages
    call
    @all_pages
  end

  def user_feature_next_page
    if current_user_feature
      current_feature = current_user_feature.feature
      @all_pages      = pages(current_feature)
      page            = current_user_feature.get_next_page(@all_pages) # can be nil
    end

    while !page do
      current_feature       = ClosestFeatures.new.closest_for_user(@user)
      @all_pages            = pages(current_feature)
      @current_user_feature = @user.add_user_feature(feature: current_feature)
      page                  = @current_user_feature.get_next_page(@all_pages)
    end

    Lunua::FeaturePage.new(page, current_feature)
  end

  def pages(feature)
    @feature_page_searcher.pages_for_feature(feature)
  end

  def current_user_feature
    @current_user_feature ||= @user.user_features.last
  end

end
