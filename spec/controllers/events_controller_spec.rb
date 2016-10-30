require 'rails_helper'

RSpec.describe EventsController, type: :controller do
	describe "GET #index" do
	    it "responds successfully with an HTTP 200 status code" do
	      get :index
	      expect(response).to be_success
	      expect(response).to have_http_status(200)
	    end

	    it "renders the index template" do
	      events = Event.where('starts_at > ? and published_at is not null', Time.now)
	      get :index
	      expect(assigns(:events).count).to eq events.count
	    end

	    # it "loads all of the events into @events" do
	    #   event1, event2 = Event.create!, Event.create!
	    #   get :index

	    #   expect(assigns(:events)).to match_array([post1, post2])
	    # end
	    
	    # it "loads only today's posts into @posts" do
	    #   post1, post2 = Post.create!(created_at: 1.day.ago), Post.create!
	    #   get :index

	    #   expect(assigns(:posts)).to eq [post2]
	    # end
	    
	    # it "redirect to /login" do
	    #   expect(get :index).to redirect_to("/login")
	    # end
	end

end
