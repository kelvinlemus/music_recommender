class TwitterProfilesController < ApplicationController
  helper_method :form

  def index
    @twitter_profiles = TwitterProfile.all.order("created_at DESC")
  end

  def create
    if form.validate(params[:twitter_profile])
      result = CreateTwitterProfileService.(form: form)
      if result.success?
        redirect_to twitter_profile_path(result[:model].id) and return
      else
        flash["notice"] = result["message"]
        render :new and return
      end
    else
      render :new and return
    end
  end

  def show
    @twitter_profile = TwitterProfile.find(params[:id])
  end

private
  def form
    @form ||= CreateTwitterProfileForm.new(TwitterProfile.new)
  end
end
