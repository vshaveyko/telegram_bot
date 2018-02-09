require 'spec_helper'

RSpec.describe Lunua::UserNextPage do

  let(:user) do
    User.create(
      first_name: 'Vadim',
      current_position: [1,1]
    )
  end

  let(:page_searcher) do
    obj = Object.new

    def obj.pages_for_feature(feature)
      [
        { 'pageId' => '1' },
        { 'pageId' => '2' },
        { 'pageId' => '3' },
      ]
    end

    obj
  end

  it 'returns next page with correct indices' do
    next_page_finder = Lunua::UserNextPage.new(user, page_searcher)

    expect(next_page_finder.call.page).to include('pageId' => '1')
    expect(next_page_finder.current_index).to eq 1
    expect(next_page_finder.found_count).to eq 3

    user_feature = user.user_features.last
    expect(user_feature.checked_pages).to eq ["1"]
    expect(user_feature.has_next).to eq true

    next_page_finder = Lunua::UserNextPage.new(user, page_searcher)

    expect(next_page_finder.call.page).to include('pageId' => '2')
    expect(next_page_finder.current_index).to eq 2
    expect(next_page_finder.found_count).to eq 3

    user_feature = user_feature.reload
    expect(user_feature.checked_pages).to eq ["1", "2"]
    expect(user_feature.has_next).to eq true

    next_page_finder = Lunua::UserNextPage.new(user, page_searcher)

    expect(next_page_finder.call.page).to include('pageId' => '3')
    expect(next_page_finder.current_index).to eq 3
    expect(next_page_finder.found_count).to eq 3

    user_feature = user_feature.reload
    expect(user_feature.checked_pages).to eq ["1", "2", "3"]
    expect(user_feature.has_next).to eq false
  end

end
