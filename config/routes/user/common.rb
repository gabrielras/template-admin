# frozen_string_literal: true

namespace :common do
  resources :dashboards, only: [:index]
  resources :notifications, only: [:index]
end
