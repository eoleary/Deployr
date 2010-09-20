class PushesController < ApplicationController
  protect_from_forgery :except => :commit
  
  def commit
    # Grab the site
    @site = Site.find_by_gh_url(params['repository']['url'])
    
    if @site.nil?
      render :text => "Could not find site."
    else
      # Build the repository if necessary
      if @site.repository.nil?
        repo = @site.build_repository
        repo.name = params["repository"]["name"]
        repo.url = params["repository"]["url"]
        repo.pledgie = params["repository"]["pledgie"]
        repo.description = params["repository"]["description"]
        repo.watchers = params["repository"]["watchers"]
        repo.forks = params["repository"]["forks"]
        repo.private = params["repository"]["private"]
        
        repo.owner = GhUser.find_by_email(params["repository"]["owner"]["email"])
        if repo.owner.nil?
          repo.owner = repo.build_owner(params["repository"]["owner"])
        end
        
        repo.save
      else
        # Update the repository
        # TODO Update the repo
      end
      
      # Process the Push
      raw_push = params
      raw_push.delete("controller")
      raw_push.delete("action")
      @push = GhPush.new
      @push.before = params["before"]
      @push.after = params["after"]
      @push.ref = params["ref"]
      @push.payload = raw_push
      @push.repository = @site.repository
      @push.save
      
      # Process the commits structure
      params["commits"].each do |raw_commit|
        commit = Commit.new
        commit.gh_push = @push
        commit.gh_id = raw_commit["id"]
        commit.url = raw_commit["url"]
        commit.message = raw_commit["message"]
        commit.timestamp = raw_commit["timestamp"]
        commit.added = raw_commit["added"]
        commit.removed = raw_commit["removed"]
        commit.modified = raw_commit["modified"]
        
        commit.author = GhUser.find_by_email(raw_commit["author"]["email"])
        if commit.author.nil?
          commit.author = repo.build_owner(raw_commit["author"])
        end
        
        commit.save
      end
      
      render :text => "OK"
    end
  end
end
