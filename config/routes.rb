Rails.application.routes.draw do
  get :health_checks, to: "application#health_checks"
end
