# :nodoc:
class QuestRedirectCountersController < ApplicationController

  def show
    redirect_to quest.quest_url
  end

private

  def quest
    Quest.find(params[:id])
  end

end
