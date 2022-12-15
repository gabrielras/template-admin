# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authenticate_user!, :authorize_user!

  private

  def authorize_user!
    raise Pundit::NotAuthorizedError, 'Você não possuí autorização' unless permitted_action
  end

  def permitted_action
    PermittedAction.result(user: current_user, action_name: action_name, controller_path: controller_path).valid
  end
end
