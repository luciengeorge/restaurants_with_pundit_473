class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope.all # Restaurant.all
      if user.admin?
        scope.all
      else
        scope.where(user: user) # user == current_user
      end
    end
  end

  def create?
    user
  end

  def show?
    true
  end

  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
  end

  private

  def user_is_owner_or_admin?
    user == record.user || user.admin?
  end
end
