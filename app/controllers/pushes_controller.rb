class PushesController < ApplicationController
  protect_from_forgery :except => :commit
  
  def commit
    # Grab the site
    @site = Site.find_by_gh_url(params['repository']['url'])
    
    if @site.nil?
      render :text => "Could not find site."
    else
      # Build the repository if necessary
      owner = params["repository"].delete("owner")
      if @site.repository.nil?
        repo = @site.build_repository(params["repository"])
        
        repo.owner = GhUser.find_by_email(owner["email"])
        if repo.owner.nil?
          repo.owner = repo.build_owner(owner)
        end
        
        repo.save
      else
        # Update the repository
        repo.update_attributes(params["repository"])
        
        if repo.owner.email != owner["email"]
          repo.owner = GhUser.find_by_email(owner["email"])
          if repo.owner.nil?
            repo.owner = repo.build_owner(owner)
          end
        end
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
      
      # Process the commits
      params["commits"].each do |raw_commit|
        raw_commit["gh_id"] = raw_commit.delete("id")
        author = raw_commit.delete("author")
        commit = @push.commits.build(raw_commit)
        
        commit.author = GhUser.find_by_email(author["email"])
        if commit.author.nil?
          commit.author = repo.build_owner(author)
        end
      end
      @push.save
      
      render :text => "OK"
    end
  end
end
