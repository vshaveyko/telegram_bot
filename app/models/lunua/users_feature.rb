# frozen_string_literal: true

# :nodoc:
class Lunua::UsersFeature < Sequel::Model(:alquillar_user_features)

  many_to_one :user, class: :User
  many_to_one :feature

  def before_create
    self.created_at ||= Time.now
    self.updated_at ||= Time.now
    super
  end

  #
  # TODO: pull to service ?
  #
  def get_next_page(pages)
    next_page        = nil
    next_page_index  = nil
    next_page_exists = false

    pages[page_index..-1].each.with_index do |page, index|
      if checked_pages.include?(page['pageId'].to_s)
        next
      end

      unless next_page
        next_page = page
        next
      end

      next_page_exists = true
      next_page_index  = page_index + index

      break
    end

    if next_page_exists == false
      next_page_index = pages.count
    end

    if next_page
      update(page_index:    next_page_index,
             has_next:      next_page_exists,
             checked_pages: checked_pages + [next_page['pageId']])
    else
      update(has_next: false)
    end

    next_page
  end

end
