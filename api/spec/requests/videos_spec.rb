require 'rails_helper'

RSpec.describe "Videos", type: :request do

  let(:category) { create(:category) }

  let(:valid_attributes) {
    {
      title: Faker::Movie.title,
      category_id: category.id,
      file: fixture_file_upload("valid_video.mp4", "video/mp4"),
    }
  }

  let(:invalid_attributes) {
    {
      title: "",
      category_id: Faker::Lorem.word,
    }
  }

  describe "GET /videos" do
    it "renders a list of videos" do
      videos = create_list(:video, 2)

      get videos_url

      expect(status).to eq 200
      expect(body).to include(videos.sample.title)
      expect(JSON.parse(body).size).to eq videos.size
    end
  end

  describe "POST /videos" do
    context "with valid parameters" do
      it "creates a new Video" do
        expect {
          post videos_url, params: valid_attributes
        }.to change(Video, :count).by(1)
      end

      it "renders a JSON response with the new video" do
        post videos_url, params: valid_attributes

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(JSON.parse(body).keys).to include "id"
      end
    end

    context "with invalid parameters" do
      it "does not create a new Video" do
        expect {
          post videos_url, params: invalid_attributes
        }.to_not change(Video, :count)
      end

      it "renders a JSON response with errors for the new video" do
        post videos_url, params: invalid_attributes

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(JSON.parse(body).keys).to include "errors"
      end
    end
  end
end
