# frozen_string_literal: true
class ThumbnailGeneratorJob
  include Sidekiq::Worker

  def perform(id)
    video = Video.find(id)

  end
end