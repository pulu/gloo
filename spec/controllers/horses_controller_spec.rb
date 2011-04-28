require 'spec_helper'

describe HorsesController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Horses")
    end

    describe "GET 'edit'" do
      before(:each) do
        @horse = Factory(:horse)
      end

      it "should be successsful" do
        get :edit, :id => @horse
        response.should be_success
      end

    end

  end

end
