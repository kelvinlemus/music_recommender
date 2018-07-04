class TwitterProfilesController < ApplicationController
  helper_method :form

  def create
    if form.validate(params[:twitter_profile])
    else
      render :new and return
    end
  end

private
  def form
    @form ||= CreateTwitterProfileForm.new(TwitterProfile.new)
  end
end
